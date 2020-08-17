%{

%inja mikhaym dade hayi ke khundim az h264 bekhunim az txt file o zakhire
konim ( _capture X -> ba excell X entekhab mikoni dobare tu A.txt sabe
mikonim

%badesham pashim B, out2 ro hesab konim az ru dade haye capture shode


%}


fileID = fopen('~/h264_test_2/test/capture/A.txt','r');
H264_A=fscanf (fileID,'%d\n'); %goloppi vamidare mizare dfe! faghat bas _capture aval o pak koni
fclose(fileID);

fileID = fopen('~/h264_test_2/test/capture/O1.txt','r');
H264_O1=fscanf (fileID,'%d\n'); %goloppi vamidare mizare dfe! faghat bas _capture aval o pak koni
fclose(fileID);

fileID = fopen('~/h264_test_2/test/capture/C.txt','r');
H264_C=fscanf (fileID,'%d\n'); %goloppi vamidare mizare dfe! faghat bas _capture aval o pak koni
fclose(fileID);

%%
% O2 = O1 +C
%
% O1 = A + B
%

H264_B = H264_O1 - H264_A;
H264_O2 = H264_C + H264_O1;


%%

indx1 =1;
count=0;
%{
while ~feof(fileID)
    indx1= indx1+1;
    out_data_1=fgetl (fileID);
    
end
count= indx1;
indx1=1;
fclose(fileID);

out_data=zeros(1,count);
fileID = fopen('~/h264_test_2/test/capture/capture_2016-09-13_1473821156.txt','r');

while ~feof(fileID)    
    out_data_1=fscanf (fileID,' %s %d\n');
    out_data(indx) = out_data_1(2);
    indx1= indx1+1;
end
fclose(fileID);
%}