function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 19-Feb-2014 02:52:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
global dataset_pelatihan svmpria pitchpria stdformantpria grouppria formant1pria formant2pria formant3pria grouplatihpria formantpria errorlatihpria persentaselatihpria
[a,map]=imread('back.png');
[r,c,d]=size(a); 
x=ceil(r/40); 
y=ceil(c/40); 
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.back,'CData',g);
if ~isempty(svmpria)
    dataset_pelatihan = round(dataset_pelatihan);
    set(handles.uitable1, 'Data', dataset_pelatihan);
    set(handles.uitable1,'ColumnWidth',{70});
    set(handles.uitable2,'Data',[pitchpria formantpria stdformantpria grouppria grouplatihpria])
    set(handles.uitable2,'ColumnWidth',{58})
    set(handles.text6,'String', [errorlatihpria]);
    set(handles.text7,'String', persentaselatihpria);
    axes(handles.axes2);
    svmtrain([pitchpria stdformantpria],grouppria,'Kernel_Function','rbf','showplot','true');
end

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function direktori_CreateFcn(hObject, eventdata, handles)
% hObject    handle to direktori (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pilih.
function pilih_Callback(hObject, eventdata, handles)
global dataset_pelatihan;
    [filename, pathname] = uigetfile('*.dat');
    set(handles.direktori,'String', [pathname,filename]);
    direktori=get(handles.direktori,'String');
    if ~exist(direktori)
        set(handles.direktori,'String',' ')
    elseif exist(direktori)
        [~, ~, extension] = fileparts(direktori);
        if extension=='.dat'
            set(handles.figure1,'name',['Data Pelatihan : "' direktori '"']);
            dataset_pelatihan = load(direktori);
            dataset_pelatihan = round(dataset_pelatihan);
            set(handles.uitable1, 'Data', dataset_pelatihan);
            set(handles.uitable1,'ColumnWidth',{70})
        end
    end 

function proses_Callback(hObject, eventdata, handles)
global persentaselatihwanita errorlatihwanita formant1pria formant2pria formant3pria persentaselatihpria errorlatihpria dataset_pelatihan stdformantpria pitchwanita stdformantwanita pitchpria formantpria grouppria grouplatihpria formantwanita svmpria groupwanita svmwanita grouplatihwanita
    direktori=get(handles.direktori,'String');
    [~, ~, extension] = fileparts(direktori);
    if exist(direktori)
        if extension=='.dat'
            pitch=dataset_pelatihan(1:end,1);
            formant1=dataset_pelatihan(1:end,2);
            formant2=dataset_pelatihan(1:end,3);
            formant3=dataset_pelatihan(1:end,4);
            group=dataset_pelatihan(1:end,5);
            gender=dataset_pelatihan(1:end,6);
            %% fitur suara pria
            pitchpria=pitch(gender~=0);
            formant1pria=formant1(gender~=0);
            formant2pria=formant2(gender~=0);
            formant3pria=formant3(gender~=0);
            formantpria=[formant1pria formant2pria formant3pria];
            stdformantpria=round(std(formantpria')');
            grouppria=group(gender~=0);
            %% Fitur suara wanita
            pitchwanita=pitch(gender~=1);
            formant1wanita=formant1(gender~=1);
            formant2wanita=formant2(gender~=1);
            formant3wanita=formant3(gender~=1);
            formantwanita=[formant1wanita formant2wanita formant3wanita];
            stdformantwanita=round(std(formantwanita')');
            groupwanita=group(gender~=1);
            axes(handles.axes2);
            %% Membuat Model SVM untuk pria
            svmpria=svmtrain([pitchpria stdformantpria],grouppria,'Kernel_Function','rbf','showplot',true);
            grouplatihpria=svmclassify(svmpria,[pitchpria stdformantpria]);
            %hold on;plot(pitchpria,stdformantpria,'ro','MarkerSize',8);hold off
            set(handles.uitable2, 'Data', [pitchpria formant1pria formant2pria formant3pria stdformantpria grouppria grouplatihpria]);
            set(handles.uitable2,'ColumnWidth',{58})
            jumlahdatapria=length(grouplatihpria);
            errorlatihpria=sum(grouppria~=grouplatihpria);
            persentaselatihpria=(jumlahdatapria-errorlatihpria)/jumlahdatapria*100;
            set(handles.text6,'String', errorlatihpria);
            set(handles.text7,'String', persentaselatihpria);
            %% Membuat Model SVM untk wanita
            svmwanita=svmtrain([pitchwanita stdformantwanita],groupwanita,'Kernel_Function','rbf');
            grouplatihwanita=svmclassify(svmwanita,[pitchwanita stdformantwanita]);
            jumlahdatawanita=length(grouplatihwanita);
            errorlatihwanita=sum(groupwanita~=grouplatihwanita);
            persentaselatihwanita=(jumlahdatawanita-errorlatihwanita)/jumlahdatawanita*100;
        else
            msgbox('Format file yang dimasukan tidak sesuai', '','help');
        end
    else
       msgbox('Silahkan pilih file pelatihan terlebih dahulu', '','help');
    end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global svmpria svmwanita persentaselatihpria errorlatihwanita formantwanita persentaselatihwanita stdformantwanita errorlatihpria groupwanita grouplatihwanita stdformantpria  pitchpria formantpria grouppria grouplatihpria pitchwanita
option = get(handles.popupmenu1, 'Value');
if (option==1)
    if isempty(svmpria)
        msgbox('Belum ada model klasifikasi', '','help');
    else
        set(handles.uitable2,'Data',[pitchpria formantpria stdformantpria grouppria grouplatihpria])
        set(handles.uitable2,'ColumnWidth',{58})
        set(handles.text6,'String', [errorlatihpria]);
        set(handles.text7,'String', persentaselatihpria);
        axes(handles.axes2);
        svmtrain([pitchpria stdformantpria],grouppria,'Kernel_Function','rbf','showplot','true');
    end
elseif(option==2)
    if isempty(svmwanita)
        msgbox('Belum ada model klasifikasi', '','help');
    else
        set(handles.uitable2, 'Data', [pitchwanita formantwanita stdformantwanita groupwanita grouplatihwanita]);
        set(handles.uitable2,'ColumnWidth',{58})
        set(handles.text6,'String', [errorlatihwanita]);
        set(handles.text7,'String', persentaselatihwanita);
        axes(handles.axes2);
        svmtrain([pitchwanita stdformantwanita],groupwanita,'Kernel_Function','rbf','showplot','true');
    end
end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Aksi_Callback(hObject, eventdata, handles)
% hObject    handle to Aksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function model_Callback(hObject, eventdata, handles)
% hObject    handle to model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function prediksi_suara_Callback(hObject, eventdata, handles)
% hObject    handle to prediksi_suara (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uji_fitur_Callback(hObject, eventdata, handles)
% hObject    handle to uji_fitur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
set(index,'Visible','on');
set(handles.output,'Visible','off');
