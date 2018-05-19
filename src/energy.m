%% Energy
% calculate the energy functional E(phi)
function y=energy(phi,d,index,x,y,p)
h = x(2)-x(1);
eps = 1.5*h;
int = zeros(size(phi));
delta = zeros(size(phi));
for k = index
    i = k(1);
    j = k(2);
    if abs(phi(i,j)) < eps
        delta(i,j) = 1/2/eps*(1+cos(pi*phi(i,j)/eps));
        int(i,j) = delta(i,j)*d(i,j)^p*norm(grad1(i,j,phi,h));
    end 
end
y = (trapz(y,trapz(x,int,1),2))^(1/p-1);
end