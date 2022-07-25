%% Control inputs
% 
% Example:
% simin.X  = [0.0  5.0 10.0 Tsim     - time
%             0.0 10.0 10.0 0.0]';     - signal 

%% Steady straight and level flight:

%  Simulation time, sec
Tsim = 150;

% Control inputs, normalized
simin.StickLon  = [0 8 8.1 9.9 10 12 Tsim     
                   0 0 0 0  0  0 0.0]';    
                    
simin.StickLat  = [0.0 5.0 10.0 Tsim 
                   0.0 0.0  0.0 0.0]';

simin.Pedals    = [0.0 5.0 5.1 10.0 11.0 Tsim 
                   0.0 -0.09 0.0  0.0 0.0 0.0]';

simin.StabDeg   = [0.0 5.0 10.0 Tsim 
                   0.0 0.0  0.0 0.0]';

simin.TLA       = [0.0 5.0 10.0 Tsim 
                   0.0 0.0  0.0 0.0]';