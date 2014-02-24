function varargout = VentanaConfiguracion(varargin)
% VENTANACONFIGURACION MATLAB code for VentanaConfiguracion.fig
%      VENTANACONFIGURACION, by itself, creates a new VENTANACONFIGURACION or raises the existing
%      singleton*.
%
%      H = VENTANACONFIGURACION returns the handle to a new VENTANACONFIGURACION or the handle to
%      the existing singleton*.
%
%      VENTANACONFIGURACION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VENTANACONFIGURACION.M with the given input arguments.
%
%      VENTANACONFIGURACION('Property','Value',...) creates a new VENTANACONFIGURACION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VentanaConfiguracion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VentanaConfiguracion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VentanaConfiguracion

% Last Modified by GUIDE v2.5 03-Feb-2014 20:57:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VentanaConfiguracion_OpeningFcn, ...
                   'gui_OutputFcn',  @VentanaConfiguracion_OutputFcn, ...
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


% --- Executes just before VentanaConfiguracion is made visible.
function VentanaConfiguracion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VentanaConfiguracion (see VARARGIN)

% Choose default command line output for VentanaConfiguracion
handles.output = hObject;

load QRConf.mat;

set(handles.editOHTC,'String',num2str(TipoCambio.DiasHab));
set(handles.editEETC,'String',num2str(TipoCambio.DevAnual));
if TipoCambio.TipoEsp==0
    set(handles.radiobuttonOHTC,'Value',1);
    set(handles.radiobuttonEETC,'Value',0);
    set(handles.editOHTC,'Enable','on');
    set(handles.editEETC,'Enable','off');
else
    set(handles.radiobuttonOHTC,'Value',0);
    set(handles.radiobuttonEETC,'Value',1);
    set(handles.editOHTC,'Enable','off');
    set(handles.editEETC,'Enable','on');
end

%TB

set(handles.editOHTB,'String',num2str(TasaBasica.DiasHab));
set(handles.editEETB,'String',num2str(TasaBasica.TasaProm));
if TasaBasica.TipoEsp==0
    set(handles.radiobuttonOHTB,'Value',1);
    set(handles.radiobuttonEETB,'Value',0);
    set(handles.editOHTB,'Enable','on');
    set(handles.editEETB,'Enable','off');
else
    set(handles.radiobuttonOHTB,'Value',0);
    set(handles.radiobuttonEETB,'Value',1);
    set(handles.editOHTB,'Enable','off');
    set(handles.editEETB,'Enable','on');
end

%TL

set(handles.editOHTL,'String',num2str(TasaLibor.DiasHab));
set(handles.editEETL,'String',num2str(TasaLibor.TasaProm));
if TasaLibor.TipoEsp==0
    set(handles.radiobuttonOHTL,'Value',1);
    set(handles.radiobuttonEETL,'Value',0);
    set(handles.editOHTL,'Enable','on');
    set(handles.editEETL,'Enable','off');
else
    set(handles.radiobuttonOHTL,'Value',0);
    set(handles.radiobuttonEETL,'Value',1);
    set(handles.editOHTL,'Enable','off');
    set(handles.editEETL,'Enable','on');
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VentanaConfiguracion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VentanaConfiguracion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobuttonObsHistTC.
function radiobuttonObsHistTC_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonObsHistTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonObsHistTC


% --- Executes on button press in radiobuttonEspecEscTC.
function radiobuttonEspecEscTC_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonEspecEscTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonEspecEscTC
set(editDevalAnualTC,'Enable','on');
set(editObsHistTC,'Enable','off');




function editDevalAnualTC_Callback(hObject, eventdata, handles)
% hObject    handle to editDevalAnualTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDevalAnualTC as text
%        str2double(get(hObject,'String')) returns contents of editDevalAnualTC as a double


% --- Executes during object creation, after setting all properties.
function editDevalAnualTC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDevalAnualTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDiasHabilesTL_Callback(hObject, eventdata, handles)
% hObject    handle to editDiasHabilesTL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDiasHabilesTL as text
%        str2double(get(hObject,'String')) returns contents of editDiasHabilesTL as a double


% --- Executes during object creation, after setting all properties.
function editDiasHabilesTL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDiasHabilesTL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDiasHabilesTB_Callback(hObject, eventdata, handles)
% hObject    handle to editDiasHabilesTB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDiasHabilesTB as text
%        str2double(get(hObject,'String')) returns contents of editDiasHabilesTB as a double


% --- Executes during object creation, after setting all properties.
function editDiasHabilesTB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDiasHabilesTB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editTasaPromedioTB_Callback(hObject, eventdata, handles)
% hObject    handle to editTasaPromedioTB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTasaPromedioTB as text
%        str2double(get(hObject,'String')) returns contents of editTasaPromedioTB as a double


% --- Executes during object creation, after setting all properties.
function editTasaPromedioTB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTasaPromedioTB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobuttonOHTL.
function radiobuttonOHTL_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonOHTL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonOHTL
valor = get(handles.radiobuttonOHTL,'Value');
if valor==1
    set(handles.radiobuttonEETL,'Value',0);
    set(handles.editOHTL,'Enable','on');
    set(handles.editEETL,'Enable','off');
else
    set(handles.radiobuttonEETL,'Value',1);
    set(handles.editOHTL,'Enable','off');
    set(handles.editEETL,'Enable','on');
end

% --- Executes on button press in radiobuttonEETL.
function radiobuttonEETL_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonEETL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonEETL
valor = get(handles.radiobuttonEETL,'Value');
if valor==1
    set(handles.radiobuttonOHTL,'Value',0);
    set(handles.editOHTL,'Enable','off');
    set(handles.editEETL,'Enable','on');
else
    set(handles.radiobuttonOHTL,'Value',1);
    set(handles.editOHTL,'Enable','on');
    set(handles.editEETL,'Enable','off');
end


function editEETL_Callback(hObject, eventdata, handles)
% hObject    handle to editEETL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEETL as text
%        str2double(get(hObject,'String')) returns contents of editEETL as a double


% --- Executes during object creation, after setting all properties.
function editEETL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEETL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOHTL_Callback(hObject, eventdata, handles)
% hObject    handle to editOHTL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOHTL as text
%        str2double(get(hObject,'String')) returns contents of editOHTL as a double


% --- Executes during object creation, after setting all properties.
function editOHTL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOHTL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobuttonOHTC.
function radiobuttonOHTC_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonOHTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonOHTC

valor = get(handles.radiobuttonOHTC,'Value');
if valor==1
    set(handles.radiobuttonEETC,'Value',0);
    set(handles.editOHTC,'Enable','on');
    set(handles.editEETC,'Enable','off');
else
    set(handles.radiobuttonEETC,'Value',1);
    set(handles.editOHTC,'Enable','off');
    set(handles.editEETC,'Enable','on');
end


% --- Executes on button press in radiobuttonEETC.
function radiobuttonEETC_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonEETC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonEETC
valor = get(handles.radiobuttonEETC,'Value');
if valor==1
    set(handles.radiobuttonOHTC,'Value',0);
    set(handles.editOHTC,'Enable','off');
    set(handles.editEETC,'Enable','on');
else
    set(handles.radiobuttonOHTC,'Value',1);
    set(handles.editOHTC,'Enable','on');
    set(handles.editEETC,'Enable','off');
end


% --- Executes on button press in radiobuttonEETB.
function radiobuttonEETB_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonEETB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonEETB
valor = get(handles.radiobuttonEETB,'Value');
if valor==1
    set(handles.radiobuttonOHTB,'Value',0);
    set(handles.editOHTB,'Enable','off');
    set(handles.editEETB,'Enable','on');
else
    set(handles.radiobuttonOHTB,'Value',1);
    set(handles.editOHTB,'Enable','on');
    set(handles.editEETB,'Enable','off');
end


% --- Executes on button press in radiobuttonOHTB.
function radiobuttonOHTB_Callback(hObject, eventdata, handles)
% hObject    handle to radiobuttonOHTB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobuttonOHTB

valor = get(handles.radiobuttonOHTB,'Value');
if valor==1
    set(handles.radiobuttonEETB,'Value',0);
    set(handles.editOHTB,'Enable','on');
    set(handles.editEETB,'Enable','off');
else
    set(handles.radiobuttonEETB,'Value',1);
    set(handles.editOHTB,'Enable','off');
    set(handles.editEETB,'Enable','on');
end



function editOHTB_Callback(hObject, eventdata, handles)
% hObject    handle to editOHTB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOHTB as text
%        str2double(get(hObject,'String')) returns contents of editOHTB as a double


% --- Executes during object creation, after setting all properties.
function editOHTB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOHTB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEETB_Callback(hObject, eventdata, handles)
% hObject    handle to editEETB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEETB as text
%        str2double(get(hObject,'String')) returns contents of editEETB as a double


% --- Executes during object creation, after setting all properties.
function editEETB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEETB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEETC_Callback(hObject, eventdata, handles)
% hObject    handle to editEETC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEETC as text
%        str2double(get(hObject,'String')) returns contents of editEETC as a double


% --- Executes during object creation, after setting all properties.
function editEETC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEETC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editOHTC_Callback(hObject, eventdata, handles)
% hObject    handle to editOHTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editOHTC as text
%        str2double(get(hObject,'String')) returns contents of editOHTC as a double


% --- Executes during object creation, after setting all properties.
function editOHTC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editOHTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonGuardar.
function pushbuttonGuardar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonGuardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%TC
TipoCambio.TipoEsp=get(handles.radiobuttonEETC,'Value');
if length(str2num(get(handles.editOHTC,'String')))==1
    TipoCambio.DiasHab=str2double(get(handles.editOHTC,'String'));
else
    h = errordlg('Observaciones históricas de Tipo de Cambio incorrectas','Error');
    return
end
if length(str2num(get(handles.editEETC,'String')))==1
    TipoCambio.DevAnual=str2double(get(handles.editEETC,'String'));
else
    h = errordlg('Escenario de Tipo de Cambio incorrecto','Error');
    return
end

%TB
TasaBasica.TipoEsp=get(handles.radiobuttonEETB,'Value');
if length(str2num(get(handles.editOHTB,'String')))==1
    TasaBasica.DiasHab=str2double(get(handles.editOHTB,'String'));
else
    h = errordlg('Observaciones Históricas de Tasa Básica Pasiva incorrectas','Error');
    return
end
if length(str2num(get(handles.editEETB,'String')))==1
    TasaBasica.TasaProm=str2double(get(handles.editEETB,'String'));
else
    h = errordlg('Escenario de Tasa Básica Pasiva incorrecto','Error');
    return
end


%TL
TasaLibor.TipoEsp=get(handles.radiobuttonEETL,'Value');
if length(str2num(get(handles.editOHTL,'String')))==1
    TasaLibor.DiasHab=str2double(get(handles.editOHTL,'String'));
else
    h = errordlg('Observaciones Históricas de Tasa Libor incorrectas','Error');
    return
    
end
if length(str2num(get(handles.editEETL,'String')))==1
    TasaLibor.TasaProm=str2double(get(handles.editEETL,'String'));
else
    h = errordlg('Escenario de Tasa Libor incorrecto','Error');
    return
end

%TODO Hay que corregir que detecte cuando aparece una coma sin ningún
%dígito a la derecha.
save QRConf.mat TipoCambio TasaBasica TasaLibor;


% --- Executes on button press in pushbuttonCancelar.
function pushbuttonCancelar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonCancelar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1)
