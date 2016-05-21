function varargout = FindingEnd(varargin)
% FINDINGEND M-file for FindingEnd.fig
%      FINDINGEND, by itself, creates a new FINDINGEND or raises the existing
%      singleton*.
%
%      H = FINDINGEND returns the handle to a new FINDINGEND or the handle to
%      the existing singleton*.
%
%      FINDINGEND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINDINGEND.M with the given input arguments.
%
%      FINDINGEND('Property','Value',...) creates a new FINDINGEND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FindingEnd_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FindingEnd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help FindingEnd

% Last Modified by GUIDE v2.5 10-May-2016 00:01:03

% Begin initialization code - DO NOT EDIT
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
% End initialization code - DO NOT EDIT


% --- Executes just before FindingEnd is made visible.
function FindingEnd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FindingEnd (see VARARGIN)

% Choose default command line output for FindingEnd
handles.output = hObject;
global ImageToShow;
global notpreparedimages;
global answers;
global strategy;
%handles
set(handles.ResultImage, 'visible', 'on');
if ImageToShow > 0
	switch strategy
		case 1
			I = zeros(100, 100, 3); 
			I(:, :, :) = notpreparedimages(ImageToShow, :, :, :);
			I=uint8(I);
			axes(handles.ResultImage);
		case 2
			I = zeros(100, 100); 
			I(:, :) = notpreparedimages(ImageToShow, :, :);
			I=uint8(I);
			axes(handles.ResultImage);
		case 3
			I = zeros(100, 100); 
			I(:, :) = notpreparedimages(ImageToShow, :, :);
			I=logical(I);
			axes(handles.ResultImage);
	end
	imshow(I);
	%Path = get(handles.Description, 'String');
	Path = answers{ImageToShow};
	set(handles.Description, 'String', Path);
else
	set(handles.ResultImage, 'visible', 'off');
	set(handles.Description, 'String', 'Image not found');
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FindingEnd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FindingEnd_OutputFcn(hObject, eventdata, handles) 
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
MainMenu;
hf=findobj('Name','FindingEnd');
close(hf);

