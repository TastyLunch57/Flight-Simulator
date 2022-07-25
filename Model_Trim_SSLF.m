%% Trim in Steady State Level Flight
%
%  Velosity and altitude for Steady State Level Flight
V0    = 80;           % m/s
h     = 2000;         % m


%% Initial controls
U0(1) = 2.0;      % Elevator, deg
U0(2) = 0.0;      % Aileron,  deg
U0(3) = 0.0;      % Rudder,   deg
U0(4) = 0.5;      % Throttle, percents

%% Initial state vector
theta = 0;            % pitch angle, rad
beta  = 0;            % sideslip, rad
alpha = theta;        % in SSLF

V0b = wind2body(V0,alpha,beta); 

X0(1)  =  V0b(1);    % u, m/s
X0(2)  =  V0b(2);    % v, m/s
X0(3)  =  V0b(3);    % w, m/s
X0(4)  =  0;         % p, rad/s
X0(5)  =  0;         % q, rad/s
X0(6)  =  0;         % r, rad/s
X0(7)  =  0;         % phi, rad
X0(8)  =  0;         % theta, rad
X0(9)  =  0;         % psi, rad
X0(10) =  0;         % x_pos, m
X0(11) =  0;         % y_pos, m
X0(12) = -h;         % altitude, m

V_dot     = 0;
alpha_dot = 0;
beta_dot  = 0;

%% Initial trim parameters
P0(1) = U0(1);    % elevator
P0(2) = U0(4);    % throttle
P0(3) = X0(8);    % theta, rad



%% Find the trim (equilibrium) state
[P,f,ExitFlag,Output] = fminsearch(@(P) trim_cost_SSLF(P,X0,U0), P0, optimset('TolFun',1e-12));
P
ExitFlag



%% Update state and control vectors to trimmed state
theta = P(3);      % rad
alpha = theta;     % rad

V0b = wind2body(V0,alpha,beta);

X0(1) = V0b(1);    
X0(2) = V0b(2);    
X0(3) = V0b(3);    
X0(8) = theta;     % theta, rad
U0(1) = P(1);      % elevator, deg
U0(4) = P(2);      % throttle, percent