function ui_select_detector_settings

global PARAMS

hFigure = figure('Position',[560,528,200,200]);
clf
set(hFigure, 'MenuBar', 'none');
set(hFigure, 'ToolBar', 'none');

t1 = uicontrol('Style','text',...
    'String','Select detector settings source:',...
    'Position',[10 150 180 30],...
    'HandleVisibility','on',...
    'FontSize',10);

bg = uibuttongroup('Visible','on',...
    'Position',[0 0 1 1],...
    'SelectionChangedFcn',@bselection);

b1 = uicontrol(bg,'Style','pushbutton',...
    'String','Load from file',...
    'Position',[10 105 180 30],...
    'HandleVisibility','off',...
    'Callback',{@load_params_from_mfile,hFigure});


b2 = uicontrol(bg,'Style','pushbutton',...
    'String','Use current (interactive) settings',...
    'Position',[10 15 180 30],...
    'HandleVisibility','off');
% need to add callback here

bg.Visible = 'on';
end

function load_params_from_mfile(hObject,eventdata,hFigure)
 
dialogTitle = 'Choose detector settings file';

thisPath = mfilename('fullpath');

detParamsFile = uigetfile(fullfile(fileparts(fileparts(thisPath)),...
    'settings\*.m'),dialogTitle);
detParams = [];
run(detParamsFile)
global REMORA
REMORA.spice_dt.detParams = detParams;
close(hFigure)
end