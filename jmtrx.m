function [f,dfdx] = jmtrx(func,x,xincr,nx,nf)
% Jacobian calculation

dfdx = zeros(nf,nx);

for i=1:nx
    x0i       = x(i);
    x(i)      = x0i + xincr(i,2);
    fr = feval(func,x);
    x(i)      = x0i + xincr(i,1);
    fl = feval(func,x);
    dfdx(:,i) = (fr - fl)/(xincr(i,2)-xincr(i,1));
    x(i)      = x0i;
end

f = feval(func,x);

end