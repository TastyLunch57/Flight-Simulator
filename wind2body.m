function Vb = wind2body(V0,a,b)
%% Transformation from wind to body axes
%
%  V0 - velosity in wind axes, m/s
%  a  - angle of attack, rad
%  b  - sideslip, rad
%
%  Vb = [u v w]' - velocity vector projections on body fixed axes

Vw = [V0 0 0]';

csa = cos(a); sna = sin(a);
csb = cos(b); snb = sin(b);

% from wind to body transformation
Tbw = [csa*csb     -csa*snb     -sna
       snb          csb          0
       sna*csb     -sna*snb      csa];

% velocity in body axes:
Vb = Tbw*Vw;

end


























