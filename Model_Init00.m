%% Mass and tensor of inertia of the aircraft
MassKg  = 3000;
MoIKgM2 = [15370.0      0.0    1009.3
               0.0  19268.0       0.0
            1009.3      0.0   32647.0];

%% Geometrical properties of the aircraft        
WingSpan = 13.20; % m
MAC      =  1.57; % m
WingArea = 19.50; % m
        
%% Engine location, m
EnginePosition_Left  = [-2.2; -1.26; -1.18*0]; 
EnginePosition_Right = [-2.2;  1.26; -1.18*0];        

%% Aircraft location at t=0 (East Midlands airport)
lat0 = 52.8259; % °N
lon0 = -1.3308; % °W
alt0 =  0.0;    %  93m
