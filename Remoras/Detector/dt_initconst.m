function dt_initconst
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% dt_initconst.m
%
% initializes some detection parameters that are no longer supported but
% needed to load in parameter files.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global REMORA
btnPos=[0    0.9375    1.0000    0.0625];
bgColor = [1 1 1];  % white
bgColor2 = [.75 1 .875]; % light green for LTSA
bgColor3 = [.75 .875 1]; % light blue for XWAV
defaultPos=[0.005,0.035,0.3,0.25];

% dummy invisible figure with all the missing controls (needed for saving
% default params and sending to batch processing)
% window placement & size on screen
REMORA.fig.dum =figure( ...
    'NumberTitle','off', ...
    'Name','Test post',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% Call Type Options
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%***********************************
% Enable/disable Tonal Detections
%***********************************
labelStr = char('Tonal', 'Detections');
REMORA.dt.tonals = uicontrol(REMORA.fig.dum, ...
    'Style','radiobutton', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'Visible','off',...
    'Value', 1,...
    'Callback','dtcontrol(''dt_tonals'')'); 
%***********************************
% Enable/disable broadband detections
%***********************************
labelStr = char('Broadband', 'Detections');
REMORA.dt.broadbands = uicontrol(REMORA.fig.dum, ...
    'Style','radiobutton', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'Visible','off',...
    'Value', 1,...
    'Callback','dtcontrol(''dt_broadbands'')'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Detector Thresholds
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%***********************************
% Tonal Threshold Text
%***********************************
labelStr = 'Threshold (dB)';
REMORA.dt.TonalThresholdTxt = uicontrol(REMORA.fig.dum,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'BackgroundColor',bgColor3,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','off');
%***********************************
% Tonal Threshold Editable Text
%***********************************
labelStr=num2str(REMORA.dt.params.Thresholds(1));
REMORA.dt.TonalThresholdEdtxt = uicontrol(REMORA.fig.dum,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','off',...
    'Callback','dtcontrol(''TonalThreshold'')');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Detector Frequency Ranges
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%***********************************
% Minimum Tonal Frequency Text
%***********************************
labelStr = 'Min Freq (Hz)';
REMORA.dt.MinTonalFreqTxt = uicontrol(REMORA.fig.dum,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'BackgroundColor',bgColor3,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','off');
%***********************************
% Minimum Tonal Frequency Editable Text
%***********************************
labelStr=num2str(REMORA.dt.params.Ranges(1,1));
REMORA.dt.MinTonalFreqEdtxt = uicontrol(REMORA.fig.dum,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','off',...
    'Callback','dtcontrol(''MinTonalFreq'')');
%***********************************
% Maximum Tonal Frequency Text
%***********************************
labelStr = 'Max Freq (Hz)';
REMORA.dt.MaxTonalFreqTxt = uicontrol(REMORA.fig.dum,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'BackgroundColor',bgColor3,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','off');
%***********************************
% Maximum Tonal Frequency Editable Text
%***********************************
labelStr=num2str(REMORA.dt.params.Ranges(1,2));
REMORA.dt.MaxTonalFreqEdtxt = uicontrol(REMORA.fig.dum,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','off',...
    'Callback','dtcontrol(''MaxTonalFreq'')');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Tonal Duration Info
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%***********************************
% Minimum Duration Text
%***********************************
labelStr = 'Min Duration (s)';
REMORA.dt.MinDurTxt = uicontrol(REMORA.fig.dum,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'BackgroundColor',bgColor3,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','off');
%***********************************
% Minimum Duration Editable Text
%***********************************
labelStr=num2str(REMORA.dt.params.WhistleMinLength_s);
REMORA.dt.MinDurEdtxt = uicontrol(REMORA.fig.dum,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','off',...
    'Callback','dtcontrol(''MinTonalDuration'')');
%***********************************
% Minimum Tonal Separation Text
%***********************************
labelStr = 'Min Separation (s)';
REMORA.dt.MinSepTxt = uicontrol(REMORA.fig.dum,...
   'Style','text',...
   'Units','normalized',...
   'Position',btnPos,...
   'BackgroundColor',bgColor3,...
   'String',labelStr,...
   'FontUnits','normalized', ...
   'Visible','off');
%***********************************
% Minimum Tonal Separation Editable Text
%***********************************
labelStr=num2str(REMORA.dt.params.WhistleMinSep_s);
REMORA.dt.MinSepEdtxt = uicontrol(REMORA.fig.dum,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','off',...
    'Callback','dtcontrol(''MinTonalSeparation'')');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Noise Subtraction Options
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%***********************************
% Enable/disable Manual Noise Pick
%***********************************
labelStr = 'Pick Noise';
REMORA.dt.NoiseEst = uicontrol(REMORA.fig.dum, ...
    'Style','radiobutton', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Enable', 'on',...                   %%%%%%%%%Turn this on when created
    'Value', 0,...
    'Callback','dtcontrol(''detection_noise'')'); 

REMORA.dt.TonalControls = [REMORA.dt.MinTonalFreqTxt, ...
    REMORA.dt.MinTonalFreqEdtxt, REMORA.dt.MaxTonalFreqTxt, ...
    REMORA.dt.MaxTonalFreqEdtxt, REMORA.dt.MinDurTxt, ...
    REMORA.dt.MinDurEdtxt, REMORA.dt.MinSepTxt, REMORA.dt.MinSepEdtxt, ...
    REMORA.dt.TonalThresholdTxt, REMORA.dt.TonalThresholdEdtxt];

REMORA.dt.MeanNoiseControls = [REMORA.dt.MeanSubDurTxt, ...
    REMORA.dt.MeanSubDurEdtxt];

REMORA.dt.NoiseControls = [REMORA.dt.NoiseEst, ...
    REMORA.dt.MeanNoiseControls];

REMORA.dt.AllControls = [REMORA.dt.headtext, REMORA.dt.NoiseControls, ...
    REMORA.dt.tonals, REMORA.dt.TonalControls, REMORA.dt.broadbands, ...
    REMORA.dt.BBControls];



