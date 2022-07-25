%% The state vector has been initialized in trim procedure!
% u = XX(1);        % m/s
% v = XX(2);        % m/s
% w = XX(3);        % m/s
%
% p = XX(4);        % rad/s
% q = XX(5);        % rad/s
% r = XX(6);        % rad/s
%
% phi   = XX(7);    % rad
% theta = XX(8);    % rad
% psi   = XX(9);    % rad
%
% xe = XX(10);      % m
% ye = XX(11);      % m
% ze = XX(12);      % m

% De = u(1);   % elevator, deg
% Da = u(2);   % ailerons, deg
% Dr = u(3);   % rudder, deg
% Dt = u(4);   % Throttle, percents

tf = 60;

%% Control input time history
%control_input = []; 
%control_input = @CtrlInput_ShortPeriod;  tf = 30;
%control_input = @CtrlInput_Phugoid;      tf = 180;
%control_input = @CtrlInput_Roll;         tf = 90;
control_input = @CtrlInput_Spiral;       tf = 180;
%control_input = @CtrlInput_DutchRoll;    tf = 30;
%control_input = @CtrlInput_Ascend;       tf = 180;
%control_input = @CtrlInput_Descend;      tf = 180;

% Integration of EoM
Tspan = [0 tf];
[t,X] = ode45(@(t,x) EoM12(t,x,U0),Tspan,X0);



%% Plot the results of simulation
figure_signed;

subplot(3,5,1); hold on; grid on; ylim([0 100]);
    ylabel('V, m/s');
    V = sqrt(X(:,1).^2 + X(:,2).^2 + X(:,3).^2);
    plot(t,V);
subplot(3,5,6); hold on; grid on; ylim([-10 20]);
    ylabel('\alpha, deg');
    alpha = atan2(X(:,3),X(:,1));
    plot(t,rad2deg(alpha));
subplot(3,5,11); hold on; grid on; ylim([-10 10]);
    ylabel('\beta, deg');
    beta  = asin(X(:,2)./V);
    plot(t,rad2deg(beta));


if isempty(control_input)   
    U = zeros(length(U0),length(t));
else
    U = control_input(t);
end
subplot(3,5,2); 
    ax = plotyy(t,U(1,:)+U0(1),t,U(4,:)+U0(4));
    axes(ax(1)); hold on; grid on;    ylabel('De, deg');
    axes(ax(2)); hold on; grid on;    ylabel('Dt, %');
subplot(3,5,7); hold on; grid on; ylim([-20 20]);
    ylabel('Da, deg');
    plot(t,U(2,:)+U0(2));
subplot(3,5,12); hold on; grid on; ylim([-20 20]);  
    ylabel('Dr, deg');
    plot(t,U(3,:)+U0(3));


subplot(3,5,3); hold on; grid on; 
    ylabel('p, deg/s');
    plot(t,rad2deg(X(:,4))); ylim([-30 30]);
subplot(3,5,8); hold on; grid on; 
    ylabel('q, deg/s');
    plot(t,rad2deg(X(:,5))); ylim([-30 30]);
subplot(3,5,13); hold on; grid on; 
    ylabel('r, deg/s');
    plot(t,rad2deg(X(:,6))); ylim([-30 30]);

subplot(3,5,4); hold on; grid on; 
    ylabel('\phi, deg');
    plot(t,rad2deg(X(:,7))); ylim([-30 30]);
subplot(3,5,9); hold on; grid on; 
    ylabel('\theta, deg');
    plot(t,rad2deg(X(:,8))); ylim([-30 30]);
subplot(3,5,14); hold on; grid on; 
    ylabel('\psi, deg');
    plot(t,rad2deg(X(:,9))); %ylim([-180 180]);
    
subplot(3,5,5); hold on; grid on;  %ylim([]);
    ylabel('x_e, m');
    plot(t,X(:,10));
subplot(3,5,10); hold on; grid on;  %ylim([]);
    ylabel('y_e, m');
    plot(t,X(:,11));
subplot(3,5,15); hold on; grid on;  ylim([0 3000]);
    ylabel('h, m');
    plot(t,-X(:,12));
    
set(findobj(gcf, 'type','line'),'linewidth',1.5);
linkaxes(findobj(gcf, 'type','axes'),'x')
