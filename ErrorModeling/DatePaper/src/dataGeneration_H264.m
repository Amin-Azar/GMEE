fileID = fopen(strcat(path1,'/in_data.txt'),'w');
fprintf(fileID,'s%12s %12s %12s %12s \ns\n','A','B', 'O1 ', 'Zero! ');

%estesnaan inja az ru khode data mikhunim dge
Nonums = numel (H264_A);

std_H264_A = round(std(H264_A));
std_H264_B = std(H264_B);
std_H264_O1 = std(H264_O1);

std_H264_A_rounded = 2^round(log2(std_H264_A));
std_H264_B_rounded = 2^round(log2(std_H264_B));



%Sigma prints
fprintf(fileID,'p %12d %12d\n',std_H264_A_rounded,std_H264_B_rounded); % mifrestim be aavalin adder khata dar
fprintf(fileID,'s 1= [ s_A=%10.2f s_B=%10.2f s_ADD=%10.2f ]\n',std_H264_A,std_H264_B,std_H264_O1); 


for i = 1:Nonums
fprintf(fileID,'d%12d %12d %12d %12d\n',-1*H264_A(i),-1*H264_B(i),-1*H264_O1(i),1);
end

fclose(fileID);
save('~/params.mat');