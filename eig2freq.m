function [wn,z,tau,wd]=eig2freq(s)
% calculates natural frequency and damping ratio for eigenvalue 's'

for i=1:length(s)
    
    wn(i)  =  abs(s(i));
    
    if abs(real(s(i))) >= 100*eps && abs(imag(s(i))) >= 100*eps
        z(i)   = -cos(angle(s(i)));
        tau(i) =  1/(wn(i)*z(i));
        wd(i)  =  wn(i)*sqrt(1-z(i)^2);
        
    else
        z(i)   = NaN;
        tau(i) = Inf;
        wd(i)  = 0;
        
    end
    
end

wn  = wn(:);
z   = z(:);
tau = tau(:);
wd  = wd(:);

end