function y = sweep(u, f, istart, iend, jstart, jend, h)
    y = u;
    n = max(istart,iend);
    for i = linspace(istart, iend, abs(istart-iend)+1)
        for j = linspace(jstart, jend, abs(jstart-jend)+1)
            % u_xmin
            if i == 1
                a = u(i+1,j);
            elseif i == n
                a = u(i-1,j);
            else
                a = min(u(i-1,j), u(i+1,j));
            end

            % u_ymin
            if j == 1
                b = u(i,j+1);
            elseif j == n
                b = u(i,j-1);
            else
                b = min(u(i,j-1), u(i,j+1));
            end

            % solve equation
            if abs(a-b) >= f(i,j)*h
                y(i,j) = min(a,b) + f(i,j)*h;
            else
                y(i,j) = (a + b + sqrt(2*(f(i,j)*h)^2 - (a-b)^2)) / 2;
            end
            u(i,j) = min(u(i,j), y(i,j));
        end
    end
    y = u;