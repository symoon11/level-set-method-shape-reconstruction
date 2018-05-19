function new_u = circle(u, n, a, b, r)
    new_u = u;
    x = linspace(-2,2,n);
    y = linspace(-2,2,n);
    h = x(2) - x(1);
    for i = 1:n
        for j = 1:n
            [theta, rr]=cart2pol(x(i)-a,y(j)-b);
            if(rr>r-h/2 && rr<r+h/2)
                new_u(i,j)=0;
            end
        end
    end

