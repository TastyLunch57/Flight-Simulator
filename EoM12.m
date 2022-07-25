function XX_dot = EoM12(t,XX,U)

global aeromodel control_input aircraft_data propulsion_model
global V_dot alpha_dot beta_dot


%% Aircraft data
m   = aircraft_data.MassKg;
Ixx = aircraft_data.IxxKgM2;
Iyy = aircraft_data.IyyKgM2;
Izz = aircraft_data.IzzKgM2;
Ixz = aircraft_data.IxzKgM2;

S = aircraft_data.S;   % m2
b = aircraft_data.b;   % m
c = aircraft_data.c;   % m



%% Initialize local variables from state vector 
u = XX(1);        % m/s
v = XX(2);        % m/s
w = XX(3);        % m/s

p = XX(4);        % rad/s
q = XX(5);        % rad/s
r = XX(6);        % rad/s

phi   = XX(7);    % rad
theta = XX(8);    % rad
psi   = XX(9);    % rad

xe = XX(10);      % m
ye = XX(11);      % m
ze = XX(12);      % m


% Wind frame variables
V = sqrt(u^2+v^2+w^2); % m/s

alpha = atan(w/u);   % rad
beta  = asin(v/V);   % rad


% Air density and speed of sound at altitude h,m
[rho,a] = atmosphere(-ze/1000.0);  % air density - kg/m3, speed of sound - m/s

% Dynamic pressure
Q = rho*V^2/2;

% Mach number
Mach = V/a;


%% Controls input: Trim (constant) + Pilot input (time history)
if isempty(control_input)
    dU = zeros(4,1);
else
    dU = control_input(t);
end

De = U(1) + dU(1); % deg
Da = U(2) + dU(2); % deg
Dr = U(3) + dU(3); % deg
Dt = U(4) + dU(4); % [0 1]
    

%% Nondimensional angular rates
p_ = p*b/(2*V);
q_ = q*c/(2*V);
r_ = r*b/(2*V);

alpha_dot_ = alpha_dot*c/(2*V);
beta_dot_  = beta_dot*b/(2*V);


%% Nondimensional aerodynamic forces and moments
Caero = aeromodel(alpha, beta, Mach, De,Da,Dr, p_,q_,r_, alpha_dot_);

CX = -Caero(1)*cos(alpha) + Caero(3)*sin(alpha);
CZ = -Caero(1)*sin(alpha) - Caero(3)*cos(alpha);

% Dimensional aerodynamic forces and moments
X = CX      *Q*S;    % N
Y = Caero(2)*Q*S;    % N
Z = CZ      *Q*S;    % N
L = Caero(4)*Q*S*b;  % Nm
M = Caero(5)*Q*S*c;  % Nm
N = Caero(6)*Q*S*b;  % Nm


%% Engine forces and moments, N and Nm
FMprop = propulsion_model(-ze,Mach,Dt); 


%% Total forces and moments (aerodynamic + propulsion)
X = X + FMprop(1);
Y = Y + FMprop(2);
Z = Z + FMprop(3);
L = L + FMprop(4);
M = M + FMprop(5);
N = N + FMprop(6);


%% Equations of motion in body fixed axes

g = 9.81;         % m/s2

% Force equations
u_dot = 1/m * X  -  g*sin(theta)           +  r*v-q*w;
v_dot = 1/m * Y  +  g*sin(phi)*cos(theta)  +  p*w-r*u;
w_dot = 1/m * Z  +  g*cos(phi)*cos(theta)  +  q*u-p*v;


% Moment equations in body-fixed axes
Id = Ixx*Izz - Ixz^2;

p_dot = Izz/Id * ( L + Ixz*p*q - (Izz-Iyy)*q*r )  +  Ixz/Id*( N - Ixz*q*r - (Iyy-Ixx)*p*q );
q_dot = 1/Iyy  * ( M +         - (Ixx-Izz)*p*r    -  Ixz*(p^2-r^2) );
r_dot = Ixz/Id * ( L + Ixz*p*q - (Izz-Iyy)*q*r )  +  Ixx/Id*( N - Ixz*q*r - (Iyy-Ixx)*p*q ); 


% Euler angles
phi_dot   =  p + ( q*sin(phi) + r*cos(phi) )*tan(theta);
theta_dot =        q*cos(phi) - r*sin(phi);
psi_dot   =      ( q*sin(phi) + r*cos(phi) )/cos(theta);


% Navigation equations
cspsi   = cos(psi);      snpsi   = sin(psi);
cstheta = cos(theta);    sntheta = sin(theta);
csphi   = cos(phi);      snphi   = sin(phi);

xe_dot =    u*cspsi*cstheta  +  v*(cspsi*sntheta*snphi - snpsi*csphi)  +  w*(cspsi*sntheta*csphi + snpsi*snphi);
ye_dot =    u*snpsi*cstheta  +  v*(snpsi*sntheta*snphi + cspsi*csphi)  +  w*(snpsi*sntheta*csphi - cspsi*snphi);
ze_dot = -( u*sntheta        -  v*cstheta*snphi                        -  w*cstheta*csphi );


%% State vector drivative
XX_dot(1)  = u_dot;
XX_dot(2)  = v_dot;   
XX_dot(3)  = w_dot;
XX_dot(4)  = p_dot;
XX_dot(5)  = q_dot;
XX_dot(6)  = r_dot;
XX_dot(7)  = phi_dot;
XX_dot(8)  = theta_dot;
XX_dot(9)  = psi_dot;
XX_dot(10) = xe_dot;
XX_dot(11) = ye_dot;
XX_dot(12) = ze_dot;

XX_dot = XX_dot(:);


%% Additional states
V_dot     = (u*u_dot + v*v_dot + w*w_dot)/V;
alpha_dot = (u*w_dot - w*u_dot)/(u^2+w^2);
beta_dot  = (V*v_dot - v*V_dot)/(V*sqrt(u^2+w^2));

end