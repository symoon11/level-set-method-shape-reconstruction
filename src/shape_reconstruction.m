%% Initialize
clear; clc;

p = 1;
n =101;
max_iter=200;
x = linspace(-2,2,n);   % uniform grid
y = linspace(-2,2,n);
z = (1:1:max_iter);
[X,Y]=meshgrid(x,y);
h = x(2) - x(1);
e = 0.3;
gamma = 4*h;
beta = 2*h;
u = zeros(n,n);
u(1,:)=ones(1,n);
u(n,:)=ones(1,n);
u(:,1)=ones(n,1);
u(:,n)=ones(n,1);
a_old=[0,0];

d(1:n,1:n) = inf;
f(1:n,1:n) = 1;

%% Setting gamma
% 1. circle / 2. square / 3. star 4. four circles
choice = 1;
[d,f] = Gamma(d, f, n, choice);

% plotting data set
[data0,data1] = find(d == 0);
data0 = (data0 - 51)/25;
data1 = (data1 - 51)/25;
figure(1);
plot(data0, data1, 'x')
hold on
xlim([-2,2])
ylim([-2,2])
title('given data set')

%% Sweep
% i = 1:n, j = 1:n
d = sweep(d,f,1,n,1,n,h);

% i = n:1, j = 1:n
d = sweep(d,f,n,1,1,n,h);

% i = n:1, j = n:1
d = sweep(d,f,n,1,n,1,h);

% i = 1:n, j = n:1
d = sweep(d,f,1,n,n,1,h);
% need more sweeps when there are walls.
% u = sweep(u,f,1,n,1,n,h);
% u = sweep(u,f,n,1,1,n,h);
% u = sweep(u,f,n,1,n,1,h);
% u = sweep(u,f,1,n,n,1,h);

%figure(5);  surf(x,x,d);


u = sweepinitial(d, u, n, 1, 1, e);
u = sweepinitial(d, u, n, -1, 1, e);
u = sweepinitial(d, u, n, -1, -1, e);
u = sweepinitial(d, u, n, 1, -1, e);

% initial guess
[initial0,initial1] = find(u == 0.5);
initial0 = (initial0 - 50)/25;
initial1 = (initial1 - 50)/25;

% plot initial guess
figure(4);
plot(initial0, initial1, '.')
xlim([-2,2])
ylim([-2,2])
title('initial guess')

d1=zeros(n,n); % distance from initial guess

for i = 1:n
    for j= 1:n
        if (u(i,j)==1)
            d1(i,j) = d(i,j)-e;
        elseif u(i,j)==0.5
            d1(i,j) = e-d(i,j);
        else
            d1(i,j) = inf;
        end
    end
end

%% Sweep
% i = 1:n, j = 1:n
d1 = sweep(d1,f,1,n,1,n,h);

% i = n:1, j = 1:n
d1 = sweep(d1,f,n,1,1,n,h);

% i = n:1, j = n:1
d1 = sweep(d1,f,n,1,n,1,h);

% i = 1:n, j = n:1
d1 = sweep(d1,f,1,n,n,1,h);

phi = signed(d1,u,n);


%% solve the equation
for t=1:max_iter
    % uses Euler method
    [index1,index2,phi] = narrowband(phi,gamma);
    E = energy(phi,d,index1,x,y,p);
    L = zeros(n,n);
    maxspeed = 0;
    for k = index1
        i = k(1);
        j = k(2);
        [px1, py1] = grad1(i,j,phi,h); % gradient of phi using central difference method
        ng = sqrt(px1^2+py1^2); % norm of the gradient
        [pxx,pyy,pxy] = hessi(i,j,phi,h);
        [dx,dy] = grad1(i,j,d,h);
        curv = (pxx*py1^2-2*px1*py1*pxy+pyy*px1^2)/(px1^2+py1^2)^1.5; % curvature of level set curve
        L(i,j) = cutoff(phi(i,j),beta,gamma)*E*d(i,j)^(p-1)*((dx*px1+dy*py1)+1/p*d(i,j)*curv*ng);
        speed = L(i,j)/ng;
        if(speed > maxspeed)
            maxspeed = speed;
        end
    end
    
    dt = 0.5*h/maxspeed; % satisfies CFL condition
    
    for k = index1
        i = k(1);
        j = k(2);
        phi(i,j) = phi(i,j)+dt*L(i,j);
    end
    
    % plot current surface
    figure(3);
    [a,b]=contourf(X,Y,-phi,[0,0],'r');
    
    % plot current surface with the given data set
    figure(1);
    if t == 1
        plt1 = plot(a(1,2:length(a)),a(2,2:length(a)));
        set(plt1, 'XDataSource', 'x1')
        set(plt1, 'YDataSource', 'y1')
    else
        x1 = a(1,2:length(a));
        y1 = a(2,2:length(a));
        
        refreshdata
        drawnow
    end
    title('Level Set Method')
    
    % plot(stack) phi according to step-time
    figure(2);
    plot3(a(1,2:length(a)),a(2,2:length(a)),t*ones(length(a)-1))
    title('tower')
    zlim([1 max_iter])
    hold on
    drawnow
    pause(0.01);

    % find a new signed distance function of phi
    for l=1:10
        phi=redist(phi,h,[index1,index2]);
    end
    
    % terminate condition
    % terminate code when the contour 'a' doesn't change
    if size(a_old, 2)==size(a, 2)
        disp('same')
        norm(a_old-a)
        if norm(a_old-a)<10^-5
            disp('really same')
            break
        end
    end
    
    a_old=a; % update a_old
end

disp('end');