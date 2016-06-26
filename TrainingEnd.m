function varargout = TrainingEnd(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrainingEnd_OpeningFcn, ...
                   'gui_OutputFcn',  @TrainingEnd_OutputFcn, ...
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

%Вывод окна с подтверждением сохранения изображения
function TrainingEnd_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);



function varargout = TrainingEnd_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


%Возврат к главному меню
function pushbutton1_Callback(hObject, eventdata, handles)
MainMenu;
hf=findobj('Name','TrainingEnd');
close(hf);

