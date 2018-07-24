% load-up images
volume2_4_fdk = loadOpticalCtVistaRecon('F:\Thesis Recon Data\Gel 2-4\Gel 2-4_HR.vff');
volume2_4_control = loadOpticalCtVistaRecon('F:\Thesis Recon Data\Gel 2-3\Gel 2-3_HR.vff');

volume4_2_fdk = loadOpticalCtVistaRecon('F:\Thesis Recon Data\Gel 4-2\Gel 4-2_HR.vff');
volume4_2_control = loadOpticalCtVistaRecon('F:\Thesis Recon Data\Gel 4-1\Gel 4-1_HR.vff');

data = load('E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 2-4)\Slice 1\Angle 0\Position (1,1) Detector Data.mat');

pre2_4_fdk = data.detectorData_I0;
post2_4_fdk = data.detectorData_I;

data = load('E:\Data Files\Git Repos\Local Gyrfalcon Data\Imaging Scan Runs\Optical CT Imaging Scan Run (Gel 4-2)\Slice 1\Angle 0\Position (1,1) Detector Data.mat');

pre4_2_fdk = data.detectorData_I0;
post4_2_fdk = data.detectorData_I;

% analysis params
slice = 128;

gel2_4_threshold = [0, 10];
gel4_2_threshold = [0, 13];

gel2_4_ticks = [0:2:10];
gel4_2_ticks = [0:2:12, 13];

colourbarLabel = '$\Delta\mu [cm^{-1}]$';

imageThreshold = [0 2^16];

profile1_X = [0 256];
profile1_Y = [128 128];

profile2_X = [0 256];
profile2_Y = [110 110];

imageHeightInCm = 6;

lineColours = 
lineColours, lineStyles, lineWidths

% write
