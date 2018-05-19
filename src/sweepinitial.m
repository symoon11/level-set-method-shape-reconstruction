function u = sweepinitial(d, u, n, sgni, sgnj, e)
% function for initial guessing using sweep method
% input
% d : distance function
% u : matrix
% n : grid size
% sgni, sgnj : direction for sweep
% e : epsilon
% output
% u : sweeped matrix

% set start & end points
if sgni >0
    istart = 1; iend = n;
else
    istart = n; iend = 1;
end

if sgnj >0
    jstart = 1; jend = n;
else
    jstart = n; jend = 1;
end

% sweeping
for i = linspace(istart, iend, abs(istart-iend)+1)
    for j = linspace(jstart, jend, abs(jstart-jend)+1)
        
        % is it tagged?
        if u(i,j) == 1
            
            % if its neighbor points >= eps
            if i+sgni<=0 || i+sgni>=n+1
                
            else
                if abs(d(i+sgni,j))>=e
                    u(i+sgni,j)=1;
                else
                    u(i+sgni,j)=0.5;
                end
            end
            if  j+sgnj<=0 || j+sgnj>=n+1
                
            else
                if abs(d(i,j+sgnj))>=e
                    u(i,j+sgnj)=1;
                else
                    u(i,j+sgnj)=0.5;
                end
            end
        end
    end
end
end