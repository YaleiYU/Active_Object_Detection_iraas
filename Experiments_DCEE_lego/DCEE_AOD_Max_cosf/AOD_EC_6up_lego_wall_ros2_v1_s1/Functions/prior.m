function [px] = prior(s)

%prior_uncertain_met

% if x(1)>=-10&&x(1)<=60&&x(2)>=-20&&x(2)<=30&&x(3)>=500&&x(3)<=20000
%     px=1/70/50/20000;
% else
%     px=0;
% end

[m n] = size(s.th1); %n=3

tempx = zeros(m,1);

tempx(s.th1> -1 & s.th2 >= -0.2 & s.th3 > -0.1 & s.th4 >-0.1 & s.th5 > -0.5 & s.th6 > -0.1 ) = 4;

px = find(tempx ~= 4);

%     s.th1 = 0.0135;
%     s.th2 = 0.0971;
%     s.th3 = 0.0963;
%     s.th4 = 0.1102;
%     s.th5 = -0.0307;
%     s.th6 = 0.0167;

end

