
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


for k = 1:ni
    % Iterate over the entire grid to update V based on ni, n
    for i = 1:nx
        for j = 1:ny
            

            if i == 1
                V(i,j) = 1; %left boundary condition
            

            elseif i == nx
                V(i,j)= 0; %right boundary condition
            

            elseif j == 1
                V(i,j) = 0; %top boundary condition
            
            
            elseif j == ny
                V(i,j) = 0; %bottom boundry condition


            
            else
                V(i,j) = (V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1))/4; %this isn also equal to Tmin in 2 dimensions
                %V(i,j)= imboxfilt(V,3);
        end

       

        end
    end
    
    % Plot the solution (if needed)
    if mod(k, 50) == 0 % Plot every 50th iteration
        subplot(1,2,1);
        surf(V);
        xlabel('x');
        ylabel('y');
        zlabel('V');
        title(['Solution to Laplace''s equation - Iteration ', num2str(k)]);
        drawnow; % Force MATLAB to update the plot
    end
end






%-----------------------------------------------------------------------------------------------------------------

for k = 1:n2
    % Iterate over the entire grid to update V based on ni, n
    for i = 1:nx
        for j = 1:ny
            

            if i == 1
                V(i,j) = 1; %left boundary condition
            

            elseif i == nx
                V(i,j)= 0; %right boundary condition
            

            %now setting the derivative across the y or j direction to
            %be = 0 i will assign all J's to be equal
            elseif j == 1
                V(i,j) = V(i,j+1); %top boundary condition
            
            
            elseif j == ny
                V(i,j) = V(i,j-1); %bottom boundry condition
            
            else
            
                V(i,j) = (V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1))/4; %this isn also equal to Tmin in 2 dimensions
            %V(i,j)= imboxfilt(V,3);
        end

       

        end
    end
    
    % Plot the solution (if needed)
    if mod(k, 50) == 0 % Plot every 50th iteration
        subplot(1,2,2);
        surf(V);
        xlabel('x');
        ylabel('y');
        zlabel('V');
        title(['Solution to Laplace''s equation - Iteration (with d/dy =0 ', num2str(k)]);
        drawnow; % Force MATLAB to update the plot
    end
end

figure
[Ex,Ey] = gradient(V);
quiver(-Ex',-Ey',10);


%---------------------------------------------------------------------------------------------------------
