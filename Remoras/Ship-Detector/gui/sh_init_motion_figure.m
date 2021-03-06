function sh_init_motion_figure

global REMORA

defaultPos = [0.025,0.048,0.3,0.4];
REMORA.fig.sh.motion = figure( ...
    'NumberTitle','off', ...
    'Name','Ship Detector Motion Control - v1.0',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on');

% Detection Settings pulldown
REMORA.sh.menuMotion = uimenu(REMORA.fig.sh.motion,'Label','&Load/Save Settings',...
    'Enable','on','Visible','on');

% Spectrogram load/save params
uimenu(REMORA.sh.menuMotion,'Label','&Load Detector Settings File',...
    'Callback','sh_gui_pulldown(''settingsLoad'')');
uimenu(REMORA.sh.menuMotion,'Label','&Save Detector Settings File',...
    'Callback','sh_gui_pulldown(''settingsSave'')');


