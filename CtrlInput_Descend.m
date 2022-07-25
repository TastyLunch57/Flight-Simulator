function y = CtrlInput_Descend(t)

d = interp1([0 10 11 300],[0 0 -0.25 -0.25],t,'linear',0);    

y = zeros(4,length(d));
y(4,:) = d;

end