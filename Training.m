function varargout = Training(varargin)
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

function Training_OpeningFcn(hObject, eventdata, handles, varargin)
set(handles.PortraitRadio, 'Value', 1);
handles.output = hObject;
guidata(hObject, handles);


function varargout = Training_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function PathEdit_Callback(hObject, eventdata, handles)


function PathEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%Добавление изображения в базу данных и масссив images
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
end

%Получение двумерного массива(набора из трех двумерных массиво), взятого из jpg-файла. Массив отвечает за
%интенсивность цветов каждого пикселя соответственно.
%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа.
switch strategy
	case 1
		MToDisplay=imresize(imread(get(handles.PathEdit, 'String')), [100 100]);
	case 2
		MToDisplay=rgb2gray(imresize(imread(get(handles.PathEdit, 'String')), [100 100]));
end

%Перевод массива в вектор-строку 
switch strategy
	case 1
		for x = 1 : 3
			V(:,:,x)=reshape(MToDisplay(:, :, x), 1, 10000);
		end
	case 2
		V(:,:)=reshape(MToDisplay, 1, 10000);
end

%Перевод вектор-строки в бинарную вектор-строку 
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
end

%Добавление изображения в нейронную сеть
images(size(images, 1)+1, :) = BufBinary(1, :);
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
end
notpreparedimages(size(notpreparedimages, 1)+1, :, :, :)=BufRawImage;
answers(length(answers)+1)=get(handles.DescriptionEdit, 'String');
imwrite(MToDisplay, [imagepath, num2str(size(notpreparedimages, 1)), '.jpg']);
fileID = fopen([descriptionpath, num2str(length(answers)), '.txt'], 'a');
cell=answers(length(answers));
fprintf(fileID, '%s' , cell{1});
fclose(fileID);

%Запуск добавления изображения в нейронную сеть
function ForwardButton_Callback(hObject, eventdata, handles)
global palitra;
global potrtaitimages;
global pictureimages;
global notpreparedportraitimages;
global notpreparedpictureimages;
global portraitanswers;
global pictureanswers;
global strategy;

if get(handles.PortraitRadio, 'Value') == 1
	addimage(potrtaitimages, notpreparedportraitimages, portraitanswers,  'Портреты\', 'Портреты (описание)\', handles);
else
	addimage(pictureimages, notpreparedpictureimages, pictureanswers, 'Картины\', 'Картины (описание)\', handles);
end

TrainingEnd;
hf=findobj('Name','Training');
close(hf);

%Возвращение в главное меню
function BackButton_Callback(hObject, eventdata, handles)
MainMenu;
hf=findobj('Name','Training');
close(hf);


function DescriptionEdit_Callback(hObject, eventdata, handles)

function DescriptionEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%Нахождение пути к эталонному изображению
function BrowseButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.jpg','Select jpg-image');
Path = get(handles.PathEdit, 'String');
Path = [PathName, FileName];
set(handles.PathEdit, 'String', Path);


%Выбор базы портретов
function PortraitRadio_Callback(hObject, eventdata, handles)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.PictureRadio, 'Value', 0);
end

%Выбор базы картин
function PictureRadio_Callback(hObject, eventdata, handles)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.PortraitRadio, 'Value', 0);
end