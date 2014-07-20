function varargout = petunjuk(varargin)
% PETUNJUK MATLAB code for petunjuk.fig
%      PETUNJUK, by itself, creates a new PETUNJUK or raises the existing
%      singleton*.
%
%      H = PETUNJUK returns the handle to a new PETUNJUK or the handle to
%      the existing singleton*.
%
%      PETUNJUK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PETUNJUK.M with the given input arguments.
%
%      PETUNJUK('Property','Value',...) creates a new PETUNJUK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before petunjuk_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to petunjuk_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help petunjuk

% Last Modified by GUIDE v2.5 19-Feb-2014 03:12:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @petunjuk_OpeningFcn, ...
                   'gui_OutputFcn',  @petunjuk_OutputFcn, ...
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


% --- Executes just before petunjuk is made visible.
function petunjuk_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to petunjuk (see VARARGIN)

% Choose default command line output for petunjuk
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes2);
imshow('book.png');
[a,map]=imread('back.png');
[r,c,d]=size(a); 
x=ceil(r/40); 
y=ceil(c/40); 
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.back,'CData',g);

% UIWAIT makes petunjuk wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = petunjuk_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
set(index,'Visible','on');
set(handles.output,'Visible','off');
