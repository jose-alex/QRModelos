function varargout = ventanaQRModelos(varargin)
% VENTANAQRMODELOS MATLAB code for ventanaQRModelos.fig
%      VENTANAQRMODELOS, by itself, creates a new VENTANAQRMODELOS or raises the existing
%      singleton*.
%
%      H = VENTANAQRMODELOS returns the handle to a new VENTANAQRMODELOS or the handle to
%      the existing singleton*.
%
%      VENTANAQRMODELOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VENTANAQRMODELOS.M with the given input arguments.
%
%      VENTANAQRMODELOS('Property','Value',...) creates a new VENTANAQRMODELOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ventanaQRModelos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ventanaQRModelos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ventanaQRModelos

% Last Modified by GUIDE v2.5 03-Feb-2014 18:04:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ventanaQRModelos_OpeningFcn, ...
    'gui_OutputFcn',  @ventanaQRModelos_OutputFcn, ...
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


% --- Executes just before ventanaQRModelos is made visible.
function ventanaQRModelos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ventanaQRModelos (see VARARGIN)

global percentiles

% Opciones de percentiles
percentiles = [1 2 5 10 20 30 40 50 60 70 80 90 95 98 99 99.5 99.9]';
sPercentiles = {'1%','2%','5%','10%','20%','30%','40%','50%','60%',...
    '70%','80%','90%','95%','98%','99%','99.5%','99.9%'};

% Choose default command line output for ventanaQRModelos
handles.output = hObject;

% Coloca opciones en el listbox
set(handles.listboxNiveles,'String',sPercentiles,'Min',0,'Max',length(sPercentiles),...
    'Value',[]);

% Update handles structure
guidata(hObject, handles);

% Coloca el logo
set(hObject, 'Units', 'pixels');
handles.banner = imread( 'LogoMediano.png'); % Read the image file banner.jpg
info = imfinfo('LogoMediano.png'); % Determine the size of the image file
%position = get(hObject, 'Position');
%set(hObject, 'Position', [position(1:2) info.Width + 100 info.Height + 100]);
axes(handles.axesLogo);
image(handles.banner)
set(handles.axesLogo,'Visible', 'off');

% UIWAIT makes ventanaQRModelos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ventanaQRModelos_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonEjecutar.
function pushbuttonEjecutar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonEjecutar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global percentiles

% Lee la info de los editboxes
sNombresArchivos = {get(handles.editTasaBasica,'String'); get(handles.editLibor,'String'); ...
    get(handles.editTipoCambio,'String');get(handles.editSalida,'String')};

% Lee la info del listbox de percentiles
ixPerc = get(handles.listboxNiveles,'Value');

% Revisa que no sea vacío
if isempty(ixPerc)
    h=errordlg('Debe elegir al menos un nivel de riesgo','Error','modal');
    return
end

% Toma los valores de los percentiles
conf_sim.percentiles = percentiles(ixPerc);

% Lee el horizonte y lo revisa
conf_sim.horizonte = str2double(get(handles.editDias,'String'));
if isnan(conf_sim.horizonte)
    h=errordlg('Debe especificar un horizonte válido','Error','modal');
    return
end    

% TODO verificar los nombres de archivos

% Lee la información del los checkboxes
escoge.tasabasica = ~isempty(sNombresArchivos{1})&~strcmp(sNombresArchivos{1},'');
escoge.libor = ~isempty(sNombresArchivos{2})&~strcmp(sNombresArchivos{2},'');
escoge.tipocolondolar = ~isempty(sNombresArchivos{3})&~strcmp(sNombresArchivos{3},'');

% Carga de datos

datos = CargaDatos(sNombresArchivos,escoge);

if escoge.tipocolondolar
    reporte.tipocolondolar = ColonDolar(datos.tipocolondolar,conf_sim);
end
if escoge.libor
    reporte.libor = Libor(datos.libor,conf_sim);
end
if escoge.tasabasica
    reporte.tasabasica = Basica(datos.tasabasica,conf_sim);
end

% Se escriben los reportes
EscribeReporteModelos(reporte,escoge,sNombresArchivos);

save('QRMod.mat','reporte')
msgbox('Operación completa','QR Modelos','modal');


% --- Executes on button press in pushbuttonSalir.
function pushbuttonSalir_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSalir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.figure1)

function editSalida_Callback(hObject, eventdata, handles)
% hObject    handle to editSalida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editSalida as text
%        str2double(get(hObject,'String')) returns contents of editSalida as a double

% TODO revisar texto ingresado

% --- Executes during object creation, after setting all properties.
function editSalida_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editSalida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonSalida.
function pushbuttonSalida_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonSalida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,~] = uiputfile({'*.xlsx'},'Seleccione el archivo de salida');
if ~isnumeric(FileName)
    sNombreArchivo = [PathName,FileName];
    set(handles.editSalida,'String',sNombreArchivo);
end

function editTasaBasica_Callback(hObject, eventdata, handles)
% hObject    handle to editTasaBasica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTasaBasica as text
%        str2double(get(hObject,'String')) returns contents of editTasaBasica as a double


% --- Executes during object creation, after setting all properties.
function editTasaBasica_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTasaBasica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonTasaBasica.
function pushbuttonTasaBasica_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonTasaBasica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile({'*.xlsx;*.xls;*.xlsb'},'Seleccione el archivo de datos Tasa Básica');
if ~isnumeric(FileName)
    sNombreArchivo = [PathName,FileName];
    set(handles.editTasaBasica,'String',sNombreArchivo);
end

function editLibor_Callback(hObject, eventdata, handles)
% hObject    handle to editLibor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLibor as text
%        str2double(get(hObject,'String')) returns contents of editLibor as a double


% --- Executes during object creation, after setting all properties.
function editLibor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLibor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonLibor.
function pushbuttonLibor_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonLibor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile({'*.xlsx;*.xls;*.xlsb'},'Seleccione el archivo de datos Libor');
if ~isnumeric(FileName)
    sNombreArchivo = [PathName,FileName];
    set(handles.editLibor,'String',sNombreArchivo);
end



% --- Executes during object creation, after setting all properties.
function axesLogo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axesLogo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axesLogo



% --- Executes on button press in pushbuttonTipoCambio.
function pushbuttonTipoCambio_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonTipoCambio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName,FilterIndex] = uigetfile({'*.xlsx;*.xls;*.xlsb'},'Seleccione el archivo de datos tipo de cambio');
if ~isnumeric(FileName)
    sNombreArchivo = [PathName,FileName];
    set(handles.editTipoCambio,'String',sNombreArchivo);
end


function editTipoCambio_Callback(hObject, eventdata, handles)
% hObject    handle to editTipoCambio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editTipoCambio as text
%        str2double(get(hObject,'String')) returns contents of editTipoCambio as a double


% --- Executes during object creation, after setting all properties.
function editTipoCambio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editTipoCambio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in listboxNiveles.
function listboxNiveles_Callback(hObject, eventdata, handles)
% hObject    handle to listboxNiveles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxNiveles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxNiveles


% --- Executes during object creation, after setting all properties.
function listboxNiveles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxNiveles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDias_Callback(hObject, eventdata, handles)
% hObject    handle to editDias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDias as text
%        str2double(get(hObject,'String')) returns contents of editDias as a double


% --- Executes during object creation, after setting all properties.
function editDias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonConfigurar.
function pushbuttonConfigurar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonConfigurar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

VentanaConfiguracion