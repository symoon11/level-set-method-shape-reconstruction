function [phi_x,phi_y]=grad1(i,j,phi,h)
phi_x=(phi(i+1,j)-phi(i-1,j))/(2*h);
phi_y=(phi(i,j+1)-phi(i,j-1))/(2*h);
end