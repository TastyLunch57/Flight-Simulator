function y = CtrlInput_Roll(t)

d = interp1([0 6 6.1 9.9 10 12],[0 0 -5 -5 0 0],t,'linear',0);    

y = zeros(4,length(d));
y(2,:) = d;

end