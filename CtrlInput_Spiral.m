function y = CtrlInput_Spiral(t)

d = interp1([0 6 6.1 9.9 10 12],[0 0 -5 -5 -0.25 -0.25],t,'linear',-0.25);    

y = zeros(4,length(d));
y(3,:) = d;

end