function [ theta ] = mcmcResampleStep_Memory( theta,Wpnorm,N, D_k_store,m, dk, hopt,pos,P_k_store,PF_Memory )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

keep = [];

for zz = 1:1 %5
    keep = [];
    n.th1 = theta.th1 + (hopt.*dk.th1.*randn(N,1));
    n.th2 = theta.th2 + (hopt.*dk.th2.*randn(N,1));
    n.th3 = theta.th3 + (hopt.*dk.th3.*randn(N,1));
    n.th4 = theta.th4 + (hopt.*dk.th4.*randn(N,1));
    n.th5 = theta.th5 + (hopt.*dk.th5.*randn(N,1));
    n.th6 = theta.th6 + (hopt.*dk.th6.*randn(N,1));
 
    for loops = 1:2
        pri = prior(n);
        numPri = length(pri);
        n.th1(pri) = theta.th1(pri) + (hopt.*dk.th1.*randn(numPri,1));
        n.th2(pri) = theta.th2(pri) + (hopt.*dk.th2.*randn(numPri,1));
        n.th3(pri) = theta.th3(pri) + (hopt.*dk.th3.*randn(numPri,1));
        n.th4(pri) = theta.th4(pri) + (hopt.*dk.th4.*randn(numPri,1));
        n.th5(pri) = theta.th5(pri) + (hopt.*dk.th5.*randn(numPri,1));
        n.th6(pri) = theta.th6(pri) + (hopt.*dk.th6.*randn(numPri,1));

    end
    pri = prior(n);
    n.th1(pri) = theta.th1(pri);
    n.th2(pri) = theta.th2(pri);
    n.th3(pri) = theta.th3(pri);

    n.th4(pri) = theta.th4(pri);
    n.th5(pri) = theta.th5(pri);
    n.th6(pri) = theta.th6(pri);
    
    
    nWpnorm = Wpnorm;
    r = size(D_k_store);
    if PF_Memory==1 || length(P_k_store(1,:))==1
        pos.th1 = P_k_store(end,1);
        pos.th2 = P_k_store(end,2);
        D = D_k_store(end);
        
        nC = Conf_Distri_Rewa_Fun(n,pos);
        
        % nWp = Likelihood_Plain_Gaussian(nC,D,Wpnorm);
        nWp = Likelihood_Like_Yee(nC, D, Wpnorm, m);
        
        nWpnorm = normaliseWeight(n,nWp,N);
    else
        for mem = 1:PF_Memory
            % Estimeated from particle filter
            % nC = simpleGaussianPlume(n,m,pos);
            ind = ceil(rand*r(1));
            pos.th1 = P_k_store(ind,1);
            pos.th2 = P_k_store(ind,2);
            D = D_k_store(ind);
            
            nC = Conf_Distri_Rewa_Fun(n,pos);
            
            % nWp = Likelihood_Plain_Gaussian(nC,D,Wpnorm);
            nWp = Likelihood_Like_Yee(nC, D, nWpnorm, m);
            
            nWpnorm = normaliseWeight(n,nWp,N);
        end
    end
    alpha = nWpnorm./(Wpnorm);  %(Wpnorm(indx))
    %         alpha = nWpnorm/(1/N);
    
    mcrand = rand(N,1);
    keep = find(alpha>mcrand);
    % keep = 1:N; 
    notkeep = find(alpha<rand);
    
    theta.th1(keep) = n.th1(keep);
    theta.th2(keep) = n.th2(keep);
    theta.th3(keep) = n.th3(keep);

    theta.th4(keep) = n.th4(keep);
    theta.th5(keep) = n.th5(keep);
    theta.th6(keep) = n.th6(keep);
    
    Wpnorm = ones(N,1)/N;
    
end
end

