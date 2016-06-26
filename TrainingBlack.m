function varargout = TrainingBlack(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrainingBlack_OpeningFcn, ...
                   'gui_OutputFcn',  @TrainingBlack_OutputFcn, ...
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


function TrainingBlack_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);


function varargout = TrainingBlack_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function PathEdit_Callback(hObject, eventdata, handles)


function PathEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Добавление изображения в базу данных и масссив images
function addimage(images, notpreparedimages, answers, imagepath, descriptionpath, handles)
V = zeros(1, 10000);
BufBinary = zeros(1, 10000);

%Получение двумерного массива, взятого из jpg-файла. Массив отвечает за
%наличие/отсутствие белого цвета каждого пикселя соответственно.
%После идет перевод изображения N*N к размеру 100*100 по методу ближайшего соседа.
MToDisplay=im2bw(imresize(imread(get(handles.PathEdit, 'String')), [100 100]), 0.5);

%Перевод массива в бинарную вектор-строку и последующее инвертирование
V(:,:)=reshape(MToDisplay, 1, 10000);
for m=1:1:10000
	BufBinary(1, m)=~V(1,m);
end

%Добавление изображения в нейронную сеть
images(size(images, 1)+1, :) = BufBinary(1, :);
notpreparedimages(size(notpreparedimages, 1)+1, :, :)=MToDisplay;
answers(length(answers)+1)=get(handles.DescriptionEdit, 'String');
imwrite(MToDisplay, [imagepath, num2str(size(notpreparedimages, 1)), '.jpg']);
fileID = fopen([descriptionpath, num2str(length(answers)), '.txt'], 'a');
cell=answers(length(answers));
fprintf(fileID, '%s' , cell{1});
fclose(fileID);


%Нахождение пути к эталонному изображению
function BrowseButton_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.jpg','Select jpg-image');
Path = get(handles.PathEdit, 'String');
Path = [PathName, FileName];
set(handles.PathEdit, 'String', Path);


function DescriptionEdit_Callback(hObject, eventdata, handles)


function DescriptionEdit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%Выбор базы портретов
function PortraitRadio_Callback(hObject, eventdata, handles)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.PictureRadio, 'Value', 0);
	set(handles.ECGRadio, 'Value', 0);
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

%Возвращение в главное меню
function BackButton_Callback(hObject, eventdata, handles)
MainMenu;
hf=findobj('Name','TrainingBlack');
close(hf);

%Запуск добавления изображения в нейронную сеть
function OKButton_Callback(hObject, eventdata, handles)
global potrtaitimages;
global pictureimages;
global ECGimages;
global notpreparedportraitimages;
global notpreparedpictureimages;
global notpreparedECGimages;
global portraitanswers;
global pictureanswers;
global ECGanswers;

if get(handles.PortraitRadio, 'Value') == 1
	addimage(potrtaitimages, notpreparedportraitimages, portraitanswers,  '��������\', '�������� (��������)\', handles);
else if get(handles.PictureRadio, 'Value') == 1
		addimage(pictureimages, notpreparedpictureimages, pictureanswers, '�������\', '������� (��������)\', handles);
	else 
		addimage(ECGimages, notpreparedECGimages, ECGanswers, '���\', '��� (��������)\', handles);
	end
end

TrainingEnd;
hf=findobj('Name','TrainingBlack');
close(hf);

