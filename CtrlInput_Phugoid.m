function y = CtrlInput_Phugoid(t)

d = interp1([0 10 10.1 19.9 20 30],[0 0 1 1 0 0],t,'linear',0);    

y = zeros(4,length(d));
y(1,:) = d;

end




