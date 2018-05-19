function f = linesetting(u, n, aa, bb)
    f = u;
    x = linspace(-2,2,n);
    y = linspace(-2,2,n);
    h = x(2) - x(1);
    a = aa(2) - bb(2); b = bb(1) - aa(1); c = aa(1)*bb(2) - bb(1)*aa(2);
    for i = 1:n-1
        for j = 1:n-1
            if (x(i)+h < min(aa(1), bb(1)) || x(i)-h > max(aa(1),bb(1)) || y(j)+h < min(aa(2),bb(2)) || y(j)-h > max(aa(2),bb(2)))
                continue;
            end 
            if (abs( a*x(i)+b*y(j)+c) < h )
               f(i,j) = 0;
            end
        end
    end

