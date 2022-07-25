
global aeromodel control_input aircraft_data propulsion_model name surname
global V_dot alpha_dot beta_dot

%% Write your name and surname
name    = 'Kamil';
surname = 'Surname';


ft2m        = 0.3048;
lb2kg       = 0.453592;
slugft2kgm2 = 1.3558179619;

%% Parameters of Cessna 510 aircraft

aeromodel        = @C510aero;
propulsion_model = @BJprop;
control_input    = [];

aircraft_data.MassKg =  3000;            
aircraft_data.IxxKgM2 = 15370.0;
aircraft_data.IyyKgM2 = 19268.0;
aircraft_data.IzzKgM2 = 32647.0;
aircraft_data.IxzKgM2 = 1009.03;

aircraft_data.S = 19.50; % m2
aircraft_data.b = 13.2;   % m
aircraft_data.c = 1.57;   % m