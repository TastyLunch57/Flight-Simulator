%% Plot aerodynamic coefficients depending on angle of attack

% comment out the line below after first use to plot next outputs 
% to the same figure and change line color


% set line color here:
clr = 'b';  % 'r'-red, 'g'-green, 'b'-blue, 'm'-magenta, 'c'-cyan, 'k'-black 


alpha = -10:0.5:30;     % range of angles of attack, deg 
beta  = 0;              % sideslip, deg
Mach    = 0.25;           % Mach number 

De = 0;                 % elevator, deg
Da = 0;                 % aileron, deg 
Dr = 0;                 % rudder, deg

p = 0;                  % roll rate, undim
q = 0;                  % pitch rate, undim
r = 0;                  % yaw rate, undim
adot = 0;               % alpha rate, undim

%%-----------------------------------------------------------------------------------

for i=1:length(alpha)
    FM(:,i) = C510aero(deg2rad(alpha(i)), deg2rad(beta), Mach, De,Da,Dr, p,q,r, adot);
end               


subplot(2,3,1); 
hold on; grid on; xlabel('\alpha'); ylabel('CD');
plot(alpha, FM(1,:),'-','color',clr,'linewidth',1.5);

subplot(2,3,2); 
hold on; grid on; xlabel('\alpha'); ylabel('CY');
plot(alpha, FM(2,:),'-','color',clr,'linewidth',1.5);

subplot(2,3,3); 
hold on; grid on; xlabel('\alpha'); ylabel('CL');
plot(alpha, FM(3,:),'-','color',clr,'linewidth',1.5);

subplot(2,3,4); 
hold on; grid on; xlabel('\alpha'); ylabel('Cl');
plot(alpha, FM(4,:),'-','color',clr,'linewidth',1.5);

subplot(2,3,5); 
hold on; grid on; xlabel('\alpha'); ylabel('Cm');
plot(alpha, FM(5,:),'-','color',clr,'linewidth',1.5);

subplot(2,3,6); 
hold on; grid on; xlabel('\alpha'); ylabel('Cn');
plot(alpha, FM(6,:),'-','color',clr,'linewidth',1.5);