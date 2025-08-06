    function [ theta dk hopt ] = resampleParticles( theta,Wpnorm,N )
    
    %   Detailed explanation goes here
    %   indx = resampleStratified(Wpnorm);
    indx = resampleSystematic(Wpnorm);
    
    theta.th1 = theta.th1(indx);
    theta.th2 = theta.th2(indx);
    theta.th3 = theta.th3(indx);
    theta.th4 = theta.th4(indx);
    theta.th5 = theta.th5(indx);
    theta.th6 = theta.th6(indx);
    
    Covth1 = cov(theta.th1);
    Covth2 = cov(theta.th2);
    Covth3 = cov(theta.th3);
    Covth4 = cov(theta.th4);
    Covth5 = cov(theta.th5);
    Covth6 = cov(theta.th6);
    
    
    dk.th1 = cholcov(Covth1);%sqrt(CovXxp(1));
    dk.th2 = cholcov(Covth2);%sqrt(CovXyp(1));
    dk.th3 = cholcov(Covth3);%sqrt(CovXqp(1));
    dk.th4 = cholcov(Covth4);%sqrt(CovXqp(1));
    dk.th5 = cholcov(Covth5);%sqrt(CovXqp(1));
    dk.th6 = cholcov(Covth6);
    
    
    mm=3; % The dimension of parameter space
    A=(4/(mm+2))^(1/(mm+4));%InstantaneousGaussian
    
    % Need to make many changes if dimension of parameter space changes
    cx = 4*pi/3;

    %         A = (8/cx*(m+4)*((2*sqrt(pi))^m))^(1/(m+4));
    hopt=A*(N^(-1/(mm+4)));
    
    end

