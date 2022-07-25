function FM = BJprop(h,M,dt)


FM = zeros(6,1);
[dens,a] = atmosphere(h/1000)
FM(1) = dt*2*6490*(dens/1.225)^0.7*(1-exp((h-17000)/2000)); % N

end