function app = hideAllAlgorithmSettingsTabs(app)
%app = hideAllAlgorithmSettingsTabs(app)

tabHandles = {...
    app.Gen1FBP_SettingsTab,...
    app.Gen1PAIR_SettingsTab,...
    app.ConeBeamFDK_SettingsTab,...
    app.ConeBeamPAIR_SettingsTab,...
    app.ConeBeamOSSARTSettingsTab,...
    app.ConeBeamOSASDPOCSSettingsTab,...
    app.ConeBeamSARTSettingsTab,...
    app.ConeBeamSIRTSettingsTab,...
    app.ConeBeamSARTTVSettingsTab,...
    app.ConeBeamMLEMSettingsTab,...
    app.ConeBeamCGLSSettingsTab,...
    app.ConeBeamOSCTVSettingsTab...
    };

for i=1:length(tabHandles)
    tabHandles{i}.Parent = [];
end

end

