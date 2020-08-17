fileID = fopen(strcat(path1,'/in_data_reg.txt'),'w');
fprintf(fileID,'s%12s %12s %12s %12s \ns\n','A','B', 'O1 ', 'Zero! ');

%estesnaan inja az ru khode data mikhunim dge
Nonums = numel (H264_A);

std_H264_O1_appx = round(std(H264_O1_appx));
std_H264_C = std(H264_C);
std_H264_O2 = std(H264_O2);

std_H264_O1_appx_rounded = 2^round(log2(std_H264_O1_appx));
std_H264_C_rounded = 2^round(log2(std_H264_C));

corr_out_datas = H264_O2;

%Sigma prints
fprintf(fileID,'p %12d %12d\n',std_H264_O1_appx_rounded,std_H264_C_rounded); % mifrestim be aavalin adder khata dar
fprintf(fileID,'s 1= [ s_A=%10.2f s_B=%10.2f s_ADD=%10.2f ]\n',std_H264_O1_appx,std_H264_C,std_H264_O2); 


for i = 1:Nonums
fprintf(fileID,'d%12d %12d %12d %12d\n',H264_O1_appx(i),-1*H264_C(i),-1*H264_O2(i),1);
end

fclose(fileID);
save('~/params.mat');