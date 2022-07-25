%% State vector
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

%% Linearization of the system x_dot=F(t,x,u) to 
%  the form x_dot = Ax + Bu. 
%           y     = Cx + Du
t0 = 0;
% indexes if "longitudinal" and "lateral-directional" elements of the state
% vector x: 
i_lon_x = [1 3 5 8];  % 10 12]; x,z - excluded as they do not affect dynamics
i_lat_x = [2 4 6 7];  %  9 11]; psi,y - excluded as they do not affect dynamics

%% System matrix A:
%  Calculation of Jacobian of the system matrix
xincr = [-0.1 0.1; -0.01 0.01; -0.01 0.01; -0.001 0.001; -0.001 0.001; -0.001 0.001; -0.01 0.01; -0.01 0.01; -0.01 0.01; -1 1; -0.1 0.1; -0.1 0.1];
[f,dFdX] = jmtrx(@(x) EoM12(t0,x,U0),X0,xincr,12,12);

% Full matrix A
A1 = dFdX(1:12,1:12)
s1 = eig(A1)

% "Longitudinal" part of matrix A
A1_lon = A1(i_lon_x,i_lon_x)
s1_lon = eig(A1_lon)
[wn_lon, z_lon] = eig2freq(s1_lon)

% "Lateral" part of matrix A
A1_lat = A1(i_lat_x,i_lat_x)
s1_lat = eig(A1_lat)
[wn_lat, z_lat] = eig2freq(s1_lat)      



%% Plot eigenvalues 
figure_signed
subplot(2,1,1); hold on; grid on; 
    title('Eigenvalues of full system, method 1'); 
    xlabel('Re s'); ylabel('Im s');
    eig_grid(1:1:ceil(max(abs(s1))),0:0.1:1,':',[0.7 0.7 0.7]);
    plot(real(s1),imag(s1),'xb','LineWidth',2,'markersize',12); 

subplot(2,2,3); hold on; grid on;
    title('"Longitudinal" modes'); 
    xlabel('Re s'); ylabel('Im s');
    eig_grid(1:1:ceil(max(abs(s1_lon))),0:0.1:1,':',[0.7 0.7 0.7]);
    plot(real(s1_lon),imag(s1_lon),'xb','LineWidth',2,'markersize',12);
    
subplot(2,2,4); hold on; grid on;
    title('"Lateral/directional" modes'); 
    xlabel('Re s'); ylabel('Im s');
    eig_grid(1:1:ceil(max(abs(s1_lat))),0:0.1:1,':',[0.7 0.7 0.7]);
    plot(real(s1_lat),imag(s1_lat),'xb','LineWidth',2,'markersize',12);
