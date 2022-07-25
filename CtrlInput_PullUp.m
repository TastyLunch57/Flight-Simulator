function y = CtrlInput_PullUp(t)

d1 = interp1([0   10 10.1 180],[0 0 -10 -10],t,'linear',-28);    

y = zeros(4,length(d1));
y(1,:) = d1;

end




