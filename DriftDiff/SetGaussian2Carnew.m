Coupled = 1;
TwoCarriers = 1;
RC = 1;
%RC = 0;
nx = 201;
l = 1e-6;

x =linspace(0,l,nx);
dx = x(2)-x(1);
xm = x(1:nx-1) + 0.5*dx;


% when when Nd is a constant
% Nd = 1e16 * 1e6; % Const. 1/cm3 (100 cm/m)^3
% NetDoping = ones(1,nx).*Nd; % doping

%when Nd is a linear gradient
% Nd_min = 1e16 * 1e6; % Minimum doping concentration in 1/cm³
% Nd_max = 20e16 * 1e6; % Maximum doping concentration in 1/cm³
% gradient = linspace(Nd_min, -Nd_max, nx); % Linear gradient from Nd_min to Nd_max
% NetDoping = gradient; % Set the doping profile to the linear gradient

%When Nd is an exponential gradient
Nd_min = 1e16 * 1e6; % Minimum doping concentration in 1/cm³
Nd_max = 20e16 * 1e6; % Maximum doping concentration in 1/cm³
x = linspace(0, 1, nx); % Linearly spaced vector from 0 to 1
gradient = exp(x * log(Nd_max/Nd_min)) * Nd_min; % Exponential gradient from Nd_min to Nd_max
NetDoping = gradient; % Set the doping profile to the exponential gradient


x0 = l/2;
nw = l/20;
npDisturbance = 1e16*1e6*exp(-((x-x0)/nw).^2);

LVbc = 0;
RVbc = 0;

TStop = 14200000*1e-18;
PlDelt = 100000*1e-18;

% PlotYAxis = {[-1e-15 2e-15] [-2e-9 2e-9] [-1.5e-12 1.5e-12]...
%     [1e22 2e22] [0 1e22] [0 20e43]...
%     [-20e33 15e33] [-2.5e34 2e34] [-1.1e8 1.1e8] ...
%     [-1e8 1e8] [-10e-3 10e-3] [0 2e22]};

doPlotImage = 0;
PlotFile = 'Gau2CarRC.gif';
