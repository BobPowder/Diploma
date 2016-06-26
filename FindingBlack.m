function varargout = FindingBlack(varargin)
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


function FindingBlack_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = FindingBlack_OutputFcn(hObject, eventdata, handles) 
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

%Выбор базы портретов
function PortraitRadio_Callback(hObject, eventdata, handles)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.ECGRadio, 'Value', 0);
	set(handles.PictureRadio, 'Value', 0);
end

%Выбор базы картин
function PictureRadio_Callback(hObject, eventdata, handles)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.PortraitRadio, 'Value', 0);
	set(handles.ECGRadio, 'Value', 0);
end

%Выбор базы ЭКГ
function ECGRadio_Callback(hObject, eventdata, handles)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.PortraitRadio, 'Value', 0);
	set(handles.PictureRadio, 'Value', 0);
end

%Возврат к главному меню
function BackButton_Callback(hObject, eventdata, handles)
MainMenu;
hf=findobj('Name','FindingBlack');
close(hf);

function OKButton_Callback(hObject, eventdata, handles)
global notpreparedtest;
global portraitimages;
global pictureimages;
global ECGimages;
V = zeros(1, 10000);

%Получение двумерного массива, взятого из jpg-файла. Массив отвечает за
%наличие/отсутствие белого цвета каждого пикселя соответственно.
%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа.
notpreparedtest=imresize(im2bw(imread(get(handles.PathEdit, 'String')), 0.5), [100 100]);

%Перевод массива в вектор-строку
V(:,:)=reshape(notpreparedtest, 1, 10000);
	
%Создание вектора-строки testimage, который будет хранить бинарную комбинацию тестового изображения
testimage = zeros(1, 10000);

%Заполнение вектора-столбца testimage
for m=1:1:10000
	testimage(1, m)=~V(1,m);
end

% Выбор базы изображений, среди которых будет идти поиск наиболее подходящего эталонного изображения 
% Перемножаем эталонные и тестовую БК
% Результатом будет вектор-столбец, где каждое значение будет хранить
% количество пикселей тествого изображения, совпадающих с соответствующими 
% пикселями эталонных изображений
global imagekind;
if get(handles.PortraitRadio, 'Value') == 1
	res = portraitimages * testimage';
	imagekind='portrait';
elseif get(handles.PictureRadio, 'Value') == 1
		res = pictureimages * testimage';
		imagekind='picture';
else 
		res = ECGimages * testimage';
		imagekind='ECG';
end


% Ищем максимальный элемент в полученном векторе,
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
	%Сохранение номера наиболее похожего эталонного изображения, если порог превышен
	ImageToShow=imax;

else
	%Иначе сохраняем нулевой номер (отсутствие похожего эталонного изображения)
	ImageToShow=0;
    
end

%Вызов модуля FindingTest.m
FindingTest;
hf=findobj('Name','FindingBlack');
close(hf);
