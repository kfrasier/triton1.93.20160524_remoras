function sh_init_passage_figure

global REMORA

defaultPos = [0.025,0.5,0.3,0.47];
REMORA.fig.sh.passage = figure( ...
    'NumberTitle','off', ...
    'Name','Passage Detector - v1.0',...
    'Units','normalized',...
    'MenuBar','none',...
    'Position',defaultPos, ...
    'Visible', 'on');

REMORA.fig.sh.passageSubplot = [];

ha(1) = axes('Units','normalized', ...
    'Position',[.1 .68 .85 .23], ...
    'XTickLabel','');
ha(2) = axes('Units','normalized', ...
    'Position',[.1 .38 .85 .23], ...
    'XTickLabel','');
ha(3) = axes('Units','normalized', ...
    'Position',[.1 .08 .85 .23]);

REMORA.fig.sh.passageSubplot = ha; 

