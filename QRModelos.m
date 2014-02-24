

% Configuración

global fecha_base
fecha_base = datenum(2014,1,2); % Fecha base para el cálculo de bandas

% % Número de observaciones a usar en la calibración
% global numero_obs
% numero_obs = 500;

% Número de escenarios a generar
global numero_escenarios
numero_escenarios = 10000;

% banda = m(t-fecha_base)+b
global banda_inferior banda_superior
banda_inferior.b = 500; % Constante 
banda_inferior.m = 0; % Pendiente en días
banda_superior.b = 812.05; % Constante
banda_superior.m = .2; % Pendiente en días

% Margen de error para calibración
global margen_error
margen_error = 1; % TODO revisar

% Formatos para Excel
global fmPerc2d fmSepM
fmPerc2d = '0,00%' ;
fmSepM  = '_(* #.##0,0_);_(* (#.##0,0);_(* ""-""??_);_(@_)';


ventanaQRModelos
