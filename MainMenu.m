function varargout = MainMenu(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainMenu_OpeningFcn, ...
                   'gui_OutputFcn',  @MainMenu_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


function MainMenu_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = MainMenu_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function trainmethod_Callback(hObject, eventdata, handles)
global strategy;
switch strategy
	case 1
		Training;
	case 2
		Training;
	case 3
		TrainingBlack;
end
hf=findobj('Name','MainMenu');
close(hf);


function findmethod_Callback(hObject, eventdata, handles)
global strategy;
switch strategy
	case 1
		Finding;
	case 2
		Finding;
	case 3
		FindingBlack;
end
hf=findobj('Name','MainMenu');
close(hf);


