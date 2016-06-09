function varargout = FindingBlack(varargin)
% FINDINGBLACK M-file for FindingBlack.fig
%      FINDINGBLACK, by itself, creates a new FINDINGBLACK or raises the existing
%      singleton*.
%
%      H = FINDINGBLACK returns the handle to a new FINDINGBLACK or the handle to
%      the existing singleton*.
%
%      FINDINGBLACK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINDINGBLACK.M with the given input arguments.
%
%      FINDINGBLACK('Property','Value',...) creates a new FINDINGBLACK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FindingBlack_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FindingBlack_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help FindingBlack

% Last Modified by GUIDE v2.5 09-Jun-2016 00:20:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FindingBlack_OpeningFcn, ...
                   'gui_OutputFcn',  @FindingBlack_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before FindingBlack is made visible.
function FindingBlack_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FindingBlack (see VARARGIN)

% Choose default command line output for FindingBlack
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FindingBlack wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FindingBlack_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function PathEdit_Callback(hObject, eventdata, handles)
% hObject    handle to PathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PathEdit as text
%        str2double(get(hObject,'String')) returns contents of PathEdit as a double


% --- Executes during object creation, after setting all properties.
function PathEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PathEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BrowseButton.
function BrowseButton_Callback(hObject, eventdata, handles)
% hObject    handle to BrowseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.jpg','Select jpg-image');
Path=get(handles.PathEdit, 'String');
Path = [PathName, FileName];
set(handles.PathEdit, 'String', Path);

% --- Executes on button press in PortraitRadio.
function PortraitRadio_Callback(hObject, eventdata, handles)
% hObject    handle to PortraitRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.ECGRadio, 'Value', 0);
	set(handles.PictureRadio, 'Value', 0);
end
% Hint: get(hObject,'Value') returns toggle state of PortraitRadio


% --- Executes on button press in PictureRadio.
function PictureRadio_Callback(hObject, eventdata, handles)
% hObject    handle to PictureRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.PortraitRadio, 'Value', 0);
	set(handles.ECGRadio, 'Value', 0);
end
% Hint: get(hObject,'Value') returns toggle state of PictureRadio


% --- Executes on button press in ECGRadio.
function ECGRadio_Callback(hObject, eventdata, handles)
% hObject    handle to ECGRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.PortraitRadio, 'Value', 0);
	set(handles.PictureRadio, 'Value', 0);
end
% Hint: get(hObject,'Value') returns toggle state of ECGRadio


% --- Executes on button press in BackButton.
function BackButton_Callback(hObject, eventdata, handles)
% hObject    handle to BackButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MainMenu;
hf=findobj('Name','Finding');
close(hf);

% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global strategy;
global notpreparedtest;
global palitra;
global portraitimages;
global pictureimages;
global ECGimages;
V = zeros(1, 10000);
1
%Работа с тестовым изображением

%Получение набора из трех двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
%интенсивность красного, зеленого и синего цвета каждого пикселя соответственно
%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа

notpreparedtest=imresize(im2bw(imread(get(handles.PathEdit, 'String')), 0.5), [100 100]);


%Перевод массива в вектор-строку
V(:,:)=reshape(notpreparedtest, 1, 10000);
	
%Перевод значений массива из типа int в тип double
notpreparedtest=double(notpreparedtest);

%Создание вектора-строки testimage, который будет хранить бинарную комбинацию тестового изображения
testimage = zeros(1, 10000);


%Заполнение вектора-столбца testimage

for m=1:1:10000
	testimage(1, m)=~V(1,m);
end


testimage=double(testimage);
% Перемножаем эталонные и тестовую БК
% Результатом будет вектор-столбец, где каждое значение будет хранить
% количество пикселей тествого изображения, совпадающих с соответствующими 
% пикселями эталонных изображений
global imagekind;
if get(handles.PortraitRadio, 'Value') == 1
	res = portraitimages * testimage';
	imagekind='portrait';
else if get(handles.PictureRadio, 'Value') == 1
		res = pictureimages * testimage';
		imagekind='picture';
	else 
		res = ECGimages * testimage';
		imagekind='ECG';
	end
end

% Ищем максимаьный элемент в полученном векторе,
% т. е. наиболее схожее эталонное изображение с
% тестовым
max = 0;
imax = 0;
for i = 1 : length(res)
    if res(i) > max
        max = res(i);
        imax = i;
    end;
end

%Назначаем порог схожести
threshold=205;

global ImageToShow;

if max > threshold
	ImageToShow=imax;
    %Выводим изображение на экран, если порог превышен
    % result = zeros(100, 100, 3);
    % result(:, :, :)=notpreparedimages(imax,:,:,:);
    % result=uint8(result);
    %imshow(result);
    %result = answers{imax};
else
	ImageToShow=0;
    %Иначе выводим в консоли изображение не распознано
    %result = 'не удалось распознать';
end
2+2
FindingTest;
hf=findobj('Name','FindingBlack');
close(hf);