
function [ C ] = Conf_Distri_Rewa_Fun( s, p )

%%
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% s.D=s.ci;
% s.t = s.cii;
% lamda = sqrt((s.D.*s.t)./(1+ (s.u.^2.*s.t)./(4*s.D)));
% 
% module_dist = sqrt(((s.x-p.x)).^2 + ((s.y-p.y)).^2 + ((s.z-p.z)).^2);
% angazimuth= atan2((p.x-s.x),(p.y-s.y));
% angazimuth(angazimuth<0)=angazimuth(angazimuth<0)+2*pi;
% ang_diff_azimuth = angazimuth+s.phi-pi/2;
% ang_diff_azimuth(ang_diff_azimuth<0)=ang_diff_azimuth(ang_diff_azimuth<0)+2*pi;
% xr = module_dist .* cos(ang_diff_azimuth);
% 
% % C = s.Q./(4*pi.*s.D.*module_dist).*exp(1*(xr).*s.u./(2.*s.D)).*exp(-1*module_dist./lamda);
% C = s.Q./(4*pi.*s.D.*module_dist).*exp((1*(xr).*s.u./(2.*s.D))+(-1*module_dist./lamda));

%%
% theta1 = s.th1; 
% theta2 = s.th2; 
% theta3 = s.th3; 
% 
% % theta4 = s.th4; 
% % theta5 = s.th5; 
% % theta6 = s.th6; 
% 
% % r = sqrt(x.^2 + y.^2 + z.^2); 
% % 
% % alpha = acos(z./r);
% % beta = sign(y).*acos(x./sqrt(x.^2+y.^2));  
% % theta1 = 0.2810, theta2 = 0.0181, theta3 = 0.0472; 
% % theta1 = 0.2904, theta2 = -0.0203, theta3 = -0.002; 
% 
% Phi_p1 = sqrt(p.z.^2 + p.y.^2 + p.x.^2);
% Phi_p2 = acos(p.z./Phi_p1); 
% Phi_p3 = sign(p.y).*acos(p.x./sqrt(p.x.^2 + p.y.^2));

% % C = Phi_p.*theta;
% % C = Phi_p1.*theta1+Phi_p2.*theta2+Phi_p3.*theta3+Phi_p4.*theta4+Phi_p5.*theta5+Phi_p6.*theta6;
% C = Phi_p1.*theta1 + Phi_p2.*theta2 + Phi_p3.*theta3;

%%

scalar_domain = 0.125; 

theta1 = s.th1; 
theta2 = s.th2; 
theta3 = s.th3; 
theta4 = s.th4; 
theta5 = s.th5; 
theta6 = s.th6; 

Phi_p1 = p.z.^2.*p.y;
Phi_p2 = p.x.^2; 
Phi_p3 = p.y.^2;
Phi_p4 = p.z.^2;
Phi_p5 = p.y.*p.z;
Phi_p6 = p.x.*p.z;

C0 = Phi_p1.*theta1+Phi_p2.*theta2+Phi_p3.*theta3+Phi_p4.*theta4+Phi_p5.*theta5+Phi_p6.*theta6;

C = C0/scalar_domain^2;


end

