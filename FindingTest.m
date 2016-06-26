function varargout = FindingTest(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FindingTest_OpeningFcn, ...
                   'gui_OutputFcn',  @FindingTest_OutputFcn, ...
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


function FindingTest_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
global notpreparedtest;
global ImageToShow;
global notpreparedportraitimages;
global notpreparedpictureimages;
global portraitanswers;
global pictureanswers;
global strategy;
global imagekind;
set(handles.ResultImage, 'visible', 'on');
switch strategy
		case 1
			notpreparedtest=uint8(notpreparedtest);
		case 2
			notpreparedtest=uint8(notpreparedtest);
		case 3
			notpreparedtest=double(notpreparedtest);
	end
%Вывод тестового изображения
axes(handles.ResultImage);
imshow(notpreparedtest);
set(handles.Description, 'String', 'Testpicture');

guidata(hObject, handles);

function varargout = FindingTest_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%Переход к модулю FindingEnd.m
function OKButton_Callback(hObject, eventdata, handles)
FindingEnd;
hf=findobj('Name','FindingTest');
close(hf);


function pushbutton2_Callback(hObject, eventdata, handles)
FindingEnd;
hf=findobj('Name','FindingTest');
close(hf);

