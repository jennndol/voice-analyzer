function varargout = prediksi_emosi(varargin)
% PREDIKSI_EMOSI MATLAB code for prediksi_emosi.fig
%      PREDIKSI_EMOSI, by itself, creates a new PREDIKSI_EMOSI or raises the existing
%      singleton*.
%
%      H = PREDIKSI_EMOSI returns the handle to a new PREDIKSI_EMOSI or the handle to
%      the existing singleton*.
%
%      PREDIKSI_EMOSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PREDIKSI_EMOSI.M with the given input arguments.
%
%      PREDIKSI_EMOSI('Property','Value',...) creates a new PREDIKSI_EMOSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before prediksi_emosi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to prediksi_emosi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help prediksi_emosi

% Last Modified by GUIDE v2.5 19-Feb-2014 02:31:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @prediksi_emosi_OpeningFcn, ...
                   'gui_OutputFcn',  @prediksi_emosi_OutputFcn, ...
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


% --- Executes just before prediksi_emosi is made visible.
function prediksi_emosi_OpeningFcn(hObject, eventdata, handles, varargin)
[a,map]=imread('back.png');
[r,c,d]=size(a); 
x=ceil(r/40); 
y=ceil(c/40); 
g=a(1:x:end,1:y:end,:);
g(g==255)=5.5*255;
set(handles.back,'CData',g);

% Choose default command line output for prediksi_emosi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes prediksi_emosi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = prediksi_emosi_OutputFcn(hObject, eventdata, handles) 
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
[filename, pathname] = uigetfile('*.wav');
set(handles.direktori,'String', [pathname,filename]);
set(handles.emosi,'String', '---');
direktori=get(handles.direktori,'String');
[~, ~, extension] = fileparts(direktori);
if exist(direktori)
    if extension=='.wav'
        [y, fs]=wavread(direktori);
        axes(handles.signal);
        t=[1/fs:1/fs:length(y)/fs];
        plot(t,y);
    end
end
% --- Executes on button press in ekstraksi.
function ekstraksi_Callback(hObject, eventdata, handles)
global  all_f0 all_f1 all_f2 all_f3 f0 f1 f2 f3
direktori=get(handles.direktori,'String');
[~, ~, extension] = fileparts(direktori);
if exist(direktori)
    if extension=='.wav'
        set(handles.figure1,'name',['File suara : "' direktori '"']);
        [y, fs]=wavread(direktori);
        axes(handles.signal);
        t=[1/fs:1/fs:length(y)/fs];
        plot(t,y);
        [premph]=preemphasis(y);
        [f0,f1,f2,f3,all_f0,all_f1,all_f2,all_f3] = feature_extraction(premph, fs);
        %% Mengklasifikasikan emosi dengan pitch
        %% Menampilkan hasil frekuensi pitch dan formant kedalam editor
        axes(handles.ftrack);
        plot(all_f0);
        set(handles.f0,'String', f0);
        set(handles.f1,'String', f1);
        set(handles.f2,'String', f2);
        set(handles.f3,'String', f3);
    else
            msgbox('Format file yang dimasukan tidak sesuai', '','help');
    end
else
       msgbox('Silahkan pilih file suara terlebih dahulu', '','help');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function emosi_Callback(hObject, eventdata, handles)
% hObject    handle to emosi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of emosi as text
%        str2double(get(hObject,'String')) returns contents of emosi as a double


% --- Executes during object creation, after setting all properties.
function emosi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to emosi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f0_Callback(hObject, eventdata, handles)
% hObject    handle to f0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f0 as text
%        str2double(get(hObject,'String')) returns contents of f0 as a double


% --- Executes during object creation, after setting all properties.
function f0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f1_Callback(hObject, eventdata, handles)
% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f1 as text
%        str2double(get(hObject,'String')) returns contents of f1 as a double


% --- Executes during object creation, after setting all properties.
function f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f2_Callback(hObject, eventdata, handles)
% hObject    handle to f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f2 as text
%        str2double(get(hObject,'String')) returns contents of f2 as a double


% --- Executes during object creation, after setting all properties.
function f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f3_Callback(hObject, eventdata, handles)
% hObject    handle to f3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f3 as text
%        str2double(get(hObject,'String')) returns contents of f3 as a double


% --- Executes during object creation, after setting all properties.
function f3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Keluar_Callback(hObject, eventdata, handles)
selection = questdlg('Apakah Anda Ingin Keluar?',...
      '',...
      'Ya','Tidak','Ya'); 
   switch selection, 
      case 'Ya',
         delete(gcf)
      case 'Tidak'
      return 
   end
   set(0,'DefaultFigureCloseRequestFcn',@myclose_callback)



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to direktori (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of direktori as text
%        str2double(get(hObject,'String')) returns contents of direktori as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to direktori (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pilih.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pilih (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ekstraksi.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to ekstraksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in main.
function main_Callback(hObject, eventdata, handles)
global player    
direktori=get(handles.direktori,'String');    
[~, ~, extension] = fileparts(direktori);
if exist(direktori)
    if (extension=='.wav')
        [y, fs]=wavread(direktori);
        player = audioplayer(y,fs);
        play(player);
    else
         msgbox('Format file yang dimasukan tidak sesuai', '','help');
    end
else
      msgbox('Silahkan pilih file suara terlebih dahulu', '','help');
end

% --- Executes on button press in berhenti.
function berhenti_Callback(hObject, eventdata, handles)
global player    
stop(player);

function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to f0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f0 as text
%        str2double(get(hObject,'String')) returns contents of f0 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f1 as text
%        str2double(get(hObject,'String')) returns contents of f1 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f2 as text
%        str2double(get(hObject,'String')) returns contents of f2 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to f3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f3 as text
%        str2double(get(hObject,'String')) returns contents of f3 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global svmpria svmwanita pitchpria stdformantpria grouppria pitchwanita stdformantwanita groupwanita
option = get(handles.popupmenu1, 'Value');
if (option==1)
    if isempty(svmpria)
        msgbox('Belum ada model klasifikasi', '','help');
    else
        axes(handles.axes1);
        svmtrain([pitchpria stdformantpria],grouppria,'Kernel_Function','rbf','showplot','true');
    end
elseif(option==2)
    if isempty(svmwanita)
        msgbox('Belum ada model klasifikasi', '','help');
    else
        axes(handles.axes1);
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


% --- Executes on button press in prediksi.
function prediksi_Callback(hObject, eventdata, handles)
global svmpria svmwanita pitchpria stdformantpria grouppria pitchwanita stdformantwanita groupwanita
a=str2double(get(handles.f0,'String'));
b=str2double(get(handles.f1,'String'));
c=str2double(get(handles.f2,'String'));
d=str2double(get(handles.f3,'String'));
if isempty(a)
    msgbox('Silahkan lakukan ekstraksi fitur terlebih dahulu')
else
    option = get(handles.popupmenu1, 'Value');
    sdF = round(std([b c d]')');
    if (option==1)
        if isempty(svmpria)
            msgbox('Belum ada model klasifikasi', '','help');
        else
            axes(handles.axes1);
            svmpria=svmtrain([pitchpria stdformantpria],grouppria,'Kernel_Function','rbf','showplot',true);
            prediksi_group = svmclassify(svmpria,[a sdF],'showplot',true);
            hold on;
            plot(a,sdF,'ro','MarkerSize',20);
            hold off
            if prediksi_group==0
                emosi='Normal';
                axes(handles.emoticon);
                imshow('normal.png');
            else
                emosi='Marah';
                axes(handles.emoticon);
                imshow('marah.png');
            end
            set(handles.emosi,'String',emosi);
        end
    elseif(option==2)
        if isempty(svmwanita)
            msgbox('Belum ada model klasifikasi', '','help');
        else
            axes(handles.axes1);
            svmwanita=svmtrain([pitchwanita stdformantwanita],groupwanita,'Kernel_Function','rbf','showplot','true');
            prediksi_group = svmclassify(svmwanita,[a sdF],'showplot',true);
            hold on;
            plot(a,sdF,'ro','MarkerSize',20);
            hold off
            if prediksi_group==0
                emosi='Normal';
                axes(handles.emoticon);
                imshow('normal.png');
            else
                emosi='Marah';
                axes(handles.emoticon);
                imshow('marah.png');
            end
            set(handles.emosi,'String',emosi);
        end
    end
end

function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to emosi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of emosi as text
%        str2double(get(hObject,'String')) returns contents of emosi as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to emosi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenutrack.
function popupmenutrack_Callback(hObject, eventdata, handles)
global all_f0 all_f1 all_f2 all_f3

direktori=get(handles.direktori,'String');    
[~, ~, extension] = fileparts(direktori);
if exist(direktori)
    if (extension=='.wav')
        option = get(handles.popupmenutrack, 'Value');
        if (option==1)
            if isempty(all_f0)
                msgbox('Silahkan lakukan ekstraksi fitur terlebih dahulu', '','help');
            else
                axes(handles.ftrack);
                plot(all_f0);
            end
        elseif(option==2)
            if isempty(all_f1)
                msgbox('Silahkan lakukan ekstraksi fitur terlebih dahulu', '','help');
            else
                axes(handles.ftrack);
                plot(all_f1);
            end
        elseif(option==3)
            if isempty(all_f2)
                msgbox('Silahkan lakukan ekstraksi fitur terlebih dahulu', '','help');
            else
                axes(handles.ftrack);
                plot(all_f2);
            end
        elseif(option==4)
            if isempty(all_f3)
                msgbox('Silahkan lakukan ekstraksi fitur terlebih dahulu', '','help');
            else
                axes(handles.ftrack);
                plot(all_f3);
            end
        end
    else
         msgbox('Format file yang dimasukan tidak sesuai', '','help');
    end
else
      msgbox('Silahkan pilih file suara terlebih dahulu', '','help');
end

% --- Executes during object creation, after setting all properties.
function popupmenutrack_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenutrack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)


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
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
set(index,'Visible','on');
set(handles.output,'Visible','off');
