function cost = trim_cost_SSLF(P,x,u)
%% Cost function for Steady State Level Flight
%
%  x    - state vector 
%  u    - control vector
%
%  P(1) - elevator, deg
%  P(2) - throttle, percents
%  P(3) - theta, rad

% Velosity vector V=sqrt(u^2+v^2+w^2)
V = sqrt(x(1)^2 + x(2)^2 + x(3)^2);

% alpha = theta in SSLF
alpha = P(3);
beta  = 0;

% Velosity in body fixed frame. Recalculate for new alpha
Vb = wind2body(V,alpha,beta); 

% current state vector
X =	[Vb(1)      % u
     Vb(2)      % v
     Vb(3)      % w
     x(4)       % p 
     x(5)       % q
     x(6)       % r
     x(7)       % phi
     P(3)       % theta
     x(9)       % psi
     x(10)      % x
     x(11)      % y
     x(12)];    % z
 
% control vector 
U =	[P(1)       % elevator
     u(2)       % aileron
     u(3)       % rudder
     P(2)];     % throttle
 
% state vector time derivative 
x_dot = EoM12(0.01,X,U);

% derivatives which have to be zero in SSLF 
e = [x_dot(1)    % u_dot
     x_dot(3)    % w_dot
     x_dot(5)];  % q_dot
 
cost = e'*e;

end