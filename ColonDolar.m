function reporte = ColonDolar(tipocolondolar,conf_sim)

% Crea el reporte de la corrida del modelo de tipo de cambio col�n d�lar
%
%
% reporte : Estructura con dos campos: valor, emisor

global numero_escenarios fmSepM

load QRConf TipoCambio

% Funci�n de modelaci�n y simulaci�n
modelo = ModelaTipoColonDolar(tipocolondolar,conf_sim,TipoCambio);

% Generaci�n de reportes

% Reporte principal
reporte.proy = {'Valor proyectado medio :',modelo.proyeccion};
reporte.NumberFormat.proy = {'',fmSepM};

% Reporte de escenarios
iNEsc = length(modelo.percentiles);
reporte.escenarios = cell(iNEsc+3,2);
reporte.NumberFormat.escenarios = cell(iNEsc+3,2);
reporte.escenarios(1:3,:) = {'Escenarios de tipo de cambio m�ximo','';'','';'Nivel conf.','Tipo de cambio m�ximo'};
reporte.escenarios(4:end,:) = num2cell([modelo.percentiles, modelo.escenarios]);
reporte.NumberFormat.escenarios(4:end,:) = repmat({'' ,fmSepM},iNEsc,1);

reporte.coef = cell(5,2);
reporte.NumberFormat.coef =  cell(5,2);
reporte.coef(1:3,:) = {'Coeficientes del modelo de caminata aleatoria','';'','';'Nombre','Valor'};
reporte.coef(4,:) = {'Mu',modelo.mu};
reporte.coef(5,:) = {'Sigma',modelo.sigma};

reporte.distr = cell(numero_escenarios+3,2);
reporte.NumberFormat.distr = cell(numero_escenarios+3,2);
reporte.distr(1:3,:) = {'Escenarios simulados de tipo de cambio','';'','';'Final','M�ximo'};
reporte.distr(4:end,:) = num2cell([modelo.distrfin', modelo.distrmax']);

