function pdf_out = getARandomGMM(d,N,delt)
sig= 15;
pdf_out.Mu = delt*rand(d,N)  ;
pdf_out.w = rand(1,N) ;
pdf_out.w = pdf_out.w/sum(pdf_out.w) ;
pdf_out.Cov = {} ;
for i = 1 : N
    pdf_out.Cov = horzcat(pdf_out.Cov, (2^sig)^2) ;
  %      pdf_out.Cov = horzcat(pdf_out.Cov, diag(rand(1,d))) ;
  
  
end

