function varargout = tentang(varargin)
% TENTANG MATLAB code for tentang.fig
%      TENTANG, by itself, creates a new TENTANG or raises the existing
%      singleton*.
%
%      H = TENTANG returns the handle to a new TENTANG or the handle to
%      the existing singleton*.
%
%      TENTANG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TENTANG.M with the given input arguments.
%
%      TENTANG('Property','Value',...) creates a new TENTANG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tentang_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tentang_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tentang

% Last Modified by GUIDE v2.5 19-Feb-2014 02:44:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tentang_OpeningFcn, ...
                   'gui_OutputFcn',  @tentang_OutputFcn, ...
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


% --- Executes just before tentang is made visible.
function tentang_OpeningFcn(hObject, eventdata, handles, varargin)
[a,map]=imread('back.png');
[r,c,d]=size(a); 
x=ceil(r/40); 
y=ceil(c/40); 
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.back,'CData',g);
axes(handles.axes1)
imshow('about.png');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tentang wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tentang_OutputFcn(hObject, eventdata, handles) 
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
