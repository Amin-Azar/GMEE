function [ func_EM,noCurrects] = func_Err_MED( D_apprx, D_accur, NoSamples)
%EM_MED Summary of this function goes here
%   Detailed explanation goes here

func_col = numsamples(D_apprx);
func_EM = zeros(1,func_col);
noCurrects= zeros(1,func_col);

% parameter a aval barmigarde, 2 vom o sevom vase debuging e!
% parameter e 2 vom tu har marhale mani mide! vase har marhale avaz mishe
for DCcol = 1:func_col 
[func_EM(:,DCcol),coefs,noCurrects(:,DCcol)] = EM_med(D_accur(:,DCcol),D_apprx(:,DCcol),NoSamples);
end

end

