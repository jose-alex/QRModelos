

% Configuraci�n

global fecha_base
fecha_base = datenum(2014,1,2); % Fecha base para el c�lculo de bandas

% % N�mero de observaciones a usar en la calibraci�n
% global numero_obs
% numero_obs = 500;

% N�mero de escenarios a generar
global numero_escenarios
numero_escenarios = 10000;

% banda = m(t-fecha_base)+b
global banda_inferior banda_superior
banda_inferior.b = 500; % Constante 
banda_inferior.m = 0; % Pendiente en d�as
banda_superior.b = 812.05; % Constante
banda_superior.m = .2; % Pendiente en d�as

% Margen de error para calibraci�n
global margen_error
margen_error = 1; % TODO revisar

% Formatos para Excel
global fmPerc2d fmSepM
fmPerc2d = '0,00%' ;
fmSepM  = '_(* #.##0,0_);_(* (#.##0,0);_(* ""-""??_);_(@_)';


ventanaQRModelos
