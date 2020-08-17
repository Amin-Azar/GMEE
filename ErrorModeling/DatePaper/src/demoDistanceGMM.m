function demoDistanceGMM()
%
% This is a demo code for the unscented Hellinger distance between a pair of 
% Gaussian mixture models. The code follows the derivation of the
% multivariate unscented Hellinger distance introduced in [1].
% Unlike the Kullback-Leibler divergence, the Hellinger distance is a
% metric between distribution and is constrained to interval (0,1) with 0
% meaning complete similarity and 1 complete dissimilarity.
%
% The demo constructs two random GMMs, displays them, and calculates
% the Hellinger distance between them. This procedure is repeated for 
% one, two, three and one hundred dimensional example.
%
% The demo uses the "drawTools" from Matej Kristan for visualization only.
% If you only want the distance measure, then you will only need the files
% from the folder "uHellingerGMM".
%
% If you are using this distance function in your work, please cite the paper [1].
%
% [1] M. Kristan, A. Leonardis, D. Sko�aj, "Multivariate online Kernel Density
% Estimation", Pattern Recognition, 2011. 
% (url: http://vicos.fri.uni-lj.si/data/publications/KristanPR11.pdf)
% 
% Author: Matej Kristan (matej.kristan@fri.uni-lj.si) 2012

% add path to draw tools (for visualization only)
% pth = [pwd, '/drawTools' ] ; rmpath(pth) ; addpath(pth) ;

% add path to unscented Hellinger distance
 %pth = [pwd, '/uHellingerGMM' ] ; rmpath(pth) ; addpath(pth) ;

 load('~/params.mat');
 
%figure(1);

clf ;
%d = [1 2 3 100] ; % dimensionality of data
d=1;
for i_d = 1:length(d)
    % construct two GMMs
    %kde1.pdf = getARandomGMM(d(i_d), 1, 1) ;
    %
    kde1.pdf = getGMM(1); % getMM_ref(); % ref ro 6 yani hamun 10 ta gerefte budim ke beshe moghayese kard
    %

    kce2.pdf = getGMM(5);%getMM_MIA();% in varmidare takhmine mia ro miare getGMM(1) ; % mige kio tu array entekhab kone! 5 yani ba 6 ta fit o begir
   

    
    % display the GMMS
    %subplot(1, length(d), i_d) ;
    visualizeKDE('kde', kde1, 'decompose', 0, 'showkdecolor', 'r' ) ; hold on ;
    visualizeKDE('kde', kce2, 'decompose', 0, 'showkdecolor', 'b' ) ;
    
    % get distance between the GMMs
    H = uHellingerJointSupport2_ND( kde1.pdf, kce2.pdf ) 
    
    title(sprintf('%dD Hellinger dist: %1.2f', d(i_d), H)) ;
end

% ----------------------------------------------------------------------- %





