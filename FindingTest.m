function varargout = FindingTest(varargin)
% FindingTest M-file for FindingTest.fig
%      FindingTest, by itself, creates a new FindingTest or raises the existing
%      singleton*.
%
%      H = FindingTest returns the handle to a new FindingTest or the handle to
%      the existing singleton*.
%
%      FindingTest('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FindingTest.M with the given input arguments.
%
%      FindingTest('Property','Value',...) creates a new FindingTest or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FindingTest_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FindingTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help FindingTest

% Last Modified by GUIDE v2.5 06-Jun-2016 22:19:21

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before FindingTest is made visible.
function FindingTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FindingTest (see VARARGIN)

% Choose default command line output for FindingTest
handles.output = hObject;
global notpreparedtest;
global ImageToShow;
global notpreparedportraitimages;
global notpreparedpictureimages;
global portraitanswers;
global pictureanswers;
global strategy;
global imagekind;
%handles
set(handles.ResultImage, 'visible', 'on');

switch strategy
		case 1
			notpreparedtest=uint8(notpreparedtest);
		case 2
			notpreparedtest=uint8(notpreparedtest);
		case 3
			notpreparedtest=double(notpreparedtest);
	end


axes(handles.ResultImage);
imshow(notpreparedtest);
set(handles.Description, 'String', 'Testpicture');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FindingTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FindingTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FindingEnd;
hf=findobj('Name','FindingTest');
close(hf);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FindingEnd;
hf=findobj('Name','FindingTest');
close(hf);

