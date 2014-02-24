function modelo = ModelaTipoColonDolar(tipocolondolar,conf_sim,conf_par)

% Modela el Tipo de Cambio usando un caminata aleatoria con censura y lo
% simula para encontrar percentiles de distribuciones futuras
%
% tipocolondolar : Estructura con la informaci�n de tipo de cambio
%
% reporte : Estructura con el modelo y los resultados al plazo y niveles de
% confianza determinados


global fecha_base  numero_escenarios
global banda_inferior banda_superior margen_error

iNumObs = min(conf_par.DiasHab,length(tipocolondolar.data));

% Valores de banda
dBandaSup = banda_superior.m*(tipocolondolar.fechas(end-iNumObs+1:end)-fecha_base)...
    +banda_superior.b;
dBandaInf = banda_inferior.m*(tipocolondolar.fechas(end-iNumObs+1:end)-fecha_base)...
    +banda_inferior.b;

% TODO considerar esto
% Se agrega margen para calibrar
% dBandaSupMargen = dBandaSup-margen_error;
dBandaInfMargen = dBandaInf+margen_error;

dFechasSim = fecha_base + (1:conf_sim.horizonte);
dBandaSupFutura = banda_superior.m*(dFechasSim-fecha_base)+banda_superior.b;
dBandaInfFutura = banda_inferior.m*(dFechasSim-fecha_base)+banda_inferior.b;

% Elimina datos por debajo de la banda m�s un margen
dTipoCD = max(tipocolondolar.data(end-iNumObs+1:end),dBandaInfMargen);

% Identifica los censurados como aquellos en la banda
lCensurados = (dTipoCD(2:end) == dBandaInfMargen(2:end));

% Diferencias logar�tmicas
dLogCambiosCD = log(dTipoCD(2:end)./dTipoCD(1:end-1));

% Parametrizaci�n ( se usan negativos porque la funci�n usa censura
% derecha)
prob_dist = fitdist(-dLogCambiosCD,'Normal','Censoring',lCensurados);

if conf_par.TipoEsp == 1
    prob_dist.mu = log(1+conf_par.DevAnual/100)/250;
else
    prob_dist.mu = -prob_dist.mu;
end

% Simulaci�n Montecarlo
dEscLogCambiosCD = random(prob_dist,conf_sim.horizonte,numero_escenarios);

dEscenariosTC = zeros(conf_sim.horizonte+1,numero_escenarios);
dEscenariosTC(1,:) = tipocolondolar.data(end);

for iT = 1:conf_sim.horizonte
    dEscenariosTC(iT+1,:) = min(dBandaSupFutura(iT),max(dBandaInfFutura(iT),...
        dEscenariosTC(iT,:).*exp(dEscLogCambiosCD(iT,:)) ) );
end

% Media de los escenarios
dMediaTC = mean(dEscenariosTC,2);

% Toma el m�ximo durante el periodo
dMaxTC = max(dEscenariosTC);
dMinTC = min(dEscenariosTC);

% Extrae los percentiles de inter�s
dEscenariosConf = prctile(dMaxTC,conf_sim.percentiles);

% Crea la estructura del reporte
modelo.escenarios = dEscenariosConf;
modelo.percentiles = conf_sim.percentiles;
modelo.distrmax = dMaxTC;
modelo.distrfin = dEscenariosTC(end,:);
modelo.mu = mean(prob_dist);
modelo.sigma = std(prob_dist);
modelo.proyeccion = dMediaTC(end);
end