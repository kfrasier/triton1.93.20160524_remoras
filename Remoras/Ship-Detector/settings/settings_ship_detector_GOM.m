% settings_ship_detector_GOM

% Settings script for ship_detector

% Optional output directory location. Metadata directory will be created in 
% outDir if specified, otherwise it will be created in baseDir.
settings.outDir  = 'E:\evaluate_ship_detector\metadata';

% Set transfer function location (calibration/sensitivity gain)
settings.tfFullFile = 'C:\Users\Alba\Documents\MATLAB\transfer_functions\600_series\638_110701\638_110701_invSensit.tf';
% Note, if no transfer function but singular gain use:
% settings.tfFullFile = 173.1; % m-gain in dB
 
settings.REWavExt = '(\.x)?\.wav'; % Expression to match .wav or .x.wav

%%%% DETECTOR PARAMETERS %%%%

settings.lowBand = [1000,5000]; % [min,max] Lower band frequency ranges in Hz
settings.mediumBand = [5000,10000]; % [min,max] Medium band frequency ranges in Hz
settings.highBand = [10000,50000]; % [min,max] Higher band frequency ranges in Hz

settings.thrClose = 150; % minimum duration in seconds allowed above the time-dependent  
% threshold for averaged power spectral densities at the three frequency bands
settings.thrDistant = 250; % minimum duration in seconds above the time-dependent  
% threshold for averaged power spectral densities at the low and medium frequency bands

settings.durWind = 7200; % minimum duration in seconds of the exploratory window
settings.slide = 1800; % seconds allowed to slide overlapping windows before and after
% start of the central exploratory window
settings.errorRange = 0.25; % n-percent start and end time difference between 
% overlapping windows