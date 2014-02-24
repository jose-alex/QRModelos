function modelo = ModelaTasasSaltos(tasas,conf_sim,conf_par)

% Modela tasas de interés para series que tienen saltos (tal como tasa básica) 
% usando un modelo de Vasicek y lo
% simula para encontrar percentiles de distribuciones futuras
%
% tasas : Estructura con la información de tasas
% 
% reporte : Estructura con el modelo y los resultados al plazo y niveles de
% confianza determinados

numero_obs = conf_par.DiasHab;

dDatosTasas = tasas.data(end-numero_obs:end);
fFechas = tasas.fechas(end-numero_obs:end);
dCambiosTasa = dDatosTasas(2:end)-dDatosTasas(1:end-1);
ixCambios = (dCambiosTasa~=0);

% Número medio de cambios por observacion
frecuencia = sum(ixCambios)/numero_obs;

tasas_solo_cambios.data = dDatosTasas([false;ixCambios]);
tasas_solo_cambios.fechas = fFechas([false;ixCambios]);

conf_sim_solo_cambios.horizonte = ceil(conf_sim.horizonte*frecuencia); % Se usan menos días porque son solo los de cambios
conf_sim_solo_cambios.percentiles = conf_sim.percentiles;

% Nueva configuración de parametrización
conf_par_solo_cambios.TipoEsp = conf_par.TipoEsp;
conf_par_solo_cambios.DiasHab = ceil(conf_par.DiasHab*frecuencia); % Se usan menos días porque son solo los de cambios
conf_par_solo_cambios.TasaProm = conf_par.TasaProm;

% Llama a la función que modela y simula, pero con nuevos parámetros
modelo_solo_cambios = ModelaTasasVasicek(tasas_solo_cambios,conf_sim_solo_cambios,conf_par_solo_cambios);

modelo = modelo_solo_cambios;
modelo.lambda = frecuencia;
