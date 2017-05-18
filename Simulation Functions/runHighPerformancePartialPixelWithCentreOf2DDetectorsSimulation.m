function [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsSimulation(simulation, simulationRun, app, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, parallelForSlices, parallelForAngles, parallelForPerAngleTranslation, parallelForDetector)
% [] = runHighPerformancePartialPixelWithCentreOf2DDetectorsSimulation(simulation, simulationRun, app, slices, angles, numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors, parallelForSlices, parallelForAngles, parallelForPerAngleTranslation, parallelForDetector)

indexingLevels = [numSlices, numAngles, zNumSteps, xyNumSteps, zNumDetectors, xyNumDetectors];
parallelFlags = [...
    parallelForSlices,...
    parallelForAngles,...
    parallelForPerAngleTranslation,...
    parallelForPerAngleTranslation,...
    parallelForDetector,...
    parallelForDetector];

multTemp = [...
    parallelForSlices * numSlices,...
    parallelForAngles * numAngles,...
    parallelForPerAngleTranslation * zNumSteps,...
    parallelForPerAngleTranslation * xyNumSteps,...
    parallelForDetector * xyNumDetectors,...
    parallelForDetector * zNumDetectors];

numParallelNumTraces = prod(multTemp(parallelFlags));
numNonParallelNumTraces = prod(multTemp(~parallelFlags));

if numNonParallelNumTraces == 0
    numNonParallelNumTraces = 1; %need at least 1 run (to allow the non-parallel to go)
end

for i=1:numNonParallelNumTraces
    nonParallelIndices = getIndices(i, indexingLevels, ~parallelFlags);
    
    parallelBeamTraceIndices = repmat(nonParallelIndices, numParallelNumTraces, 1);
    
    % set parallel params
    
    for j=1:numParallelNumTraces
        parallelIndices = getIndices(j, indexingLevels, parallelFlags);
        
        for k=1:6
            if parallelFlags(k)
                parallelBeamTraceIndices(j,k) = parallelIndices(k);
            end
        end
        
    end
    
    % copy out variables to avoid unecesary broadcasting
        
    scatteringNoiseLevel = simulation.scatteringNoiseLevel;
    detectorNoiseLevel = simulation.detectorNoiseLevel;
    partialPixel = simulation.partialPixelModelling;
    partialPixelResolution = simulation.partialPixelResolution;
    
    %beamCharacterization = parallel.pool.Constant(simulation.scan.beamCharacterization);
    
    %phantomData = parallel.pool.Constant(simulation.phantom.dataSet.data);
    phantomDims = simulation.phantom.getDataSetDimensions();
    voxelDimsInM = simulation.phantom.getVoxelDimensionsInM();
    phantomLocationInM = simulation.phantom.getLocationInM();
    
    sourceDirectionUnitVector = []; %unneeded
    displayDetectorRayTrace = false;
    axesHandle = []; % unneeded
    
    source = simulation.source;
    scan = simulation.scan;
    detector = simulation.detector;
    
    beamCharacterization = simulation.scan.beamCharacterization;
    calibratedPhantomData = simulation.scan.beamCharacterization.calibratedPhantomDataSet{1};
        
    [pointSourceCoords, pointDetectorCoords] = calculateSourceAndDetectorCoords(parallelBeamTraceIndices);
    
    fn = @(sourceCoords, detectorCoords) fastRayTrace(...
        sourceCoords, detectorCoords,...
        phantomLocationInM, phantomDims, voxelDimsInM,...
        calibratedPhantomData, beamCharacterization);
    
    detectorData = arrayfun(fn, pointSourceCoords, pointDetectorCoords);
               
    writeDetectorDataToDisk(detectorData, simulationRun.savePath, parallelBeamTraceIndices, parallelFlags, indexingLevels, angles);
end

end


function [pointSourceCoords, pointDetectorCoords] = calculateSourceAndDetectorCoords(indices, sourcePositionInM, detectorPositionInM, slicesInM, anglesInDeg, perAngleStepDimsInM, numPerAngleSteps, detectorDimsInM, detectorMovesWithScanAngle, detectorMovesWithPerAngleSteps)
        
        slicePosition = slices(indices(1));
        angle = angles(indices(2));
        zStep = indices(3);
        xyStep = indices(4);
        zDetector = indices(5);
        xyDetector = indices(6);
        
        % pre-allocate
        numCoords = length(parallelBeamTraceIndices);
        
        pointSourceCoords = zeros(numCoords,3);
        pointDetectorCoords = zeros(numCoords,3);
        
        % set intial positions
        [sourceAngleInRad, sourceRadius] = cart2pol(sourcePositionInM(1), sourcePositionInM(2));
        [detectorAngleInRad, detectorRadius] = cart2pol(detectorPositionInM(1), detectorPositionInM(2));
        
        sourceAngleInDeg = sourceAngleInRad * Constants.rad_to_deg;
        detectorAngleInDeg = detectorAngleInRad * Constants.rad_to_deg;
        
        % imagine source and detector centres are along positive x-axis
        % now, will rotate everything back later
        pointSourceCoords(:,1) = sourceRadius;
        pointSourceCoords(:,3) = slices(indices(1,:));
        
        pointDetectorCoords(:,1) = detectorRadius;
        pointDetectorCoords(:,3) = slices(indices(1,:));
             
        % SOURCE
        
        % per angle steps
        pointSourceCoords(:,2) = pointSourceCoords(:,2) + ((indices(4,:)-numPerAngleSteps(1)/2) * perAngleStepDimsInM(1));
        pointSourceCoords(:,3) = pointSourceCoords(:,3) + ((indices(3,:)-numPerAngleSteps(2)/2) * perAngleStepDimsInM(2));
        
        % rotate with the scan angle and bring back from x-axis
        [pointSourceCoords(:,1), pointSourceCoords(:,2)] = rotateCoordsAboutOrigin(pointSourceCoords(1),pointSourceCoords(2), sourceAngleInDeg - angles(indices(2,:)));
        
        % DETECTOR
        
        % per angle steps
        if detectorMovesWithPerAngleSteps
            % NOTE: indices for xy steps are negated, so that detector
            % matches source movement (which is opposite it)
            pointDetectorCoords(:,2) = pointDetectorCoords(:,2) + ((-(indices(4,:)-numPerAngleSteps(1)/2)) * perAngleStepDimsInM(1));
            pointDetectorCoords(:,3) = pointDetectorCoords(:,3) + ((indices(3,:)-numPerAngleSteps(2)/2) * perAngleStepDimsInM(2));
        end
        
        % detector placement (for planar 2D detectors only)
        % gives location of detector centre
        
        
end

function [x, y] = rotateCoordsAboutOrigin(x, y, anglesInDeg)
    tempX = x;
    
    x = x .* cosd(anglesInDeg) - y .* sind(anglesInDeg);
    y = y .* cosd(anglesInDeg) + tempX .* sind(anglesInDeg);
end