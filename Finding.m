function varargout = Finding(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Finding_OpeningFcn, ...
                   'gui_OutputFcn',  @Finding_OutputFcn, ...
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

function Finding_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = Finding_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function PathEdit_Callback(hObject, eventdata, handles)


function PathEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Нахождение пути к тестовому изображению
function BrowseButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.jpg','Select jpg-image');
Path=get(handles.PathEdit, 'String');
Path = [PathName, FileName];
set(handles.PathEdit, 'String', Path);

%Возврат к главному меню
function BackButton_Callback(hObject, eventdata, handles)
MainMenu;
hf=findobj('Name','Finding');
close(hf);

function ForwardButton_Callback(hObject, eventdata, handles)
global strategy;
global notpreparedtest;
global palitra;
global portraitimages;
global pictureimages;
switch strategy
	case 1
		V = zeros(1, 10000, 3);
	case 2
		V = zeros(1, 10000);
end
%Работа с тестовым изображением
%Получение двумерных массивов, взятых из jpg-файла. Каждый массив отвечает за
%интенсивность своего цвета каждого пикселя соответственно
%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа
switch strategy
	case 1
		notpreparedtest=imresize(imread(get(handles.PathEdit, 'String')), [100 100]);
	case 2
		notpreparedtest=imresize(rgb2gray(imread(get(handles.PathEdit, 'String'))), [100 100]);
end

%Перевод массива в вектор-строку
switch strategy
	case 1
		for i = 1 : 3
			V(:,:,i)=reshape(notpreparedtest(:, :, i), 1, 10000);
		end
	case 2
		V(:,:)=reshape(notpreparedtest, 1, 10000);
end
	
%Перевод значений массива из типа int в тип double
notpreparedtest=double(notpreparedtest);

%Создание вектора-строки testimage, который будет хранить бинарную комбинацию тестового изображения
switch strategy
	case 1
		testimage = zeros(1, 10000*palitra*3);
	case 2
		testimage = zeros(1, 10000*palitra);
end

%Заполнение вектора-столбца testimage
switch strategy
	case 1
		for j = 1:3
			for k=1:10000
				testimage(1, palitra*3*(k-1) + fix(V(1, k, j)/(256/palitra)) + palitra*(j-1) + 1)=true;
			end
		end
	case 2
		for m=1:1:10000
			testimage(1, (m-1)*palitra + fix(V(1, m)/(256/palitra)) + 1)=true;
		end
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
else
	res = pictureimages * testimage';
	imagekind='picture';
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
switch strategy
	case 1
		threshold=5000;
	case 2
		threshold=1500;
end


global ImageToShow;
if max > threshold
	ImageToShow=imax;
    %Выводим изображение на экран, если порог превышен
else
	ImageToShow=0;
    %Иначе выводим в консоли изображение не распознано
end

FindingTest;
hf=findobj('Name','Finding');
close(hf);

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


