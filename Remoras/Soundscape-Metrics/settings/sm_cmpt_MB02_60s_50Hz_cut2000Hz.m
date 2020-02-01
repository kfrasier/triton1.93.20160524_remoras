% Settings for Computation of Soundscape Metrics

% Input / Output Settings 

REMORA.sm.cmpt.indir = 'D:\SanctSound_Output\SanctSound_MB02_01\ltsa';
REMORA.sm.cmpt.outdir = 'D:\SanctSound_Output\SanctSound_MB02_01\metrics\MB02_01_60s_50Hz_cut2000Hz_4weeks';

REMORA.sm.cmpt.ltsaout = 0;
REMORA.sm.cmpt.csvout = 1;
REMORA.sm.cmpt.fstart = 1;

% Analysis Options 

REMORA.sm.cmpt.lfreq = 20;
REMORA.sm.cmpt.hfreq = 2000;

REMORA.sm.cmpt.bb = 0;
REMORA.sm.cmpt.ol = 1;
REMORA.sm.cmpt.tol = 1;
REMORA.sm.cmpt.psd = 1;

REMORA.sm.cmpt.avgt = 60;
REMORA.sm.cmpt.avgf = 50;
REMORA.sm.cmpt.perc = 0.5;

REMORA.sm.cmpt.mean = 1;
REMORA.sm.cmpt.median = 1;
REMORA.sm.cmpt.prctile = 0;

REMORA.sm.cmpt.fifo = 0;
REMORA.sm.cmpt.dw = 0;
REMORA.sm.cmpt.strum = 0;

% Calibration Options 

REMORA.sm.cmpt.cal = 1;
REMORA.sm.cmpt.sval = 1;
REMORA.sm.cmpt.caldb = 175.1;

REMORA.sm.cmpt.tfval = 0;
