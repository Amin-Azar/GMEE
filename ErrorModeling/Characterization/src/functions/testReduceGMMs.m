

%DATA
%%
%data haye appx to in range an (tu in range plot she)
TR_dataRange = [-20000, 10000];

TR_gmmA = [ 2^5,2^5,1];     TR_idxA = 0;
TR_gmmB = [-2^5,2^5,1];     TR_idxB = 0;

TR_gmmC = [ 2^5,2^5,1];     TR_idxC = 0;

TR_gmmD = [ 2^5,2^5,1];     TR_idxD = 0;

%ADDs
%%

%ADD1
[TR_O1,TR_idxO1] = guessETAIIMoutGMMs(TR_gmmA ,TR_gmmB   ,TR_idxA ,TR_idxB);
[TR_r_O1,TR_r_idxO1] = reduceGMMcnt(TR_O1 ,TR_idxO1);
%ADD2
[TR_O2,TR_idxO2] = guessETAIIMoutGMMs(TR_gmmC ,TR_r_O1   ,TR_idxC ,TR_r_idxO1);
[TR_r_O2,TR_r_idxO2] = reduceGMMcnt(TR_O2 ,TR_idxO2);

[TR_O3,TR_idxO3] = guessETAIIMoutGMMs(TR_gmmD ,TR_r_O2   ,TR_idxD ,TR_r_idxO2);
[TR_r_O3,TR_r_idxO3] = reduceGMMcnt(TR_O3 ,TR_idxO3);

%PLOT
%%

plotGMMs_ErrCrr(TR_r_O3,TR_r_idxO3,TR_dataRange);
%{
plotGMMs_ErrCrr(TR_O2,TR_idxO2,TR_dataRange);
ylm = ylim;
plotGMMs_ErrCrr(TR_r_O2,TR_r_idxO2,TR_dataRange);
ylim(ylm);
%}

%newline
disp(' ');
%DONE