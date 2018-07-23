% **************************************
% Set Base Params
% **************************************
readPath = 'E:\Thesis Results\External Beam Trials.xls';
sheet = 'Stand. OSC-TV # Iters ANLYS';

groupLabels = {...
    'FDK',...
    '\begin{tabular}{c}OSC-TV\\S=[205..13]\end{tabular}',...
    '\begin{tabular}{c}OSC-TV\\S=[205..41]\end{tabular}',...
    '\begin{tabular}{c}OSC-TV$_{FF}$\\S=[205..13]\end{tabular}',...
    '\begin{tabular}{c}OSC-TV$_{FF}$\\S=[205..41]\end{tabular}'};

groupRows = {...
    4:4,...
    6:12,...
    13:19,...
    20:26,...
    27:33};    

subgroupLabels = {...
    'n=10',...
    'n=15',...
    'n=20',...
    'n=25',...
    'n=30',...
    'n=35',...
    'n=40'};

subgroupColours = [...
    0.91 0.91 0.91;...
    0.78 0.78 0.78;...
    0.65 0.65 0.65;...
    0.52 0.52 0.52;...
    0.39 0.39 0.39;...
    0.26 0.26 0.26;...
    0.13 0.13 0.13];

customColours = {...
    [0.05 0.05, 0.05],...
    [],...
    [],...
    [],...
    []};

figDimsInCm = [10, 15];

subgroupLabelWriteIndex = 2;

% **************************************
% Mean
% **************************************

graphWritePath = 'E:\Thesis Results\Standard OSC-TV Num Iterations Bar Graphs\Mean Comparison.png';

column = 28;

yAxisLabel = 'Change in $\bar{\mu}_{ROI}$ from control $[cm^-1]$';

title = 'Comparison of $\bar{\mu}_{ROI}$ for tested OSC-TV parameters';

f = @(x) x ./ 100;

subgroupLabelOrientation = {...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above'};

subgroupLabelAngle = {...
    45,...
    45,...
    45,...
    45,...
    45,...
    45,...
    45};

lineAtBar = [1,1];
linePosAndNeg = true;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 

% **************************************
% Stdev
% **************************************

graphWritePath = 'E:\Thesis Results\Standard OSC-TV Num Iterations Bar Graphs\Stdev Comparison.png';

column = 31;

yAxisLabel = 'Change in $\sigma_{ROI}$ from control $[cm^-1]$';

title = 'Comparison of $\sigma_{ROI}$ for tested OSC-TV parameters';

f = @(x) x ./ 100;

subgroupLabelOrientation = {...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above'};

subgroupLabelAngle = {...
    45,...
    45,...
    45,...
    45,...
    45,...
    45,...
    45};

lineAtBar = [1,1];
linePosAndNeg = false;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 

% **************************************
% Gradient Mean
% **************************************

graphWritePath = 'E:\Thesis Results\Standard OSC-TV Num Iterations Bar Graphs\Gradient Comparison.png';

column = 34;

yAxisLabel = 'Change in $\nabla_{ROI}$ from control  $[cm^-1]$';

title = 'Comparison of $\nabla_{ROI}$ for tested OSC-TV parameters $[unitless]$';

f = @(x) x ./ 100;

subgroupLabelOrientation = {...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above'};

subgroupLabelAngle = {...
    45,...
    45,...
    45,...
    45,...
    45,...
    45,...
    45};

lineAtBar = [1,1];
linePosAndNeg = false;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 

% **************************************
% Delta Mean
% **************************************

graphWritePath = 'E:\Thesis Results\Standard OSC-TV Num Iterations Bar Graphs\Delta Mean Comparison.png';

column = 40;

yAxisLabel = 'Change in $\Delta_{ROI}$ from control  $[cm^-1]$';

title = 'Comparison of $\Delta_{ROI}$ for tested OSC-TV parameters $[unitless]$';

f = @(x) x ./ 100;


subgroupLabelOrientation = {...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above'};

subgroupLabelAngle = {...
    45,...
    45,...
    45,...
    45,...
    45,...
    45,...
    45};

lineAtBar = [1,1];
linePosAndNeg = false;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 

% **************************************
% Delta Stdev
% **************************************

graphWritePath = 'E:\Thesis Results\Standard OSC-TV Num Iterations Bar Graphs\Delta Stdev Comparison.png';

column = 43;

yAxisLabel = 'Change in $\Delta_{ROI}$ from control  $[cm^-1]$';

title = 'Comparison of $\Delta_{ROI}$ for tested OSC-TV parameters $[unitless]$';

f = @(x) x ./ 100;


subgroupLabelOrientation = {...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above'};

subgroupLabelAngle = {...
    45,...
    45,...
    45,...
    45,...
    45,...
    45,...
    45};

lineAtBar = [1,1];
linePosAndNeg = false;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 


% **************************************
% D1
% **************************************

graphWritePath = 'E:\Thesis Results\Standard OSC-TV Num Iterations Bar Graphs\d1 Comparison.png';

column = 46;

yAxisLabel = 'Change in $d_{1}$ from control $[mm]$';

title = 'Comparison of $d_{1}$ for tested OSC-TV parameters';

f = @(x) x .* 0.5;


subgroupLabelOrientation = {...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above'};

subgroupLabelAngle = {...
    45,...
    45,...
    45,...
    45,...
    45,...
    45,...
    45};

lineAtBar = [1,1];
linePosAndNeg = true;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 

% **************************************
% D2
% **************************************

graphWritePath = 'E:\Thesis Results\Standard OSC-TV Num Iterations Bar Graphs\d2 Comparison.png';

column = 52;

yAxisLabel = 'Change in $d_{2}$ from control $[mm]$';

title = 'Comparison of $d_{2}$ for tested OSC-TV parameters';

f = @(x) x .* 0.5;


subgroupLabelOrientation = {...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above',...
    'above'};

subgroupLabelAngle = {...
    45,...
    45,...
    45,...
    45,...
    45,...
    45,...
    45};

lineAtBar = [1,1];
linePosAndNeg = true;

barGraphDataCollectionAndCreation(...
    readPath, sheet, groupRows, column,...
    graphWritePath, groupLabels, subgroupLabels,...
    subgroupLabelWriteIndex, subgroupLabelOrientation, subgroupLabelAngle,...
    figDimsInCm, subgroupColours, customColours,...
    yAxisLabel, title, f, lineAtBar, linePosAndNeg); 