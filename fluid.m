% FLUID
% Free Fluid Flux-Barriers Rotor for Synchronous Reluctance Motor Drawing
%
% Bacco, Giacomo 2018

clear all; close all; clc;
addpath('draw','tools');


%% DATA
rotor.p = 2; % number of pole pairs
mm = 1e-3; % millimeters
rotor.De = 200*mm; % [m], rotor outer diameter

rotor.Nb = 3; % number of flux-barriers
rotor.tb = [4 8 15]*mm; % flux-barrier thicknesses
rotor.wc = [3 7 12 10]*mm; % flux-carrier widths
rotor.Nstep = 3*[2, 4, 6]; % number of steps to draw the flux-barrier side
rotor.wrib_t = 1*mm; % [m], tangential iron rib width

% you can input flux-barrier angles or let the program compute them
% rotor.barrier_angles_el = [14,26,38]*2; % [deg], electrical flux-barrier angles

% or you can also input a factor to reach the top or the bottom of each barrier
% (do not exceed 100%)
% rotor.barrier_end_wf = [20,50,80]/100; % flux-barrier-end weight factors

% rotor.barrier_end = 'rect'; % choose 'rect' or comment

% you can define the rib width or comment
rotor.wrib = [0,1,1]*mm; % [m], radial iron rib widths
% You can define the magnet width or comment
% rotor.wm = [10,20,40]*mm;





%% barrier points computation
barrier = calc_fluid_barrier(rotor);


%% simple matlab plot
figure
hold all
axis equal
for bkk = 1:rotor.Nb
  plot(barrier(bkk).X, barrier(bkk).Y, '.-')
end
if isfield(rotor,'wm')
  RM = [barrier(:).Rm];
  thM = pi/2/rotor.p;
  Xm = RM.*cos(thM);
  Ym = RM.*sin(thM);
  plot(Xm, Ym, 'ko')
end
axis auto


%% FEMM drawing
try
  openfemm(1)
  newdocument(0);
  
  draw_fluid_barrier(barrier);
  
catch
  disp('FEMM not available.');
  
end
