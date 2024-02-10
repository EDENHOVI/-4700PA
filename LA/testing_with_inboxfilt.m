
ni = 2000;
nx = 200;
ny = 200;
V = zeros(nx, ny); %represents Tmin
n2 = 3000;
% Set boundary conditions
V(:, 1) = 1;  % Left boundary condition
V(:, end) = 0; % Right boundary condition
                %this will set the bottom and top boundary condition to be
                %=0
R = zeros(nx,ny);





%Using imbox fill


for k = 1:ni

   
    R = imboxfilt(R,3);
    surf(R);
    
end 
