function [phi_xx,phi_yy,phi_xy]=hessi(i,j,phi,h)
phi_xx=(phi(i+1,j)-2*phi(i,j)+phi(i-1,j))/h^2;
phi_yy=(phi(i,j+1)-2*phi(i,j)+phi(i,j-1))/h^2;
phi_xy=(phi(i+1,j+1)+phi(i-1,j-1)-phi(i-1,j+1)-phi(i+1,j-1))/(4*h^2);
end