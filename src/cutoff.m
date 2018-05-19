%% cutoff function
% gamma should be greater than beta.
% if input is less than beta, output 1.
% if input is between beta and gamma, output some value between 0 and 1.
% if input is greater than gamma, output gamma.
function y=cutoff(x,beta,gamma)
n=size(x);
y=zeros(n);
for i=1:n(1)
    for j=1:n(2)
        if(abs(x(i,j)) <= beta)
            y(i,j) = 1;
        elseif(abs(x(i,j)) <= gamma)
            y(i,j) = (abs(x(i,j))-gamma).^2.*(2*abs(x(i,j))+gamma-3*beta)/((gamma-beta)^3);
        end
    end
end
end