function varargout = Training(varargin)
% TRAINING M-file for Training.fig
%      TRAINING, by itself, creates a new TRAINING or raises the existing
%      singleton*.
%
%      H = TRAINING returns the handle to a new TRAINING or the handle to
%      the existing singleton*.
%
%      TRAINING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAINING.M with the given input arguments.
%
%      TRAINING('Property','Value',...) creates a new TRAINING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Training_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Training_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help Training

% Last Modified by GUIDE v2.5 22-May-2016 13:32:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Training_OpeningFcn, ...
                   'gui_OutputFcn',  @Training_OutputFcn, ...
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


% --- Executes just before Training is made visible.
function Training_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Training (see VARARGIN)
set(handles.PortraitRadio, 'Value', 1);
% Choose default command line output for Training
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Training wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Training_OutputFcn(hObject, eventdata, handles) 
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


% функция добавления изображения в нужную базу
function addimage(images, notpreparedimages, answers, imagepath, descriptionpath, handles)
global palitra;
global strategy;
switch strategy
	case 1
		V = zeros(1, 10000, 3);
		BufBinary = zeros(1, 10000*palitra*3);
	case 2
		V = zeros(1, 10000);
		BufBinary = zeros(1, 10000*palitra);
	case 3
		V = zeros(1, 10000);
		BufBinary = zeros(1, 10000);
end
switch strategy
	case 1
		MToDisplay=imresize(imread(get(handles.PathEdit, 'String')), [100 100]);
	case 2
		MToDisplay=rgb2gray(imresize(imread(get(handles.PathEdit, 'String')), [100 100]));
	case 3
		MToDisplay=im2bw(imresize(imread(get(handles.PathEdit, 'String')), [100 100]), 0.5);
end
%Перевод массива в вектор-строку
switch strategy
	case 1
		for x = 1 : 3
			V(:,:,x)=reshape(MToDisplay(:, :, x), 1, 10000);
		end
	case 2
		V(:,:)=reshape(MToDisplay, 1, 10000);
	case 3
		V(:,:)=reshape(MToDisplay, 1, 10000);
		%V = logical(V);
end
%Перевод вектора-строки в бинарную вектор-строку
switch strategy
	case 1
		for j = 1:3
			for k=1:10000
				BufBinary(1, palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1) = true;
			end
		end
	case 2
		for m=1:1:10000
			BufBinary(1, (m-1)*palitra + fix(V(1, m)/(256/palitra)) + 1)=true;
		end
	case 3
		%BufBinary=logical(BufBinary);
		for m=1:1:10000
			BufBinary(1, m)=~V(1,m);
			%BufBinary(1, (m-1)*palitra + fix(V(1, m)/(256/palitra)) + 1)=true;
		end
end
images(size(images, 1)+1, :) = BufBinary(1, :);
%Сохранение изображения массива для вывода (если тестовое изображение будет распознано) 
switch strategy
	case 1
		BufRawImage=zeros(100, 100, 3);
		for j = 1:3
			for k=1:100
				for l=1:100
					BufRawImage(k,l,j)=fix(MToDisplay(k, l, j)/(256/palitra))*fix(256/palitra);
				end
			end
		end
	case 2
		BufRawImage=zeros(100, 100, 1);
		for k=1:100
			for l=1:100
				BufRawImage(k,l,1)=fix(MToDisplay(k, l)/(256/palitra))*fix(256/palitra);
			end
		end
	case 3
		BufRawImage=zeros(100, 100, 1);
		BufRawImage(:, :, 1)=MToDisplay;
end
notpreparedimages(size(notpreparedimages, 1)+1, :, :, :)=BufRawImage;
answers(length(answers)+1)=get(handles.DescriptionEdit, 'String');
imwrite(MToDisplay, [imagepath, num2str(size(notpreparedimages, 1)), '.jpg']);
fileID = fopen([descriptionpath, num2str(length(answers)), '.txt'], 'a');
cell=answers(length(answers));
fprintf(fileID, '%s' , cell{1});
fclose(fileID);


% --- Executes on button press in ForwardButton.
function ForwardButton_Callback(hObject, eventdata, handles)
% hObject    handle to ForwardButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Получение набора из трех двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
%интенсивность красного, зеленого и синего цвета каждого пикселя соответственно
%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа
global palitra;
global potrtaitimages;
global pictureimages;
global notpreparedportraitimages;
global notpreparedpictureimages;
global portraitanswers;
global pictureanswers;
global strategy;

if get(handles.PortraitRadio, 'Value') == 1
	addimage(potrtaitimages, notpreparedportraitimages, portraitanswers,  '��������\', '�������� (��������)\', handles);
else
	addimage(pictureimages, notpreparedpictureimages, pictureanswers, '�������\', '������� (��������)\', handles);
end



TrainingEnd;
hf=findobj('Name','Training');
close(hf);

% --- Executes on button press in BackButton.
function BackButton_Callback(hObject, eventdata, handles)
% hObject    handle to BackButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MainMenu;
hf=findobj('Name','Training');
close(hf);


function DescriptionEdit_Callback(hObject, eventdata, handles)
% hObject    handle to DescriptionEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DescriptionEdit as text
%        str2double(get(hObject,'String')) returns contents of DescriptionEdit as a double


% --- Executes during object creation, after setting all properties.
function DescriptionEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DescriptionEdit (see GCBO)
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
Path = get(handles.PathEdit, 'String');
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
end
% Hint: get(hObject,'Value') returns toggle state of PictureRadio


