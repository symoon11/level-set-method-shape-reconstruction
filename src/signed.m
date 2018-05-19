function d = signed(d, u ,n )
    % returning signed distance function
    % input
    % d : distance function
    % u : matrix
    % Output
    % d : signed distance function

    for i = 1:n
        for j= 1:n
            if u(i,j)<1
                d(i,j) = -d(i,j);
            end
        end
    end
  
end

