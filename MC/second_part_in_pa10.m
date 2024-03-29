% Constants
C.q_0 = 1.60217653e-19;             % electron charge (Coulombs)
C.hb = 1.054571596e-34;             % Dirac constant (Js)
C.h = C.hb * 2 * pi;                % Planck constant (Js)
C.m_0 = 9.10938215e-31;             % electron mass (kg)
C.kb = 1.3806504e-23;               % Boltzmann constant (J/K)
C.eps_0 = 8.854187817e-12;          % vacuum permittivity (F/m)
C.mu_0 = 1.2566370614e-6;           % vacuum permeability (H/m)
C.c = 299792458;                    % speed of light (m/s)

% Simulation parameters
num_particles = 5;                % Number of particles
num_steps = 1000;                   % Number of time steps
dt = 1e-15;                         % Time step size (1 femtosecond)
prob_scatter = 0.05;                % Probability of scattering at each time step

% Initialize variables (using vectors for multiple particles)
x = zeros(num_particles, num_steps);    % Position array (matrix)
v = zeros(num_particles, num_steps);    % Velocity array (matrix)
drift_v = zeros(num_particles, 1);      % Drift velocity array

% Initialize particles
x(:, 1) = 0;                        % Initial positions (all particles at x=0)
v(:, 1) = 0;                        % Initial velocities (all particles at v=0)

% Simulation loop for each particle
for p = 1:num_particles
    for t = 2:num_steps
        % Update position and velocity with a force (example: constant acceleration)
        F = C.q_0 * 1e-6;           % Example force (1 uN)
        a = F / C.m_0;              % Acceleration (F = ma)
        v(p, t) = v(p, t-1) + a * dt; % Update velocity
        x(p, t) = x(p, t-1) + v(p, t) * dt; % Update position
        
        % Check for scattering
        if rand() < prob_scatter
            % Set velocity back to 0 if scattered (elastic collision)
            v(p, t) = -0.25 * v(p, t-1); % Velocity after scattering = -0.25 * Velocity before scattering
        end
    end
    
    % Calculate drift velocity for each particle
    drift_v(p) = (x(p, end) - x(p, 1)) / (num_steps * dt);
end

% Plotting
figure;

% Plot position vs. time for each particle
subplot(2, 1, 1);
for p = 1:num_particles
    plot(1:num_steps, x(p, :), '-');
    hold on;
end
xlabel('Time');
ylabel('Position');
title('Position vs. Time for Multiple Particles');
hold off;

% Plot velocity vs. time for each particle
subplot(2, 1, 2);
for p = 1:num_particles
    plot(1:num_steps, v(p, :), '-');
    hold on;
end
xlabel('Time');
ylabel('Velocity');
title('Velocity vs. Time for Multiple Particles');
hold off;
