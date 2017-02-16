function [img] = Load_VFF;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The purpose of this function is to read 3d reconstruction files into 
% three dimensional matrices in MATLAB.  The reconstruction files are of
% type 'VFF' and have been generated by "Vista 3-D Reconstruction": 
% They are 3D reconstructed OptCT images that have been saved in 
% "big endian" byte order.  Three file sizes can be read, 64x64x64,
% 128x128x128 and 256x256x256 corresponding to low, medium and high
% resolution reconstructions respectively.

%   AUTHOR:   Oliver Edwin Holmes
%   DATE:     June 2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   USER SELECTS RECONSTRUCTION FILE
%=======================================
    [filename pathname] = uigetfile('*.VFF','Please select a reconstruction file.');
    index = findstr(filename,'.vff');
    ReString = filename(index-2);
    Location = strcat(pathname,filename);
%=======================================
    
%   DETECT THE END OF THE HEADER AS INDICATED BY PAGE BREAK
%==========================================================
    fOCT = fopen(Location);                 %Open user selected VFF file
    for i = 1:10000                         %Search for end of header
        charnum = i;                        %Store last header character index in charnum 
        tChar = fgets(fOCT,1);              %Read next character in file
        if (int16(tChar) == 12) break; end
    end
    fclose(fOCT);                           %Close file
%=========================================================


%    RESOLUTION IS DETECTED BASED ON PATHNAME   
%============================================
    if strcmp(ReString,'H') == 1   
            Res = 256;
        elseif strcmp(ReString,'M')== 1 
            Res = 128;
        elseif strcmp(ReString,'L') == 1
            Res = 64;
    else
            error('Invalid file format, or pathname error.');
    end
%===========================================
    

%   OPEN VFF FILE AND READ RELEVANT DATA INTO IMAGE MATRIX
%   ======================================================
    fid=fopen(Location,'r','b');            %require the 'b' operator for big endian byte order
    fseek(fid,(charnum+1),'bof');           %Set curser position to the first character after the end of the header  
    data = fread(fid,(Res^3),'float32');    %Read to the end of the file in big endian byte order
    img = reshape(data, [Res Res Res]);     %Reshape column vector to a 3D matrix
    fclose(fid);                            %close the working file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%