function [v, y] = Fgrid(u, k,u0, x)
if nargin <4 && nargout ==1
    x = 0;
end

if nargin ==2
    u0 = 0;
end


n=length(u);
m = (n-1)*k;
v = u0 * ones(m+1,m+1);
y = linspace(min(x), max(x), m+1);
v(1:m,1:m) = kron(u(1:n-1,1:n-1), ones(k,k));
