function [g,f] = Gamma(u, func, n, choice)
    x = linspace(-2,2,n);
    y = linspace(-2,2,n);
    func(1:n,1:n) = 1;
    switch (choice)
        case 1  % circle
            u=Circle(u,n,0,0,1);
        case 2  % rectangle
            bottom = floor(n/4); top = floor(3*n/4);
            for i = bottom:top
                u(i,bottom)=0;   u(i,top)=0;
                u(bottom,i)=0;   u(top,i)=0;
            end
        case 3  % star
            star = zeros(10,2);
            for i = 1:10
                if mod(i,2) == 1
                    star(i,1) = 1.8 * cos(2*pi/5 * (i-1)/2);
                    star(i,2) = 1.8 * sin(2*pi/5 * (i-1)/2);
                end
            end
            star(2,:) = intersect(star(1,:),star(5,:),star(3,:),star(9,:));
            star(4,:) = intersect(star(1,:),star(5,:),star(3,:),star(7,:));
            star(6,:) = intersect(star(3,:),star(7,:),star(5,:),star(9,:));
            star(8,:) = intersect(star(1,:),star(7,:),star(5,:),star(9,:));
            star(10,:) = intersect(star(1,:),star(7,:),star(3,:),star(9,:));
            for i = 1:9
               u = linesetting(u, n, star(i,:),star(i+1,:)); 
            end
            u = linesetting(u, n, star(10,:), star(1,:));
        case 4  % 4 circles
            u=Circle(u,n,1,1,0.5);
            u=Circle(u,n,1,-1,0.5);
            u=Circle(u,n,-1,1,0.5);
            u=Circle(u,n,-1,-1,0.5);
        case 5  % random 100 points
            r = randi(n,100,2);
            for i = 1:100
                u(r(i,1),r(i,2)) = 0;
            end
        case 6  % crossroads
            center = round(n/2);
            u(center,center) = 0;
            bottom = floor(n/8);    top = floor(3*n/8);
            func(top+(-1:1),bottom:top) = inf;                     func(bottom:top,top+(-1:1)) = inf;
            func(center+bottom+(-1:1),bottom:top) = inf;           func(center+(bottom:top),top+(-1:1)) = inf;
            func(top+(-1:1),center+(bottom:top)) = inf;            func(bottom:top,center+bottom+(-1:1)) = inf;
            func(center+bottom+(-1:1),center+(bottom:top)) = inf;  func(center+(bottom:top),center+bottom+(-1:1)) = inf;
        case 7  % circle points
            for i = 1:10
               u(round(n/2 + n/16*cos(pi/5 * i)),round(n/2 + n/16*sin(pi/5 * i))) = 0;
            end
        case 8  % one point
            u(round(n/2),round(n/2)) = 0;
        case 9  % walls
              u(1,1)=0;
              func=Circlewall(func, n, 0.6, 3*pi/2, pi-0.01);
              func=Circlewall(func, n, 1, pi/2, 2*pi);
              func=Circlewall(func, n, 1.4, 3*pi/2, pi-0.01);
        case 10 % velocity
            u(1,1) = 0;
            for i = 1:n
                for j = floor(n/2)+1:n
                    func(i,j) = 2;
                end
            end
        otherwise
            disp('Wrong Value (setting gamma)');
    end
	g = u;
    f = func;
    
