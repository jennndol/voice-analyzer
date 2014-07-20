function varargout = pengujian(varargin)
% PENGUJIAN MATLAB code for pengujian.fig
%      PENGUJIAN, by itself, creates a new PENGUJIAN or raises the existing
%      singleton*.
%
%      H = PENGUJIAN returns the handle to a new PENGUJIAN or the handle to
%      the existing singleton*.
%
%      PENGUJIAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PENGUJIAN.M with the given input arguments.
%
%      PENGUJIAN('Property','Value',...) creates a new PENGUJIAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pengujian_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pengujian_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pengujian

% Last Modified by GUIDE v2.5 19-Feb-2014 02:36:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pengujian_OpeningFcn, ...
                   'gui_OutputFcn',  @pengujian_OutputFcn, ...
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


% --- Executes just before pengujian is made visible.
function pengujian_OpeningFcn(hObject, eventdata, handles, varargin)
[a,map]=imread('back.png');
[r,c,d]=size(a); 
x=ceil(r/40); 
y=ceil(c/40); 
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.back,'CData',g);

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pengujian wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pengujian_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function direktori_Callback(hObject, eventdata, handles)
% hObject    handle to direktori (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of direktori as text
%        str2double(get(hObject,'String')) returns contents of direktori as a double


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
global dataset_pengujian
[filename, pathname] = uigetfile('*.dat');
    set(handles.direktori,'String', [pathname,filename]);
    direktori=get(handles.direktori,'String'); 
    [~, ~, extension] = fileparts(direktori);   
    if exist(direktori)
        if extension=='.dat'
            set(handles.figure1,'name',['Data Pelatihan : "' direktori '"']);
            dataset_pengujian = load(direktori);
            dataset_pengujian = round(dataset_pengujian);
            set(handles.uitable1, 'Data', dataset_pengujian);
            set(handles.uitable1,'ColumnWidth',{70})
        end
    end

% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
global dataset_pelatihan svmpria svmwanita pitchpria stdformantpria grouppria dataset_pengujian group_prediksi_pria   presentase_prediksi_wanita pitch_uji_wanita error_prediksi_wanita formant_uji_wanita sdf_uji_wanita group_uji_wanita   group_prediksi_wanita pitch_uji_pria sdf_uji_pria group_uji_pria formant_uji_pria error_prediksi_pria presentase_prediksi_pria
direktori=get(handles.direktori,'String');
[~, ~, extension] = fileparts(direktori);
    if exist(direktori)
        if extension=='.dat'
            if isempty(svmpria)
                 msgbox('Belum ada model klasifikasi', '','help');
            else
                pitch=dataset_pengujian(1:end,1);
                formant1=dataset_pengujian(1:end,2);
                formant2=dataset_pengujian(1:end,3);
                formant3=dataset_pengujian(1:end,4);
                group=dataset_pengujian(1:end,5);
                gender=dataset_pengujian(1:end,6);
                %% Inisialisasi untuk pria
                pitch_uji_pria=pitch(gender~=0);
                formant_1_uji_pria=formant1(gender~=0);
                formant_2_uji_pria=formant2(gender~=0);
                formant_3_uji_pria=formant3(gender~=0);
                formant_uji_pria=[formant_1_uji_pria formant_2_uji_pria formant_3_uji_pria];
                group_uji_pria=group(gender~=0);
                sdf_uji_pria=std(formant_uji_pria')';
                sdf_uji_pria=round(sdf_uji_pria);
                %% Inisialisasi untuk wanita
                pitch_uji_wanita=pitch(gender~=1);
                formant_1_uji_wanita=formant1(gender~=1);
                formant_2_uji_wanita=formant2(gender~=1);
                formant_3_uji_wanita=formant3(gender~=1);
                formant_uji_wanita=[formant_1_uji_wanita formant_2_uji_wanita formant_3_uji_wanita];
                group_uji_wanita=group(gender~=1);
                sdf_uji_wanita=std(formant_uji_wanita')';
                sdf_uji_wanita=round(sdf_uji_wanita);
                %% Uji Data Pria
                axes(handles.axes1);
                svmpria=svmtrain([pitchpria stdformantpria],grouppria,'Kernel_Function','rbf','showplot',true);
                group_prediksi_pria=svmclassify(svmpria,[pitch_uji_pria sdf_uji_pria],'showplot',true);
                hold on;
                plot(pitch_uji_pria,sdf_uji_pria,'ro','MarkerSize',20);
                hold off
                jumlah_data_pria=length(group_uji_pria);
                error_prediksi_pria=sum(group_uji_pria~=group_prediksi_pria);
                presentase_prediksi_pria=(jumlah_data_pria-error_prediksi_pria)/jumlah_data_pria*100;
                set(handles.uitable2, 'Data', [pitch_uji_pria formant_uji_pria sdf_uji_pria group_uji_pria group_prediksi_pria]);
                set(handles.uitable2,'ColumnWidth',{58})
                set(handles.text9,'String', error_prediksi_pria);
                set(handles.text10,'String', presentase_prediksi_pria);
                %% Uji Data Wanita
                group_prediksi_wanita=svmclassify(svmwanita,[pitch_uji_wanita sdf_uji_wanita]);
                jumlah_data_wanita=length(group_uji_wanita);
                error_prediksi_wanita=sum(group_uji_wanita~=group_prediksi_wanita);
                presentase_prediksi_wanita=(jumlah_data_wanita-error_prediksi_wanita)/jumlah_data_wanita*100;

                %% 
                mixing=[dataset_pengujian;dataset_pelatihan];
            end
        else
            msgbox('Format file yang dimasukan tidak sesuai', '','help');
        end
    else
       msgbox('Silahkan pilih file pengujian terlebih dahulu', '','help');
    end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global group_prediksi_pria pitchpria presentase_prediksi_wanita pitch_uji_wanita error_prediksi_wanita formant_uji_wanita sdf_uji_wanita group_uji_wanita groupwanita stdformantwanita pitchwanita group_prediksi_wanita stdformantpria grouppria pitch_uji_pria sdf_uji_pria group_uji_pria formant_uji_pria error_prediksi_pria presentase_prediksi_pria
option = get(handles.popupmenu1, 'Value');
if (option==1)
    if isempty(group_prediksi_pria)
        msgbox('Silahkan lakukan pengujian terlebih dahulu', '','help');
    else
        axes(handles.axes1);
        svmpria=svmtrain([pitchpria stdformantpria],grouppria,'Kernel_Function','rbf','showplot',true);
        group_prediksi_pria=svmclassify(svmpria,[pitch_uji_pria sdf_uji_pria],'showplot',true);
        hold on;
        plot(pitch_uji_pria,sdf_uji_pria,'ro','MarkerSize',20);
        hold off
        jumlah_data_pria=length(group_uji_pria);
        error_prediksi_pria=sum(group_uji_pria~=group_prediksi_pria);
        presentase_prediksi_pria=(jumlah_data_pria-error_prediksi_pria)/jumlah_data_pria*100;
        set(handles.uitable2, 'Data', [pitch_uji_pria formant_uji_pria sdf_uji_pria group_uji_pria group_prediksi_pria]);
        set(handles.uitable2,'ColumnWidth',{58})
        set(handles.text9,'String', error_prediksi_pria);
        set(handles.text10,'String', presentase_prediksi_pria);
    end
elseif(option==2)
    if isempty(group_prediksi_wanita)
        msgbox('Silahkan lakukan pengujian terlebih dahulu', '','help');
    else
        axes(handles.axes1);
        svmwanita=svmtrain([pitchwanita stdformantwanita],groupwanita,'Kernel_Function','rbf','showplot',true);
        group_prediksi_wanita=svmclassify(svmwanita,[pitch_uji_wanita sdf_uji_wanita],'showplot',true);
        hold on;
        plot(pitch_uji_wanita,sdf_uji_wanita,'ro','MarkerSize',20);
        hold off
        set(handles.uitable2, 'Data', [pitch_uji_wanita formant_uji_wanita sdf_uji_wanita group_uji_wanita group_prediksi_wanita]);
        set(handles.uitable2,'ColumnWidth',{58})
        set(handles.text9,'String', error_prediksi_wanita);
        set(handles.text10,'String', presentase_prediksi_wanita);
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
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
set(index,'Visible','on');
set(handles.output,'Visible','off');

