% Continuous-time state-space lon and lat/dir models
sys_lon = ss(A_lon,B_lon,C_lon,D_lon,'statename',{'u','w','q','theta'},'inputname',{'elevator','throttle'});
sys_lat = ss(A_lat,B_lat,C_lat,D_lat,'statename',{'v','p','r','phi'},'inputname',{'aileron','rudder'});


%% Transfer functions. 
%  Responces of (u,w,q,theta) on elevator and throttle input
tf(sys_lon)   % polynomials form of TF
%zpk(sys_lon)  % zero-pole-gain form of TF

%  Responces of (v,p,r,phi) on ailerons and rudder input
tf(sys_lat)   % polynomials form of TF
%zpk(sys_lat)  % zero-pole-gain form of TF


%  Plot impulse responses
figure
impulseplot(sys_lon)

figure
impulseplot(sys_lat)

%  Plot step response
figure
stepplot(sys_lon)

figure
stepplot(sys_lat)



% Plot Bode frequency response
%  bodeplot(sys_lon)
%  bodeplot(sys_lat)

%  Plot initial condition response and return plot handleexpand all in page
%  initialplot(sys_lon, x0(i_lon_x))
%  initialplot(sys_lon, x0(i_lat_x))

