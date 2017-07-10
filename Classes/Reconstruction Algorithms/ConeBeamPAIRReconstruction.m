classdef ConeBeamPAIRReconstruction < Reconstruction
    % ConeBeamPAIRReconstruction
    
    properties
        displayName = 'PAIR Algorithm'
        fullName = 'PAIR Algorithm (CBCT)'

        rayTraceMatricesLoadPath = ''

        rayTraceMatricesSavePath = ''
        rayTraceMatricesSaveFileName = ''

        alphaMatricesLoadPath = ''

        alphaMatricesSavePath = ''
        alphaMatricesSaveFileName = ''
        
        numberPartitions = 1
        numberIterations = 1
        numberAverages = 1;
    end
    
    methods(Static)
        function handle = getSettingsTabHandle(app)
            handle = app.ConeBeamPAIR_SettingsTab;
        end
    end
    
    methods
        function string = getNameString(recon)
            string = 'CBCT PAIR';
        end     
        
        function recon = createFromGUIForSubClass(recon, app)
            % no GUI fields yet
            recon.numberPartitions = app.CBCT_PAIR_NumberPartitionsEditField.Value;
            recon.numberIterations = app.CBCT_PAIR_NumberIterationsEditField.Value;
            recon.numberAverages = app.CBCT_PAIR_NumberAveragesEditField.Value;
        end
        
        function app = setGUI(recon, app)
            % set visible tab
            hideAllAlgorithmSettingsTabs(app);
            
            tabHandle = recon.getSettingsTabHandle(app);
            tabHandle.Parent = app.ReconstructionAlgorithmSettingsTabGroup;
            
            % set settings
            if ~isempty(recon.rayTraceMatricesLoadPath)
                app.CBCT_PAIR_RayTraceMatricesSavePathEditField.Value = recon.rayTraceMatricesLoadPath;
            elseif ~isempty(recon.rayTraceMatricesSavePath)
                app.CBCT_PAIR_RayTraceMatricesSavePathEditField.Value = makePath(recon.rayTraceMatricesSavePath, recon.rayTraceMatricesSaveFileName);
            else
                app.CBCT_PAIR_RayTraceMatricesSavePathEditField.Value = 'Ray Trace Matrices will not be saved or loaded';
            end
            
            
            if ~isempty(recon.alphaMatricesLoadPath)
                app.CBCT_PAIR_AlphaMatricesSavePathEditField.Value = recon.alphaMatricesLoadPath;
            elseif ~isempty(recon.alphaMatricesSavePath)
                app.CBCT_PAIR_AlphaMatricesSavePathEditField.Value = makePath(recon.alphaMatricesSavePath, recon.alphaMatricesSaveFileName);
            else
                app.CBCT_PAIR_AlphaMatricesSavePathEditField.Value = 'Alpha and Selection Matrices will not be saved or loaded';
            end
            
            app.CBCT_PAIR_NumberPartitionsEditField.Value = recon.numberPartitions;
            app.CBCT_PAIR_NumberIterationsEditField.Value = recon.numberIterations;
            app.CBCT_PAIR_NumberAveragesEditField.Value = recon.numberAverages;
        end
        
        function recon = runReconstruction(recon, simulationOrImagingScanRun, app)
            if isempty(recon.alphaMatricesLoadPath)
                % one for top half, one for bottom half
                alphaMatrixPath = createAlphaMatrices(...
                    simulationOrImagingScanRun, recon, recon.numberPartitions, recon.numberIterations, recon.numberAverages, ...
                    recon.alphaMatricesSavePath, recon.alphaMatricesSaveFileName, true);                
                alphaMatrixPath = createAlphaMatrices(...
                    simulationOrImagingScanRun, recon, recon.numberPartitions, recon.numberIterations, recon.numberAverages,...
                    recon.alphaMatricesSavePath, recon.alphaMatricesSaveFileName, false);
            else
                alphaMatrixPath = recon.alphaMatricesLoadPath;
            end
            
            initialSolution_Top = findSmearSolution();
            initialSolution_Bottom = findSmearSolution();
            
            reconstruction_Top = performIterativePairReconstruction(...
                simulationOrImagingScanRun, recon, recon.numberPartitions, recon.numberIterations, recon.numberAverages,...
                alphaMatrixPath, initialSolution_Top, true);
            reconstruction_Bottom = performIterativePairReconstruction(...
                simulationOrImagingScanRun, recon, recon.numberPartitions, recon.numberIterations, recon.numberAverages,...
                alphaMatrixPath, initialSolution_Top, true);
        end
    end
    
end

