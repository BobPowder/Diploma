function varargout = TrainingBlack(varargin)
% TRAININGBLACK M-file for TrainingBlack.fig
%      TRAININGBLACK, by itself, creates a new TRAININGBLACK or raises the existing
%      singleton*.
%
%      H = TRAININGBLACK returns the handle to a new TRAININGBLACK or the handle to
%      the existing singleton*.
%
%      TRAININGBLACK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAININGBLACK.M with the given input arguments.
%
%      TRAININGBLACK('Property','Value',...) creates a new TRAININGBLACK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TrainingBlack_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TrainingBlack_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help TrainingBlack

% Last Modified by GUIDE v2.5 08-Jun-2016 19:03:33

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before TrainingBlack is made visible.
function TrainingBlack_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TrainingBlack (see VARARGIN)

% Choose default command line output for TrainingBlack
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TrainingBlack wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TrainingBlack_OutputFcn(hObject, eventdata, handles) 
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

% –°‚Äû–°—ì–†–Ö–†—î–°‚Ä†–†—ë–°–è –†“ë–†—ï–†¬±–†¬∞–†–Ü–†¬ª–†¬µ–†–Ö–†—ë–°–è –†—ë–†¬∑–†—ï–†¬±–°–Ç–†¬∞–†¬∂–†¬µ–†–Ö–†—ë–°–è –†–Ü –†–Ö–°—ì–†¬∂–†–Ö–°—ì–°–ã –†¬±–†¬∞–†¬∑–°—ì
function addimage(images, notpreparedimages, answers, imagepath, descriptionpath, handles)
global palitra;
global strategy;

V = zeros(1, 10000);
BufBinary = zeros(1, 10000);

MToDisplay=im2bw(imresize(imread(get(handles.PathEdit, 'String')), [100 100]), 0.5);

V(:,:)=reshape(MToDisplay, 1, 10000);
for m=1:1:10000
	BufBinary(1, m)=~V(1,m);
end

images(size(images, 1)+1, :) = BufBinary(1, :);
BufRawImage=zeros(100, 100, 1);
BufRawImage(:, :, 1)=MToDisplay;

notpreparedimages(size(notpreparedimages, 1)+1, :, :, :)=BufRawImage;
answers(length(answers)+1)=get(handles.DescriptionEdit, 'String');
%[imagepath, num2str(size(notpreparedimages, 1)), '.jpg']
imwrite(MToDisplay, [imagepath, num2str(size(notpreparedimages, 1)), '.jpg']);
fileID = fopen([descriptionpath, num2str(length(answers)), '.txt'], 'a');
cell=answers(length(answers));
fprintf(fileID, '%s' , cell{1});
fclose(fileID);


% --- Executes on button press in BrowseButton.
function BrowseButton_Callback(hObject, eventdata, handles)
% hObject    handle to BrowseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.jpg','Select jpg-image');
Path = get(handles.PathEdit, 'String');
Path = [PathName, FileName];
set(handles.PathEdit, 'String', Path);


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


% --- Executes on button press in PortraitRadio.
function PortraitRadio_Callback(hObject, eventdata, handles)
% hObject    handle to PortraitRadio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==0
	set(hObject,'Value', 1);
else
	set(handles.PictureRadio, 'Value', 0);
	set(handles.ECGRadio, 'Value', 0);
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
hf=findobj('Name','TrainingBlack');
close(hf);


% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global palitra;
global potrtaitimages;
global pictureimages;
global ECGimages;
global notpreparedportraitimages;
global notpreparedpictureimages;
global notpreparedECGimages;
global portraitanswers;
global pictureanswers;
global ECGanswers;
global strategy;

if get(handles.PortraitRadio, 'Value') == 1
	addimage(potrtaitimages, notpreparedportraitimages, portraitanswers,  'œÓÚÂÚ˚\', 'œÓÚÂÚ˚ (ÓÔËÒ‡ÌËÂ)\', handles);
else if get(handles.PictureRadio, 'Value') == 1
		addimage(pictureimages, notpreparedpictureimages, pictureanswers, ' ‡ÚËÌ˚\', ' ‡ÚËÌ˚ (ÓÔËÒ‡ÌËÂ)\', handles);
	else 
		addimage(ECGimages, notpreparedECGimages, ECGanswers, '› √\', '› √ (ÓÔËÒ‡ÌËÂ)\', handles);
	end
end

TrainingEnd;
hf=findobj('Name','TrainingBlack');
close(hf);

