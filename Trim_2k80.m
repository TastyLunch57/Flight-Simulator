%% Steady straight and level flight, V=80 m/s, altitude=2000m
trim.StickLat =  0;
trim.StickLon = -1.6316/20;
trim.TLA      =  0.1929;
trim.StabDeg  =  0;
trim.Pedals   =  0;

% Initial velosity in body-fixed axes u,v,w, m/s
trim.Vb         =  [79.7701  0.0  6.0608]';
% Initial position in local NED axes, m
trim.PositionE  =  [0 0 -2000]';
% Initial angular rates p,q,r in body-fixed axes, rad/s
trim.OmegaB     =  [0 0 0]';
% Initial roll, pitch and yaw angles, rad
trim.AttitudeBE =  [0, 0.0758, 0]'; % roll, pitch, yaw


%% Initial conditions for trim: 
% X0(1)  =  V0b(1);    % u, m/s
% X0(2)  =  V0b(2);    % v, m/s
% X0(3)  =  V0b(3);    % w, m/s
% X0(4)  =  0;         % p, rad/s
% X0(5)  =  0;         % q, rad/s
% X0(6)  =  0;         % r, rad/s
% X0(7)  =  0;         % phi, rad
% X0(8)  =  0;         % theta, rad
% X0(9)  =  0;         % psi, rad
% X0(10) =  0;         % x_pos, m
% X0(11) =  0;         % y_pos, m
% X0(12) = -h;         % altitude, m
% 
% U0(1) = 1.0;      % Elevator, deg
% U0(2) = 0.0;      % Aileron,  deg
% U0(3) = 0.0;      % Rudder,   deg
% U0(4) = 0.5;      % Throttle, percents

%% Results of trimming
% X_trim'  
% ans =
%           89.8394959470165
%                          0
%           5.37261277089718
%                          0
%                          0
%                          0
%                          0
%         0.0597312094600456
%                          0
%                          0
%                          0
%                      -2000
% U_trim'
% ans =
%          -1.12666372201034
%                          0
%                          0
%          0.221107093238377                    
        
