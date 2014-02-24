function reporte = Basica(tasa_basica,conf_sim)

% Crea el reporte de la corrida del modelo de tasa libor
%
%
% reporte : Estructura con dos campos: valor, emisor

global numero_escenarios fmPerc2d

load QRConf TasaBasica

modelo = ModelaTasasSaltos(tasa_basica,conf_sim,TasaBasica);

reporte.proy = {'Valor proyectado medio :',modelo.proyeccion};
reporte.NumberFormat.proy = {'',fmPerc2d};

% Reporte de escenarios

iNEsc = length(modelo.percentiles);
reporte.escenarios = cell(iNEsc+3,2);
reporte.NumberFormat.escenarios = cell(iNEsc+3,2);
reporte.escenarios(1:3,:) = {'Escenarios de tasa Básica máxima','';'','';'Nivel conf.','Tasa básica máxima'};
reporte.escenarios(4:end,:) = num2cell([modelo.percentiles, modelo.escenarios]);
reporte.NumberFormat.escenarios(4:end,:) = repmat({'' ,fmPerc2d},iNEsc,1);

reporte.coef = cell(7,2);
reporte.NumberFormat.coef = cell(7,2);
reporte.coef(1:3,:) = {'Coeficientes del modelo Vasicek y frecuencia','';'','';'Nombre','Valor'};
reporte.coef(4,:) = {'Alfa',modelo.alpha};
reporte.coef(5,:) = {'Media',modelo.b};
reporte.coef(6,:) = {'Sigma',modelo.sigma};
reporte.coef(7,:) = {'Lambda',modelo.lambda};

reporte.distr = cell(numero_escenarios+3,2);
reporte.NumberFormat.distr = cell(7,2);
reporte.distr(1:3,:) = {'Escenarios simulados de tasa Básica','';'','';'Final','Máximo'};
reporte.distr(4:end,:) = num2cell([modelo.distrfin', modelo.distrmax']);

