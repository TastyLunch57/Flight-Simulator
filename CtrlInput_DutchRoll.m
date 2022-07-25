function y = CtrlInput_DutchRoll(t)

d = interp1([0 6 7 9 10 12],[0 0 -10 10 0 0],t,'linear',0);    

y = zeros(4,length(d));
y(3,:) = d;

end


