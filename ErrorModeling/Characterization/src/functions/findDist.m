function [ resp,DoneOK,nll ] = findDist( a,n,maxIter)
%Find good fit for a with n component in maxItter itterations

errorMSG=0;
resp=0;
replicates =3;
nll=0;
if ( maxIter <100)
    maxIter =100;
end

options = statset('MaxIter',maxIter);

try
    rng('shuffle')
    
    %fit1 = fitgmdist(a,n,'CovType','diagonal','Options',options);
    %fitgmdist(a,n,'Start','plus','Options',statset('MaxIter',1500))
    fit1 = fitgmdist(a,n,'Start','randSample','replicates',replicates,'Options',options);
    mu1=fit1.mu;
    mu1=transpose(mu1);
    sig1=fit1.Sigma;
    sig1=squeeze(sig1);
    sig1=transpose(sig1);
    por1=fit1.PComponents; % cheghad harkodum e ! area ina
    %neshun nemidim dge! ba inam mishe minimum kard meske
    nll=fit1.NlogL;
    resp = vertcat(mu1,sqrt(sig1),por1);
    
catch exception
    %disp('There was an error fitting the Gaussian mixture model')
    errorMSG = exception.message;
end


% age already bade, 0 bede bargard
if ( errorMSG ~= 0)
    DoneOK = 0;
else
    %age fit shode ba covarience e doros, bebin converge ham shode yana!
    DoneOK =fit1.Converged;
end



end

