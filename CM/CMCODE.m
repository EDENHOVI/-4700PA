clear all ;close all;
set(0,'DefaultFigureWindowStyle','docked')

Is = 0.01e-12; % Forward Bias Saturation Current
Ib = 0.1e-12; % Breakdown Saturation Current
Vb = 1.3; % Breakdown Voltage
Gp = 0.1; % Parasitic Parallel Conductance
nsteps = 200; %number of steps for voltage vector


% Task 2-------------------------------------------------------------------
V = linspace(-1.95, 0.7, nsteps); % Voltage Vector
I = zeros(size(V)); % Current Vector meant to cater to 

I = (Is .* (exp((1.2 / 0.025) .* V) - 1)) + (Gp .* V) - (Ib .* (exp((-1.2 / 0.025) .* (V + Vb)) - 1));

I_Noise = I + 0.2 .* I .* rand(1, nsteps); % Current Vector with 20% random variation to replicate noise

% figure(1);
% 
% subplot(2,2,1)
% plot(V, I)
% title('I-V Curve of a PN Diode')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on;
% 
% subplot(2,2,2);
% semilogy(V, abs(I))
% title('Logarithmic I-V Curve of a PN Diode')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on;
% 
% subplot(2,2,3);
% plot(V, I_Noise)
% title('I-V Curve of a PN Diode with Experimental Noise')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on;
% 
% subplot(2,2,4);
% semilogy(V, abs(I_Noise))
% title('Logarithmic I-V Curve of a PN Diode with Experimental Noise')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold off;

%task 3-------------------------------------------------------------------

polynomialFit_4thOrder = polyfit(V, I, 4);% 4th order Poly fit of all vectors
polynomialFit_8thOrder = polyfit(V, I, 8); % 8th th order Poly fit of all vectors
polynomialFit_4thOrderNoise = polyfit(V, I, 4); %4th order Poly fit of all noise vectors
polynomialFit_8thOrderNoise = polyfit(V, I, 8); %8th order Poly fit of all noise vectors


% figure(1);
% 
% subplot(2,2,1)
% plot(V, I)
% title('I-V Curve of a PN Diode With 4th Order Polynomial Fitting')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on
% plot(V, polyval(polynomialFit_4thOrder, V))
% hold off
% 
% subplot(2,2,2)
% semilogy(V, abs(I))
% title('Logarithmic I-V Curve of a PN Diode With 4th Order Polynomial Fitting')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on
% semilogy(V, abs(polyval(polynomialFit_4thOrder, V)))
% hold off
% 
% subplot(2,2,3)
% plot(V, I_Noise)
% title('I-V Curve of a PN Diode with Noise and With 4th Order Polynomial Fitting')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on
% plot(V, polyval(polynomialFit_4thOrderNoise, V))
% hold off
% 
% subplot(2,2,4)
% semilogy(V, abs(I_Noise))
% title('Logarithmic I-V Curve of a PN Diode with Noise and With 4th Order Polynomial Fitting')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on
% semilogy(V, abs(polyval(polynomialFit_4thOrderNoise, V)))
% hold off
% 
% subplot(2,3,1)
% plot(V, I)
% title('I-V Curve of a PN Diode 8th Order Polynomial Fitting')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on
% plot(V, polyval(polynomialFit_8thOrderNoise, V))
% hold off
% 
% subplot(2,3,2)
% semilogy(V, abs(I))
% title('Logarithmic I-V Curve of a PN Diode with 8th Order Polynomial Fitting')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on
% semilogy(V, abs(polyval(polynomialFit_8thOrderNoise, V)))
% hold off
% 
% subplot(2,3,3)
% plot(V, I_Noise)
% title('I-V Curve of a PN Diode with Noise and With 8th Order Polynomial Fitting')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on
% plot(V, polyval(polynomialFit_8thOrderNoise, V))
% hold off
% 
% subplot(2,3,4)
% semilogy(V, abs(I_Noise))
% title('Log I-V Curve of a PN Diode with Noise and With 8th Order Polynomial Fitting')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on
% semilogy(V, abs(polyval(polynomialFit_8thOrderNoise, V)))
% hold off

%task 4-------------------------------------------------------------------
% Part A (Is and Ib)
foA = fittype('A .* (exp((1.2/0.025) .* x) - 1) + (0.1 .* x) - (C .* (exp((-1.2/0.025) .* (x + 1.3)) - 1))');
ffA = fit(V', I', foA);
IfA = ffA(V);
% figure(9);
% plot(V, IfA)
% title('I-V Curve of a PN Diode with Fitted Parameters I_s and I_b')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% hold on
% 
% % Part B (Is, Gb and Ib)
% foB = fittype('A .* (exp((1.2/0.025) .* x) - 1) + (B .* x) - (C .* (exp((-1.2/0.025) .* (x + 1.3)) - 1))');
% ffB = fit(V', I', foB);
% IfB = ffB(V);
% plot(V, IfB)
% title('I-V Curve of a PN Diode with Fitted Parameters I_s, G_b and I_b')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% 
% % Part C (Is, Gb, Ib and Vb)
% foC = fittype('A .* (exp((1.2/0.025) .* x) - 1) + (B .* x) - (C .* (exp((-1.2/0.025) .* (x + D)) - 1))');
% ffC = fit(V', I', foC);
% IfC = ffC(V);
% plot(V, IfC,"--")
% title('I-V Curve of a PN Diode with Fitted Parameters I_s, G_b, I_b and V_b')
% xlabel('Voltage (V)')
% ylabel('Current (A)')
% legend('I_s and I_b', 'I_s, G_b and I_b', 'I_s, G_b, I_b and V_b')
% hold off


% Task #5: Fitting using the Neural Net model

inputs = V.';
targets = I.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net, tr] = train(net, inputs, targets);
outputs = net(inputs);
errors = gsubtract(outputs, targets);
performance = perform(net, targets, outputs);
view(net)
Inn = outputs;

figure(10)
plot(V, I)
hold on
plot(V, Inn, 'r--')
hold off
legend("Raw Data", "Neural Net Fit")