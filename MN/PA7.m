clear all, close all;

R1 = 1; %resistance value R1
C1 = 0.25; %Capacitance value C1
R2=2; %resistance value R2
L = 0.2; %inductance value R1
R3= 10; %resistance value R3
Alpha = 100; %alpha value
R4 = 0.1; %resistance value R4
Ro = 1000; %resistance value Ro
Vin = 1; %input voltage value 1v
Go = 1/Ro; %conductance value at branch 0
G4 = 1/R4; %conductance value at branch 4
G3 = 1/R3; %conductance value at branch 3
G2 = 1/R2; %conductance value at branch 2
G1 = 1/R1; %conductance value at branch 1

G = [1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 Alpha 0;
    0 1 -1 0 0 0 0 0;
    G1 -G1 0 0 0 0 0 -1;
    -G1 (G1+G2) 0 0 0 -1 0 0;
    0 0 G3 0 0 -1 0 0;
    0 0 Alpha*G3 G4 -G4 0 0 0;
    0 0 0 -G4 (Go+G4) 0 0 0];
     
VIN = linspace(-10,10,100);

F = [Vin;
    0;
    0;
    0;
    0;
    0;
    0;
    0];

C = [0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 -L 0 0;
    -C1 C1 0 0 0 0 0 0;
    C1 -C1 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0];

for i = 1:100
    F(1) = VIN(i);
    Vop = G\F;
    V5(i) = Vop(5);
    V3(i) = Vop(3);

end

figure
title('Vo and V3 against VIN');
hold on
plot(VIN,V5);
plot(VIN,V3);
hold off
legend('Vo', 'V3')
%------------------------------------part 2-------------------------------------
% Define angular frequency range
w = linspace(0, 10, 100); % Example angular frequency range from 0 to 10

% Calculating V5 and V5/V1 for each angular frequency
V5 = zeros(size(w));
V5_V1 = zeros(size(w));

for i = 1:length(w)
    % Calculate V5 for angular frequency w(i)
    % Assume some calculation for V5 here
    F(1) = VIN(i);
    Vop = G\F;
    V5(i) = Vop(5); % 
    
    % Calculate V5/V1 for angular frequency w(i)
    % Assume some calculation for V5/V1 here
    V5_V1(i) = V5(i) / F(1); % Example calculation, replace with actual calculation
end

% Plot V5 as a function of angular frequency
figure
plot(w, V5)
xlabel('Angular Frequency (\omega)')
ylabel('V5')
title('V5 as a function of Angular Frequency')
legend('Vo')
% Plot gain V5/V1 in dB as a function of angular frequency
figure
plot(w, 10*log10(abs(V5_V1)))
xlabel('Angular Frequency (\omega)')
ylabel('Gain (V5/V1) (dB)')
title('Gain (V5/V1) in dB as a function of Angular Frequency')
legend('Vo/VIN')
%---------------------------------------part 3--------------------------------------------------

% Define parameters
std_dev = 0.05; % Standard deviation for normal distribution
omega = pi; % Angular frequency

% Generate random perturbations on C using a normal distribution
num_samples = 10000; % Number of samples
perturbations = std_dev * randn(num_samples, 1);

% Calculate gain for each perturbation
gains = zeros(num_samples, 1);
for i = 1:num_samples
    % Perturb C
    Cp = C1 + perturbations(i);
    
    % Recalculate G matrix
    Cp_matrix = [0 0 0 0 0 0 0 0;
                 0 0 0 0 0 0 0 0;
                 0 0 0 0 0 -L 0 0;
                 -Cp Cp 0 0 0 0 0 0;
                 Cp -Cp 0 0 0 0 0 0;
                 0 0 0 0 0 0 0 0;
                 0 0 0 0 0 0 0 0;
                 0 0 0 0 0 0 0 0];
    
    Gp = [1 0 0 0 0 0 0 0;
          0 0 0 0 0 0 Alpha 0;
          0 1 -1 0 0 0 0 0;
          G1 -G1 0 0 0 0 0 -1;
          -G1 (G1+G2) 0 0 0 -1 0 0;
          0 0 G3 0 0 -1 0 0;
          0 0 Alpha*G3 G4 -G4 0 0 0;
          0 0 0 -G4 (Go+G4) 0 0 0];
    
    % Calculating Vop for perturbed C
    Vop_perturbed = Gp\F;
    
    % Calculating gain for perturbed C
    gains(i) = Vop_perturbed(5) / Vin;
end

% Plot gain as a function of perturbed C
figure
scatter(perturbations, gains)
xlabel('Perturbations on C')
ylabel('Gain')
title('Gain as a function of Perturbations on C')

% Creating histogram of the gain
figure
histogram(gains, 100)
xlabel('Gain')
ylabel('Frequency')
title('Histogram of Gain')
