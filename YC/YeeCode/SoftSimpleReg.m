winstyle = 'docked';
% winstyle = 'normal';

set(0,'DefaultFigureWindowStyle',winstyle)
set(0,'defaultaxesfontsize',18)
set(0,'defaultaxesfontname','Times New Roman')
% set(0,'defaultfigurecolor',[1 1 1])

% clear VARIABLES;
clear
global spatialFactor;
global c_eps_0 c_mu_0 c_c c_eta_0
global simulationStopTimes;
global AsymForcing
global dels
global SurfHxLeft SurfHyLeft SurfEzLeft SurfHxRight SurfHyRight SurfEzRight



dels = 0.75;
spatialFactor = 1;

c_c = 299792458;                  % speed of light
c_eps_0 = 8.8542149e-12;          % vacuum permittivity
c_mu_0 = 1.2566370614e-6;         % vacuum permeability
c_eta_0 = sqrt(c_mu_0/c_eps_0);


tSim = 200e-15
f = 230e12;
lambda = c_c/f;

xMax{1} = 20e-6;
nx{1} = 200;
ny{1} = 0.75*nx{1};


Reg.n = 1;

mu{1} = ones(nx{1},ny{1})*c_mu_0;


% inclusions --------------------------------------------------------------
epi{1} = ones(nx{1},ny{1})*c_eps_0;   % without inclusions then nothing is regenerated since there is no high refractive region (diffraction grating)
%epi{1}(125:2:150,150:200)= c_eps_0*11.3;

epi{1}(125:2:150,1:37)= c_eps_0*10; %for my grating slits
epi{1}(125:2:150,38:74)= c_eps_0*10; %for my gratiung slits
epi{1}(125:2:150,75:111)= c_eps_0*10; %for my grating slits
epi{1}(125:2:150,112:148)= c_eps_0*10; %for my grating slits



epi{1}(50:2:75,1:37)= c_eps_0*15; %for my grating slits   special structure
epi{1}(50:2:75,38:74)= c_eps_0*15; %for my gratiung slits
epi{1}(50:2:75,75:111)= c_eps_0*15; %for my grating slits
epi{1}(50:2:75,112:148)= c_eps_0*15; %for my grating slits

% inclusions --------------------------------------------------------------

sigma{1} = zeros(nx{1},ny{1});
sigmaH{1} = zeros(nx{1},ny{1});

dx = xMax{1}/nx{1};
dt = 0.25*dx/c_c;
nSteps = round(tSim/dt*2);
yMax = ny{1}*dx;
nsteps_lamda = lambda/dx

movie = 1;
Plot.off = 0;
Plot.pl = 0;
Plot.ori = '13';
Plot.N = 100;
Plot.MaxEz = 2;
Plot.MaxH = Plot.MaxEz/c_eta_0;
Plot.pv = [0 0 90];
Plot.reglim = [0 xMax{1} 0 yMax];


bc{1}.NumS = 2;
bc{1}.s(1).xpos = nx{1}/(4) + 1; % the values added to "bc{1}.s(1).xpos = nx{1}/(4)" determine if i see diffraction or not
bc{1}.s(1).type = 'ss';
bc{1}.s(1).fct = @PlaneWaveBC;

%second source-----------------------------------------------------------------------------

bc{1}.s(2).xpos = nx{1}/(4) + 1; % the values added to "bc{1}.s(1).xpos = nx{1}/(4)" determine if i see diffraction or not
bc{1}.s(2).type = 'ss';
bc{1}.s(2).fct = @PlaneWaveBC;

% mag = -1/c_eta_0;
mag = 1;
phi = 0;
omega = f*2*pi;
betap = 0;
t0 = 30e-15;
st = -0.05;  %15e-15
s = 0;
%y0 = yMax/2;
y01 = yMax/4
y02 = 3*yMax/4


sty = 1.5*lambda;

bc{1}.s(1).paras = {mag,phi,omega,betap,t0,st,s,y01,sty,'s'};
bc{1}.s(2).paras = {mag,phi,omega,betap,t0,st,s,y02,sty,'s'};

%Plot.y0 = round(y0/dx);
plot.y01 = round(y01/dx);
plot.y02 = round(y02/dx);

bc{1}.xm.type = 'a';
bc{1}.xp.type = 'a';
bc{1}.ym.type = 'a';
bc{1}.yp.type = 'a';

pml.width = 10 * spatialFactor;
pml.m = 3.5;

Reg.n  = 1;
Reg.xoff{1} = 0;
Reg.yoff{1} = 0;

RunYeeReg






