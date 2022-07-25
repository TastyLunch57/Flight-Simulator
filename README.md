# Flight-Simulator
Flight simulator created using MATLAB + Simulink
Hello everyone :)

The current model is a simulator that can be plugged into flight gear and flown for practically any aircraft*.
The order in which the simulation is ran for the Cessna:

1) Run BJinit (initalistation file)
2) Run aero/BJprop just to make sure to generate the relevant variables
3) Run Plot_Aerocof (aerodynamic coefficients)
4) Trim the model for desired velocity and altitude (Model_Trim_SSLF)
5) Run Model_Flight for various control inputs ShortPeriod/Phugoid etc.
6) Create Trim files for desired period of motion
7) Trim_2k80 is a trm for 80 m/s velocity and altitude of 2k
8) Start the simulator (.slx file) with all variables created and start the simulation at desired trim position and control input(the available Controlsinput and trim script are given as an example). 
9) Input control variables to observe the simulation of flight in Simulink or alternitavely set up flight simulator in person and connect to flight gear and observe change in real time(Scopes are added to simulink to observe simulation, increaste t(time of simulation) to observe more lengthy phenomena such as loops etc.)


Notes:
*please be aware that initalistation files, propulsion and the aerodynamic properites must be amended for other aircraft for successful results(can be obtained using XFLR5 for example).
*All files must share location to avoid any errors
