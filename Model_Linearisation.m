
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
i_lon_u = [1 4];      % "longitudinal" controls 
i_lat_u = [2 3];      % "lateral/dirctional" controls



%% Use of extended state vector for calculation of matrices A,B,C,D
X0e = [X0(:); U0(:)];
xincr = [-0.1 0.1; -0.01 0.01; -0.01 0.01; -0.001 0.001; -0.001 0.001; -0.001 0.001; -0.01 0.01; -0.01 0.01; -0.01 0.01; -1 1; -0.1 0.1; -0.1 0.1; -0.1 0.1; -0.1 0.1; -0.1 0.1; -0.1 0.1];
[f,dFdXe] = jmtrx(@(x) EoM12ext(t0,x),X0e,xincr,16,12);
 
A = dFdXe(1:12,1:12)
s = eig(A)

% "Longitudinal" part of matrix A
A_lon = A(i_lon_x,i_lon_x)
s_lon = eig(A_lon)
[wn_lon, z_lon] = eig2freq(s_lon)

% "Lateral" part of matrix A
A_lat = A(i_lat_x,i_lat_x)
s_lat = eig(A_lat)
[wn_lat, z_lat] = eig2freq(s_lat)       



%% Plot eigenvalues
figure_signed;
subplot(2,1,1); hold on; grid on; 
    title('Eigenvalues of full system'); 
    xlabel('Re s'); ylabel('Im s');
    eig_grid(1:1:ceil(max(abs(s))),0:0.1:1,':','c');
    plot(real(s),imag(s),'xb','LineWidth',2,'markersize',12); 

subplot(2,2,3); hold on; grid on;
    title('Eigenvalues of "longitudinal" modes'); 
    xlabel('Re s'); ylabel('Im s');
    eig_grid(1:1:ceil(max(abs(s_lon))),0:0.1:1,':','c');
    plot(real(s_lon),imag(s_lon),'xb','LineWidth',2,'markersize',12);
    
subplot(2,2,4); hold on; grid on;
    title('Eigenvalues of "lateral/directional" modes'); 
    xlabel('Re s'); ylabel('Im s');
    eig_grid(1:1:ceil(max(abs(s_lat))),0:0.1:1,':','c');
    plot(real(s_lat),imag(s_lat),'xb','LineWidth',2,'markersize',12);      

    
%% Define full matrix B, C and D
B = dFdXe(1:12,13:16)
C = diag(ones(12,1))
D = zeros(12,4)

%% Select longitudinal and lateral/directional modes matrices
B_lon = B(i_lon_x,i_lon_u)
C_lon = C(i_lon_x,i_lon_x)
D_lon = D(i_lon_x,i_lon_u)

B_lat = B(i_lat_x,i_lat_u)
C_lat = C(i_lon_x,i_lon_x)
D_lat = D(i_lon_x,i_lon_u)