clear all;
L = 100;
h = 10;
Tf = 10;
lamda = 1;
T_zuo = 100;
T_shang = 200;
x = 0:1:100;
y = 0:1:100;
[X,Y] = meshgrid(x,y);
z = zeros(size(X,1),size(Y,1));
figure(1)
surf(x,y,z);
dx = L/(size(X,1)-1);
dy = L/(size(Y,1)-1);
n_x = size(X,1);
n_y = size(Y,1);
t = 0;
while 1
    %t_n = z(floor(n_x/2),floor(n_y/2));
    z_n = z;
    z(1,1) = (T_zuo+T_shang+z(1,2)+z(2,1))/4;
    z(1,n_y) = (lamda/2*(100+z(1,n_y-1)+z(2,n_y))+h/2*dx*Tf)/(3/2*lamda+h/2*dx);
    z(n_x,1) = (z(n_x-1,1)+300+z(n_x,2))/3;
    z(n_x,n_y) = (lamda/2*(z(n_x-1,n_y)+z(n_x,n_y-1))+dx/2*h*Tf)/(dx/2*h+lamda);
    
    for i = 2:1:n_x-1
        z(i,1) = (T_shang+z(i-1,1)+z(i+1,1)+z(i,2))/4;
        z(i,n_y) = (lamda/2*(z(i-1,n_y)+z(i+1,n_y)+2*z(i,n_y-1))+dx*h*Tf)/(2*lamda+h*dx);
    end
    for i = 2:1:n_y-1
        z(1,i) = (T_zuo+z(1,i+1)+z(1,i-1)+z(2,i))/4;
        z(n_x,i) = (z(n_x,i+1)+z(n_x,i-1)+2*z(n_x-1,i))/4;
    end
    for i = 2:1:n_x-1
        for j = 2:1:n_y-1
            z(i,j) = (z(i-1,j)+z(i+1,j)+z(i,j-1)+z(i,j+1))/4;
        end
    end
    %t_m = z(floor(n_x/2),floor(n_y/2));
    t_n = abs(z-z_n);
    t = t+1;
    if max(t_n) < 1e-30
        break;
    end
    
end
figure(2)
surf(x,y,z);
colormap(jet);
colorbar;
xlabel('100');
ylabel('200');
hold on;
phi_up = 0;
phi_down = 0;
for i = 1:1:size(z,1)
    phi_up = lamda*(z(i,1)-T_shang)+phi_up;
    phi_down = h*(z(i,n_y)-Tf)*dx+phi_down;
end
figure(3);
[X,Y]=meshgrid(min(x):max(x),min(y):max(y));
Z=griddata(x,y,z,X,Y);
[c,h]=contour(X,Y,Z);
colormap(jet);
colorbar;