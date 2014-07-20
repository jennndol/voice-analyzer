function varargout = index(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @index_OpeningFcn, ...
                   'gui_OutputFcn',  @index_OutputFcn, ...
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

function index_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
axes(handles.axes2);
imshow('coba.png');
axes(handles.axes4);
imshow('unikom.png');
guidata(hObject, handles);
guidata(hObject, handles);
guidata(hObject, handles);

function varargout = index_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
set(main,'Visible','on');
set(handles.output,'Visible','off');
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
set(prediksi_emosi,'Visible','on');
set(handles.output,'Visible','off');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
set(pengujian,'Visible','on');
set(handles.output,'Visible','off');

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
set(petunjuk,'Visible','on');
set(handles.output,'Visible','off');

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
set(tentang,'Visible','on');
set(handles.output,'Visible','off');
