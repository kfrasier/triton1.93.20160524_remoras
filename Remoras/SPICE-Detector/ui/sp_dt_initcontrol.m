function sp_dt_initcontrol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sp_dt_initcontrol.m
%
% initialize Detector Control Window GUI:
%   push buttons, radio buttons, editable text boxes, info text display
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global REMORA PARAMS HANDLES

% button grid layouts
% 14 rows, 4 columns
r = 16; % rows      (extra space for separations btw sections)
c = 2;  % columns
h = 1/r;
w1 = .6;
w2 = .4;
dy = h * 0.25;
dx = 0.008;

% y position (relative units)
y = [0.9375];
y = horzcat(y, [.8594:-0.0625:0]);

% x position (relative units)
x = [0, .6];

% colors
bgColor = [1 1 1];  % white
bgColor2 = [.75 1 .875]; % light green for LTSA
bgColor3 = [.75 .875 1]; % light blue for XWAV

REMORA.spice_dt = [];
% is an xwav file open? (There are some callbacks that depend on this!)
if isfield(PARAMS, 'xhd')
    enbl = 'on';
    f_enbl = get(HANDLES.motion.fwd, 'Enable');
    b_enbl = get(HANDLES.motion.back, 'Enable');
else
    enbl = 'off';
    f_enbl = 'off';
    b_enbl = 'off';
end

% load default settings
if isfield(PARAMS,'ftype') && PARAMS.ftype == 1 % if current file is wav
    settings_detector_wav_default
    REMORA.spice_dt.detParams = detParams;
else
    settings_detector_xwav_default
    REMORA.spice_dt.detParams = detParams;
end

% fill in some info from loaded file
% detParams.channel = PARAMS.ch;
% detParams.tfFullFile = PARAMS.tf.filename;
if isempty(REMORA.spice_dt.detParams.tfFullFile)
    REMORA.spice_dt.detParams.tfFullFile = PARAMS.tf.filename;
end

% detParams.countThresholdTemp = prctile(DATA(:,detParams.channel),99.9);

% detParams.xfrOffsetTemp = min(PARAMS.tf.uppc); % need to truncate this to fit feqs of interest
% detParams.dBppThreshold = round(20*log10(detParams.countThresholdTemp*2)+detParams.xfrOffsetTemp);

REMORA.spice_dt.detParams.rebuildFilter = 1; % set to true first time through.

% if PARAMS.filter % could use this to apply the triton bp filter to
% detector, but seems confusing in the end
%     detParams.bpRanges = [PARAMS.ff1,PARAMS.ff2];
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% handles for each of the spectrogram control objects
if ~isfield(REMORA.spice_dt, 'fig') 
    REMORA.spice_dt.fig = struct;
end

if ~isfield(REMORA.fig,'spice_dt')||~isvalid(REMORA.fig.spice_dt)
    sp_dt_initwins
end 

% Detection Parameters pulldown
REMORA.spice_dt.fig.filemenu = uimenu(REMORA.fig.spice_dt,'Label','Save/Load Params',...
    'Enable','on','Visible','on');

% Spectrogram load/save params
uimenu(REMORA.spice_dt.fig.filemenu,'Label','&Load detector settings',...
    'Callback',{@sp_dt_paramspd,'spice_settingsLoad','interactiveMode'});
uimenu(REMORA.spice_dt.fig.filemenu,'Label','&Save detector settings',...
    'Callback',{@sp_dt_paramspd,'spice_settingsSave','interactiveMode'});




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Spectrogram Controls
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ToDo:
% checkboxes for low and hi-res
%***********************************
% Spectrogram heading
%***********************************
labelStr='SPICE Detector Options';
btnPos=[x(1) y(1) 1 h];
REMORA.spice_dt.headtext = uicontrol(REMORA.fig.spice_dt, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','points', ...
    'FontWeight','bold',...
    'FontSize',11,...
    'Visible','on');
% col names
labelStr='Parameter';
btnPos=[x(1) y(3) .6 h];
REMORA.spice_dt.headtext = uicontrol(REMORA.fig.spice_dt, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

labelStr='Min';
btnPos=[x(2) y(3) w2/2 h];
REMORA.spice_dt.headtext = uicontrol(REMORA.fig.spice_dt, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

labelStr='Max';
btnPos=[x(2)+(w2/2) y(3) w2/2 h];
REMORA.spice_dt.headtext = uicontrol(REMORA.fig.spice_dt, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');
%***********************************
%  Peak2Peak Threshold Text
%***********************************
REMORA.fig.spice_dt_bg1 = uibuttongroup('Position',[x(1) y(5) w1 h*2],...
    'BorderType','none');

if ~isfield(REMORA.spice_dt.detParams,'snrDet')
    REMORA.spice_dt.detParams.snrDet = 0;
end

labelStr = 'P-P RL Threshold (dBpp)';
btnPos=[.05 .5 1 .5];
REMORA.spice_dt.PPThresholdRadio = uicontrol(REMORA.fig.spice_dt_bg1,...
    'Style','radiobutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Value',~REMORA.spice_dt.detParams.snrDet,...
    'Visible','on',...
    'Callback','sp_dt_control(''setUsePPThresh'',''gui'')');

%***********************************
% Peak2Peak Threshold Editable Text
%***********************************
if ~REMORA.spice_dt.detParams.snrDet
    ppThresVis = 'on';
else
    ppThresVis = 'off';
end

labelStr=num2str(REMORA.spice_dt.detParams.dBppThreshold);
btnPos=[x(2) y(4) w2/2 h];
REMORA.spice_dt.PPThresholdEdTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible',ppThresVis,...
    'Callback','sp_dt_control(''setPPThreshold'',''gui'')');


labelStr = 'SNR RL Threshold (dB)';
btnPos=[.05 0 1 .5];
REMORA.spice_dt.SNRThresholdRadio = uicontrol(REMORA.fig.spice_dt_bg1,...
    'Style','radiobutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'Value',REMORA.spice_dt.detParams.snrDet,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''setUseSNRThresh'',''gui'')');

if REMORA.spice_dt.detParams.snrDet
    snrThresVis = 'on';
else
    snrThresVis = 'off';
end

if ~isfield(REMORA.spice_dt.detParams,'snrThresh')
    REMORA.spice_dt.detParams.snrThresh = 10;
end
labelStr = num2str(REMORA.spice_dt.detParams.snrThresh);
btnPos=[x(2) y(5) w2/2 h];
REMORA.spice_dt.SNRThresholdEdTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible',snrThresVis,...
    'Callback','sp_dt_control(''setSNRThreshold'',''gui'')');

%***********************************
% Bandpass Limits Text
%***********************************
labelStr = 'Bandpass Filter Edges (Hz)';
btnPos=[x(1)+.03 y(6) w1 h];
REMORA.spice_dt.BandPassText = uicontrol(REMORA.fig.spice_dt,...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'HorizontalAlignment','left',...
    'String',sprintf(labelStr),...
    'FontUnits','normalized', ...
    'Visible','on');%'BackgroundColor',bgColor3,...
%***********************************
% Minimum Bandpass Limit Editable Text
%***********************************
labelStr=num2str(REMORA.spice_dt.detParams.bpRanges(1,1));
btnPos=[x(2) y(6) w2/2 h];
REMORA.spice_dt.MinBandPassEdText = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''SetMinBandpass'',''gui'')');%'Enable', enbl, ...
%***********************************
% Maximum Bandpass Limit Editable Text
%***********************************
labelStr=num2str(REMORA.spice_dt.detParams.bpRanges(1,2));
btnPos=[x(2)+(w2/2) y(6) w2/2 h];
REMORA.spice_dt.MaxBandPassEdText = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''SetMaxBandpass'',''gui'')');%    'Enable', enbl, ...
%***********************************
% Click Duration Limits Text
%***********************************
labelStr = ['Click Duration Limits (',char(hex2dec('00B5')),'s)'];
btnPos=[x(1)+.03 y(7) w1 h];
REMORA.spice_dt.ClickDurLimText = uicontrol(REMORA.fig.spice_dt,...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',sprintf(labelStr),...
    'HorizontalAlignment','left',...
    'FontUnits','normalized', ...
    'Visible','on');%'BackgroundColor',bgColor3,...
%***********************************
% Minimum Duration Limit Editable Text
%***********************************
labelStr=num2str(REMORA.spice_dt.detParams.delphClickDurLims(1,1));
btnPos=[x(2) y(7) w2/2 h];
REMORA.spice_dt.MinClickDurEdText = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''SetMinClickDur'',''gui'')');%'Enable', enbl, ...
%***********************************
% Maximum Duration Limit Editable Text
%***********************************
labelStr=num2str(REMORA.spice_dt.detParams.delphClickDurLims(1,2));
btnPos=[x(2)+(w2/2) y(7) w2/2 h];
REMORA.spice_dt.MaxClickDurEdText = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''SetMaxClickDur'',''gui'')');%    'Enable', enbl, ...
%***********************************
% Peak Frequency Limit Text
%***********************************
labelStr = 'Peak Freq Limits (kHz)';
btnPos=[x(1)+.03 y(8) w1 h];
REMORA.spice_dt.PeakFreqTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',labelStr,...
    'HorizontalAlignment','left',...
    'FontUnits','normalized', ...
    'Visible','on');
%***********************************
% Minimum Peak Frequency Limit Editable Text
%***********************************
labelStr=num2str(REMORA.spice_dt.detParams.cutPeakBelowKHz);
btnPos=[x(2) y(8) w2/2 h];
REMORA.spice_dt.MinPeakFreqEdTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''SetMinPeakFreq'',''gui'')');%'Enable', enbl, ...

%***********************************
% Maximum Peak Frequency Limit Editable Text
%***********************************
labelStr=num2str(REMORA.spice_dt.detParams.cutPeakAboveKHz);
btnPos=[x(2)+(w2/2) y(8) w2/2 h];
REMORA.spice_dt.MaxPeakFreqEdTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''SetMaxPeakFreq'',''gui'')'); %'Enable', enbl, ...
%***********************************
% Envelope Energy Ratio Text
%***********************************
labelStr = 'Click Energy Envelope Ratio';
btnPos=[x(1)+.03 y(9) w1 h];
REMORA.spice_dt.dEvLimsTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');
%***********************************
% Minimum Envelope Limit Editable Text
%***********************************
labelStr=num2str(REMORA.spice_dt.detParams.dEvLims(1));
btnPos=[x(2) y(9) w2/2 h];
REMORA.spice_dt.MinEvEdTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''SetMinEnvRatio'',''gui'')');
%***********************************
% Maximum Envelope Limit Editable Text
%***********************************
labelStr=num2str(REMORA.spice_dt.detParams.dEvLims(2));
REMORA.spice_dt.detParams.dBppThresholdFlag = 1; % set flag to true so that 
% counts threshold is computed on first pass.
btnPos=[x(2)+(w2/2) y(9) w2/2 h];
REMORA.spice_dt.MaxEvEdTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''SetMaxEnvRatio'',''gui'')');
%***********************************
% Clipping Threshold Text
%***********************************
labelStr = 'Clip Threshold ([0 - 1])';
btnPos=[x(1)+.03 y(10) w1 h];
REMORA.spice_dt.clipThresholdTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','text',...
    'Units','normalized',...
    'Position',btnPos,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');
%***********************************
% Clipping Threshold Editable Text
%***********************************
labelStr=num2str(REMORA.spice_dt.detParams.clipThreshold);
btnPos=[x(2)+(w2/2) y(10) w2/2 h];
REMORA.spice_dt.clipThresholdEdTxt = uicontrol(REMORA.fig.spice_dt,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sp_dt_control(''SetClipThreshold'',''gui'')');

%***********************************
% Whitening Checkbox 
%***********************************
labelStr = 'Whiten';
if ~isfield(REMORA.spice_dt.detParams,'whiten')
    REMORA.spice_dt.detParams.whiten = 0;
end
btnPos=[x(2)+(w2/2) y(11) w2/2 h];
REMORA.spice_dt.whitenCheck = uicontrol(REMORA.fig.spice_dt,...
    'Style','checkbox',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Value',REMORA.spice_dt.detParams.whiten,...
    'Visible','on',...
    'Callback','sp_dt_control(''SetWhiten'',''gui'')');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Noise Subtraction Options
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%***********************************
% Mean Subtraction Text
%***********************************
% btnPos=[x(1) y(2) w h];
% labelStr = 'Mean Subtraction Duration (s)';
% REMORA.dt.MeanSubDurTxt = uicontrol(REMORA.fig.dt,...
%    'Style','text',...
%    'Units','normalized',...
%    'Position',btnPos,...
%    'BackgroundColor',bgColor3,...
%    'String',labelStr,...
%    'FontUnits','normalized', ...
%    'Visible','on');
%***********************************
% Mean Subtraction Editable Text
%***********************************
% btnPos = [x(1) y(3) w h];
% labelStr=num2str(REMORA.dt.params.MeanAve_s);
% REMORA.dt.MeanSubDurEdtxt = uicontrol(REMORA.fig.dt,...
%     'Style','edit',...
%     'Units','normalized',...
%     'Position',btnPos,...
%     'BackgroundColor',bgColor,...
%     'String',labelStr,...
%     'FontUnits','normalized', ...
%     'Visible','on',...
%     'Callback','dtcontrol(''MeanSubtractionDuration'')');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Figure Window Motion
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w_third = .3;
%*********************************
% The BACK button setup
%*********************************
labelStr='<';
btnPos=[x(1) y(15) w_third 2*h];
REMORA.spice_dt.back = uicontrol(REMORA.fig.spice_dt, ...
    'Style','pushbutton', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'Enable', b_enbl, ...
    'Callback','sp_dt_motion(''back'')');
%*********************************
% The REFRESH button setup
%*********************************
labelStr='Refresh';
btnPos=[x(1)+w_third y(15) w_third 2*h];
REMORA.spice_dt.refresh = uicontrol(REMORA.fig.spice_dt, ...
    'Style','pushbutton', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'Callback','sp_dt_motion(''refresh'')');
%*********************************
% The FORWARD button setup
%*********************************
labelStr='>';
btnPos=[2*w_third y(15) w_third 2*h];
REMORA.spice_dt.fwd = uicontrol(REMORA.fig.spice_dt, ...
    'Style','pushbutton', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColor3,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'Enable', f_enbl, ...
    'Callback','sp_dt_motion(''forward'')');


% REMORA.spice_dt.SettingsControls = [REMORA.spice_dt.PPThresholdTxt,...
%     REMORA.spice_dt.PPThresholdEdTxt,...
%     REMORA.spice_dt.ClickDurLimText,...
%     REMORA.spice_dt.MinClickDurEdText, REMORA.spice_dt.MaxClickDurEdText,...
%     REMORA.spice_dt.PeakFreqTxt, ...
%     REMORA.spice_dt.MinPeakFreqEdTxt, REMORA.spice_dt.MaxPeakFreqEdTxt, ...
%     REMORA.spice_dt.dEvLimsTxt,...
%     REMORA.spice_dt.MinEvEdTxt,REMORA.spice_dt.MaxEvEdTxt,...
%     REMORA.spice_dt.clipThresholdTxt,REMORA.spice_dt.clipThresholdEdTxt];

set(REMORA.fig.spice_dt,'Visible','on');


