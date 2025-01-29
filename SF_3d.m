function [dx] = SF_3d(t,X,phi_min,phi_max,eta,k,r)
x=X(1);
y=X(2);
phi=X(3);
dx(1,1)=(k^(-1))*(x*(1-phi*x)-(x*y)/(1+eta*x));
dx(2,1)=(x*y)/(1+eta*x)-y;

if phi> phi_min & phi<phi_max
dx(3,1)=r;
else
 dx(3,1)=0;   
end

end