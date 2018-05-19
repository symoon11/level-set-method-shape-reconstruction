function phi=redist(phi,h,index)

s=zeros(size(phi));
for k = index
    i = k(1);
    j = k(2);
    s(i,j) = phi(i,j)/sqrt(phi(i,j)^2+h^2);
end
dt = 1/256;
for k = index
    i = k(1);
    j = k(2);
    phi(i,j)=phi(i,j)-dt*s(i,j)*G(i,j,phi,h);
end