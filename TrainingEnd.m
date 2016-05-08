function varargout = TrainingEnd(varargin)
% TRAININGEND M-file for TrainingEnd.fig
%      TRAININGEND, by itself, creates a new TRAININGEND or raises the existing
%      singleton*.
%
%      H = TRAININGEND returns the handle to a new TRAININGEND or the handle to
%      the existing singleton*.
%
%      TRAININGEND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAININGEND.M with the given input arguments.
%
%      TRAININGEND('Property','Value',...) creates a new TRAININGEND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TrainingEnd_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TrainingEnd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help TrainingEnd

% Last Modified by GUIDE v2.5 09-May-2016 00:47:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrainingEnd_OpeningFcn, ...
                   'gui_OutputFcn',  @TrainingEnd_OutputFcn, ...
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


% --- Executes just before TrainingEnd is made visible.
function TrainingEnd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TrainingEnd (see VARARGIN)

% Choose default command line output for TrainingEnd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TrainingEnd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TrainingEnd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MainMenu;
hf=findobj('Name','TrainingEnd');
close(hf);

