function new_func = Circlewall(func, n, r, theta1, theta2)
    new_func = func;
    x = linspace(-2,2,n);
    y = linspace(-2,2,n);
    for i = 1:n
        for j = 1:n
            [theta, rr]=cart2pol(x(i),y(j));
            if( (rr>(r+0.1)) || (rr<(r-0.1)))
                continue;
            end
            if(theta<0)
                theta=2*pi+theta;
            end
            if((theta1 < theta2)  && theta>=theta1 && theta<=theta2)
                 new_func(i,j)=inf;
            end
            if((theta1 > theta2)  && (theta >=theta1 || theta <= theta2))
                 new_func(i,j)=inf;
            end
        end
    end
    
    