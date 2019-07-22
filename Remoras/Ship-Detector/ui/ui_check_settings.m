function ui_check_settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ui_check_settings.m
%
% Verify settings in GUI before running on entire drive.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global REMORA

defaultPos = [0.25,0.5,0.2,0.4];
REMORA.fig.ship_dt_verify = figure( ...
    'NumberTitle','off', ...
    'Name','Spice Detector Batch - v1.0',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on');

% button grid layouts
% 14 rows, 4 columns
r = 22; % rows      (extra space for separations btw sections)
c = 3;  % columns
h = 1/r;
w = 1/c;
dy = h * 0.8;
% dx = 0.008;
ybuff = h*.2;
xbuff = w*.1;
% y position (relative units)
y = 1:-h:0;

% x position (relative units)
x = 0:w:1;

% colors
bgColor = [1 1 1];  % white
bgColorGrayLight = [.92 .92 .92];  % gray
bgColorGray = [.86 .86 .86];  % gray
bgColor3 = [.75 .875 1]; % light green
bgColor4 = [.76 .87 .78]; % light blue

REMORA.ship_dt_verify = [];
labelStr = 'Verify Detector Options';
btnPos=[x(1) y(2) w*3 h];
REMORA.ship_dt_verify.headtext = uicontrol(REMORA.fig.ship_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGray,...
    'String',labelStr, ...
    'FontUnits','points', ...
    'FontWeight','bold',...
    'FontSize',10,...
    'Visible','on');


% Set paths and strings
%***********************************

% Output Folder Text
labelStr = 'Output Folder';
btnPos=[x(1)+xbuff  y(3) w dy];
REMORA.ship_dt_verify.outDirTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
        'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');%   'BackgroundColor',bgColor3,...

% Output Folder Editable Text
labelStr=num2str(REMORA.ship_dt.settings.outDir);
btnPos=[x(2)-w/4 y(3) w*2.2 dy];
REMORA.ship_dt_verify.outDirEdTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setOutDir'')');


% Transfer Function Text
labelStr = 'Transfer Function Path';
btnPos=[x(1)+xbuff  y(4) w dy];
REMORA.ship_dt_verify.TFPathTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
        'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');%   'BackgroundColor',bgColor3,...

% Transfer Function Editable Text
labelStr=num2str(REMORA.ship_dt.settings.tfFullFile);
btnPos=[x(2)-w/4 y(4) w*2.2 dy];
REMORA.ship_dt_verify.TFPathEdTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setTFPath'')');


% Detector settings
labelStr = 'Adjustable Detector Settings';
btnPos=[x(1) y(6) w*3 h];
REMORA.ship_dt_verify.headtext = uicontrol(REMORA.fig.ship_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGray,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');


% col names
labelStr='Parameter';
btnPos=[x(1) y(7) w*2 h];
REMORA.ship_dt_verify.headtext = uicontrol(REMORA.fig.ship_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGrayLight,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

labelStr='Min';
btnPos=[x(3) y(7) w/2 h];
REMORA.ship_dt_verify.headtext = uicontrol(REMORA.fig.ship_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGrayLight,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

labelStr='Max';
btnPos=[x(3)+w/2 y(7) w/2 h];
REMORA.ship_dt_verify.headtext = uicontrol(REMORA.fig.ship_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGrayLight,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

%***********************************
% Low Band Limits Text
%***********************************

%  Low Band Limit Text
labelStr = 'Low Band Limit (Hz)';
btnPos=[x(1)+xbuff*2 y(8)-ybuff w*2 h];
REMORA.ship_dt_verify.LowBandText = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');%   'BackgroundColor',bgColor3,...

% Minimum Low Band Limit Editable Text
labelStr=num2str(REMORA.ship_dt.settings.lowBand(1,1));
btnPos=[x(3) y(8) w/2 h];
REMORA.ship_dt_verify.MinLowBandEdText = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setMinLowBand'')');

% Maximum Low Band Limit Editable Text
labelStr=num2str(REMORA.ship_dt.settings.lowBand(1,2));
btnPos=[x(3)+w/2 y(8) w/2 h];
REMORA.ship_dt_verify.MaxLowBandEdText = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setMaxLowBand'')');

%***********************************
% Medium Band Limits Text
%***********************************
labelStr = 'Medium Band Limit (Hz)';
btnPos=[x(1)+xbuff*2 y(9)-ybuff w*2 h];
REMORA.ship_dt_verify.MediumBandText = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr),...
    'FontUnits','normalized', ...
    'Visible','on');%'BackgroundColor',bgColor3,...

% Minimum Medium Band Limit Editable Text
labelStr=num2str(REMORA.ship_dt.settings.mediumBand(1,1));
btnPos=[x(3) y(9) w/2 h];
REMORA.ship_dt_verify.MinMediumBandEdText = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setMinMediumBand'')');%'Enable', enbl, ...

% Maximum Medium Band Limit Editable Text
labelStr=num2str(REMORA.ship_dt.settings.mediumBand(1,2));
btnPos=[x(3)+w/2 y(9) w/2 h];
REMORA.ship_dt_verify.MaxMediumBandEdText = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setMaxMediumBand'')');%    'Enable', enbl, ...

%***********************************
% High Band Limits Text
%***********************************
labelStr = 'High Band Limit (Hz)';
btnPos=[x(1)+xbuff*2 y(10)-ybuff w*2 h];
REMORA.ship_dt_verify.MediumBandText = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr),...
    'FontUnits','normalized', ...
    'Visible','on');%'BackgroundColor',bgColor3,...

% Minimum Duration Limit Editable Text
labelStr=num2str(REMORA.ship_dt.settings.highBand(1,1));
btnPos=[x(3) y(10) w/2 h];
REMORA.ship_dt_verify.MinHighBandEdText = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setMinHighBand'')');%'Enable', enbl, ...

% Maximum Duration Limit Editable Text
labelStr=num2str(REMORA.ship_dt.settings.highBand(1,2));
btnPos=[x(3)+w/2 y(10) w/2 h];
REMORA.ship_dt_verify.MaxHighBandEdText = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setMaxHighBand'')');%    'Enable', enbl, ...

%***********************************
% Duration Threshold Close Passage Text
%***********************************
labelStr = 'Close Passage Duration Threshold (s)';
btnPos=[x(1)+xbuff*2 y(11)-ybuff w*2 h];
REMORA.ship_dt_verify.ThrCloseTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Duration Threshold Close Passage Editable Text
labelStr=num2str(REMORA.ship_dt.settings.thrClose);
btnPos=[x(3) y(11) w/2 h];
REMORA.ship_dt_verify.ThrCloseEdTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setThrClose'')');%'Enable', enbl, ...

%***********************************
% Duration Threshold Distant Passage Text
%***********************************
labelStr = 'Distant Passage Duration Threshold (s)';
btnPos=[x(1)+xbuff*2 y(12)-ybuff w*2 h];
REMORA.ship_dt_verify.ThrDistantTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Duration Threshold Distant Passage Editable Text
labelStr=num2str(REMORA.ship_dt.settings.thrDistant);
btnPos=[x(3) y(12) w/2 h];
REMORA.ship_dt_verify.ThrDistantEdTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setThrDistant'')');

%***********************************
% Received Level Threshold Text
%***********************************
labelStr = 'Received Level Threshold (%)';
btnPos=[x(1)+xbuff*2 y(13)-ybuff w*2 h];
REMORA.ship_dt_verify.ThrRLTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Duration Threshold Distant Passage Editable Text
labelStr=num2str(REMORA.ship_dt.settings.thrRL);
btnPos=[x(3) y(13) w/2 h];
REMORA.ship_dt_verify.ThrRLEdTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setThrRL'')');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Window heading
labelStr = 'Window settings:';
btnPos=[x(1)+xbuff y(14)-ybuff w*2 h];
REMORA.ship_dt_verify.WindowHeading = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontWeight','bold',...
    'FontUnits','normalized', ...
    'Visible','on');

%***********************************
% Duration Window Text
%***********************************

labelStr = 'Window size (s)';
btnPos=[x(1)+xbuff*2 y(15)-ybuff w*2 h];
REMORA.ship_dt_verify.DurWindTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');
% Duration Window Editable Text
labelStr=num2str(REMORA.ship_dt.settings.durWind);
btnPos=[x(3) y(15) w/2 h];
REMORA.ship_dt_verify.DurWindEdTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setDurWind'')');

%***********************************
% Slide Overlapping Window Text
%***********************************

labelStr = 'Sliding time overlapping windows (s)';
btnPos=[x(1)+xbuff*2 y(16)-ybuff w*2 h];
REMORA.ship_dt_verify.SlideTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');
% Slide Editable Text
labelStr = num2str(REMORA.ship_dt.settings.slide);
btnPos=[x(3) y(16) w/2 h];
REMORA.ship_dt_verify.SlideEdTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setSlide'')');

%***********************************
% Error Range Percentage Text
%***********************************
labelStr = 'Error detection time between overlapping windows (%)';
btnPos=[x(1)+xbuff*2 y(17)-ybuff w*2 h];
REMORA.ship_dt_verify.ErrorRangeTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');
% Error Range Editable Text
labelStr=num2str(REMORA.ship_dt.settings.errorRange);
btnPos=[x(3) y(17) w/2 h];
REMORA.ship_dt_verify.ErrorRangeEdTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setErrorRange'')');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Post Processing Options
labelStr = 'Post-Processing Options:';
btnPos=[x(1)+xbuff y(18)-ybuff w*2 h];
REMORA.ship_dt_verify.headtext = uicontrol(REMORA.fig.ship_dt_verify, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'HorizontalAlignment','left',...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

%***********************************
% Save .tlab file Checkbox
%***********************************
labelStr = 'Save Triton Labels File';
btnPos=[x(1)+xbuff*2 y(19) w h];
REMORA.ship_dt_verify.labelsCheckbox = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','checkbox',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',labelStr,...
    'Value',REMORA.ship_dt.settings.saveLabels,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','dt_control(''setLabelsFile'')');



% Run button
labelStr = 'Run Detector';
btnPos=[x(2) y(21) w h];
REMORA.ship_dt_verify.RunDetectorEdTxt = uicontrol(REMORA.fig.ship_dt_verify,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',[.47,.67,.19],...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'FontSize',.5,...
    'Visible','on',...
    'FontWeight','bold',...
    'Callback','dt_control(''RunBatchDetection'')');

end