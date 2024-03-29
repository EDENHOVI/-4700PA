
clear all, close all;
% Constants
C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light

% Simulation parameters
num_steps = 1000;                   % Number of time steps
dt = 1e-15;                         % Time step size (1 femtosecond)
prob_scatter = 0.05;                % Probability of scattering at each time step

% Initialize variables
x = zeros(num_steps, 1);            % Position array
v = zeros(num_steps, 1);            % Velocity array

x(1) = 0;                           % Initial position
v(1) = 0;                           % Initial velocity

% Simulation loop
for t = 2:num_steps
    % Update position and velocity with a force (example: constant acceleration)
    F = C.q_0 * 1e-6;               % Example force (1 uN)
    a = F / C.m_0;                  % Acceleration (F = ma)
    v(t) = v(t-1) + a * dt;         % Update velocity
    x(t) = x(t-1) + v(t) * dt;      % Update position
    
    % Check for scattering
    if rand() < prob_scatter
        v(t) = 0;                   % Set velocity back to 0 if scattered
    end
    
    % Plotting in real time
    subplot(2, 1, 1);
    plot(1:t, x(1:t), 'b-');        % Plot position vs. time
    xlabel('Time');
    ylabel('Position');
    title('Position vs. Time');
    xlim([1, num_steps]);
    ylim([min(x), max(x)]);
    hold on;
    
    subplot(2, 1, 2);
    plot(1:t, v(1:t), 'r-');        % Plot velocity vs. time
    xlabel('Time');
    ylabel('Velocity');
    title('Velocity vs. Time');
    xlim([1, num_steps]);
    ylim([min(v), max(v)]);
    hold on;
    
    pause(0.01);                    % Pause for animation effect
end
