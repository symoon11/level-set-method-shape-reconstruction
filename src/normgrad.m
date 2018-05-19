function y=normgrad(phi,h)
n=size(phi);
y=zeros(n);
for i=2:n(1)-1
    for j=2:n(2)-1
        phi_x=(phi(i+1,j)-phi(i-1,j))/(2*h);
        phi_y=(phi(i,j+1)-phi(i,j-1))/(2*h);
        y(i,j)=(phi_x^2+phi_y^2)^0.5;
    end
end
end