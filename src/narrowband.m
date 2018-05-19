%% narrowband
% make a narrow band with a width 2*e containing zero level set of phi
% index1 : points inside a narrowband
% index2 : points near a narrowband
function [index1,index2,y] = narrowband(x,e)    
n = size(x);
index1 = zeros(2,n(1)*n(2));
index2 = zeros(2,n(1)*n(2));
k1 = 0;
k2 = 0;
y=e*ones(size(x));
for i = 2:n(1)-1
    for j = 2:n(2)-1
        % append a point inside narrowband to index1 and mark it 2
        if abs(x(i,j)) < e
            k1 = k1+1;
            index1(:,k1) = [i;j];
            y(i,j) = x(i,j);
        else
            % append a point near narrowband to index2 and mark it 1
            for s=[-1,1]
                if abs(x(i+s,j)) < e || abs(x(i,j+s)) < e 
                    k2 = k2+1;
                    index2(:,k2) = [i;j];
                    break;
                end
            end
            if x(i,j) <= -e             
                y(i,j) = -e; % if the value of the function is less than -e, change it to -e
            end
        end
    end
end
index1(:,k1+1:end) = [];
index2(:,k2+1:end) = [];
end