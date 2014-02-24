function modelo = ModelaTasasVasicek(tasas,conf_sim,conf_par)

% Modela tasas de interés usando un Vasicek y lo
% simula para encontrar percentiles de distribuciones futuras
%
% tasas : Estructura con la información de tasas
% conf_sim : Configuración para la simulación
% conf_par : Configuración para la parametrización
% 
% reporte : Estructura con el modelo y los resultados al plazo y niveles de
% confianza determinados

global fecha_base numero_escenarios

iNumObs = min(conf_par.DiasHab,length(tasas.data));

dFechasSim = fecha_base + (1:conf_sim.horizonte);

% Parametrización ( se usan negativos porque la función usa censura
% derecha)
ds = dataset(tasas.data(end-iNumObs+2:end),tasas.data(end-iNumObs+1:end-1),...
    'VarNames',{'Tasa','TasaLag1'});
mdl = fitlm(ds,'Tasa ~ TasaLag1');

c = max(mdl.Coefficients.Estimate(1),0); % Debe ser positivo TODO avisar de problema
a = max(mdl.Coefficients.Estimate(2),0);

alpha = 1-a;

if conf_par.TipoEsp == 1
    b = conf_par.TasaProm/100;
else
    b = c/alpha;
end
sigma = mdl.RMSE;

dNoise = random('norm',0, 1,conf_sim.horizonte,numero_escenarios);

dEscenarios = zeros(conf_sim.horizonte+1,numero_escenarios);
dEscenarios(1,:) = tasas.data(end);

for iT = 1:conf_sim.horizonte
    dEscenarios(iT+1,:) = b*alpha + a*dEscenarios(iT,:)+sigma*dNoise(iT,:);
end

% Media de los escenarios
dMediaTasa = mean(dEscenarios,2);

% Toma el máximo durante el periodo
dMaxTasa = max(dEscenarios);
dMinTasa = min(dEscenarios);

% Extrae los percentiles de interés
dEscenariosConf = prctile(dMaxTasa,conf_sim.percentiles);

% Crea la estructura del reporte
modelo.escenarios = dEscenariosConf;
modelo.percentiles = conf_sim.percentiles;
modelo.distrmax = dMaxTasa;
modelo.distrfin = dEscenarios(end,:);
modelo.b = b;
modelo.alpha = alpha;
modelo.sigma = sigma;
modelo.proyeccion = dMediaTasa(end);

end