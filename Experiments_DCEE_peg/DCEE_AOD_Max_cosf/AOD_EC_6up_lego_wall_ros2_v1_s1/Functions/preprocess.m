function preprocess(s,theta,Wpnorm, N )
% UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Resample first as histogram does not account for weights
% indx = resampleStratified(W);
% x(:) = x(indx);
% y(:) = y(indx);
% q(:) = q(indx);
% theta(:) = theta(indx);
% u(:) = u(indx);
% d(:) = d(indx);

histograms = [];

theta.th1 = N.*Wpnorm.*theta.th1;
theta.th2 = N.*Wpnorm.*theta.th2;
theta.th3 = N.*Wpnorm.*theta.th3;
theta.th4 = N.*Wpnorm.*theta.th4;
theta.th5 = N.*Wpnorm.*theta.th5;
theta.th6 = N.*Wpnorm.*theta.th6;

subplot(3,2,1)
% hold off
histograms = [histograms histogram(theta.th1)];
hax = axis;
hold on
plot([s.th1,s.th1],[hax(3),hax(4)], 'r')
xlabel('$\theta_1$')

subplot(3,2,2)
% hold off
histograms = [histograms histogram(theta.th2)];
hax = axis;
hold on
plot([s.th2,s.th2],[hax(3),hax(4)], 'r')
xlabel('$\theta_2$')

subplot(3,2,3)
% hold off
histograms = [histograms histogram(theta.th3)];
hax = axis;
hold on
plot([s.th3,s.th3],[hax(3),hax(4)], 'r')
xlabel('$\theta_3$')


subplot(3,2,4)
% hold off
histograms = [histograms histogram(theta.th4)];
hax = axis;
hold on
plot([s.th4,s.th4],[hax(3),hax(4)], 'r')
xlabel('$ \theta_4 $')

subplot(3,2,5)
% hold off
histograms = [histograms histogram(theta.th5)];
hax = axis;
hold on
plot([s.th5,s.th5],[hax(3),hax(4)], 'r')
xlabel('$ \theta_5 $')

subplot(3,2,6)
% hold off
histograms = [histograms histogram(theta.th6)];
hax = axis;
hold on
plot([s.th6, s.th6],[hax(3), hax(4)], 'r')
xlabel( '$ \theta_6 $')


% subplot(4,2,7)
% % hold off
% histograms = [histograms histogram(t.ci)];
% hax = axis;
% hold on
% plot([s.ci,s.ci],[hax(3),hax(4)], 'r')
% xlabel('ci')
% subplot(4,2,8)
% % hold off
% histograms = [histograms histogram(t.cii)];
% hax = axis;
% hold on
% plot([s.cii,s.cii],[hax(3),hax(4)], 'r')
% xlabel('cii')
end

