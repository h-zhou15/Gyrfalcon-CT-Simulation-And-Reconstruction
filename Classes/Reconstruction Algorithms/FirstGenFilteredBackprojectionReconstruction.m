classdef FirstGenFilteredBackprojectionReconstruction < Reconstruction
    % FirstGenFilteredBackprojectionReconstruction
    
    properties
        displayName = 'Filtered Backprojection'
        fullName = 'Filtered Backprojection (1st Gen)'
        
        filterType = FirstGenFilterTypes.none % these filters (Shepp-Logan, cosine, Hann, etc.) are all noise reduction filters NOT for frequency space weighting
        applyRampFilter = true% boolean of whether to use a ramp (Ram-Lak) filter. This weights the data in frequency space accordingly
        
        applyBandlimiting = true % bandlimiting based on detector widths
        
        interpolationType = InterpolationTypes.linear;
        
        % Data Sets to Save
        
        % reconDataSet (in Reconstruction class)
        sinogram
        
        reconVideoFrames
    end
    
    methods        
        function strings = getSettingsString(recon)
            strings = {'No Settings'};            
        end
        
        function [filterTypes, filterTypeStrings] = getFilterTypes(recon)
            [filterTypes, filterTypeStrings] = enumeration(FirstGenFilterTypes);
        end
        
        function recon = changeSettings(recon)
            recon = firstGenFilteredBackprojectionReconSettingsGUI(recon);
        end
        
        function string = getNameString(recon)
            string = '1st Gen. FBP';
        end
        
        function recon = runReconstruction(recon, simulationRun, handles)
            firstGenData = simulationRun.compileProjectionDataFor1stGenRecon();
            
            [reconDataSet, sinogram, reconVideoFrames] = firstGenFilteredBackProjectionAlgorithm(...
                firstGenData,...
                recon.filterType,...
                recon.applyRampFilter,...
                recon.applyBandlimiting,...
                recon.interpolationType);
            
            recon.reconDataSet = reconDataSet
            
        end
    end
    
end
