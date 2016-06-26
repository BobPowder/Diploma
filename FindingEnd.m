function varargout = FindingEnd(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FindingEnd_OpeningFcn, ...
                   'gui_OutputFcn',  @FindingEnd_OutputFcn, ...
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


function FindingEnd_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
global ImageToShow;
global notpreparedportraitimages;
global notpreparedpictureimages;
global notpreparedECGimages;
global portraitanswers;
global pictureanswers;
global ECGanswers;
global strategy;
global imagekind;
set(handles.ResultImage, 'visible', 'on');

%В зависимости от того, какая база изображений использовалась для распознавания тестового
% берутся соответствующие массивы бинарных строк и массивы изображений
switch imagekind
	case 'portrait'
		notpreparedimages=notpreparedportraitimages;
		answers=portraitanswers;
	case 'picture'
		notpreparedimages=notpreparedpictureimages;
		answers=pictureanswers;
	case 'ECG'
		notpreparedimages=notpreparedECGimages;
		answers=ECGanswers;
end

%Если тестовое изображение распознано
if ImageToShow > 0
	% В зависимости от того, с какой цветностью изображений работает программа
	switch strategy
		case 1
			%Вывести полноцветное эталонное изображение
			I = zeros(100, 100, 3); 
			I(:, :, :) = notpreparedimages(ImageToShow, :, :, :);
			I=uint8(I);
			axes(handles.ResultImage);
		case 2
			%Вывести полутоновое эталонное изображение
			I = zeros(100, 100); 
			I(:, :) = notpreparedimages(ImageToShow, :, :);
			I=uint8(I);
			axes(handles.ResultImage);
		case 3
			%Вывести контурное эталонное изображение
			I = zeros(100, 100); 
			I(:, :) = notpreparedimages(ImageToShow, :, :);
			I=logical(I);
			axes(handles.ResultImage);
	end
	imshow(I);
	Path = answers{ImageToShow};
	%Вывести описание эталонного изображения
	set(handles.Description, 'String', Path);
%Если тестовое изображение НЕ распознано	
else
	%Вывести 'Image not found'
	set(handles.ResultImage, 'visible', 'off');
	set(handles.Description, 'String', 'Image not found');
end
guidata(hObject, handles);



function varargout = FindingEnd_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

%Возврат в главное меню
function OKButton_Callback(hObject, eventdata, handles)
MainMenu;
hf=findobj('Name','FindingEnd');
close(hf);

