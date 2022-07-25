function y = CtrlInput_ShortPeriod(t)

d = interp1([0 8 8.1 9.9 10 12],[0 0 -10 -10  0  0],t,'linear',0);    

y = zeros(4,length(d));
y(1,:) = d;

end
