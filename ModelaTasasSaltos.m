function modelo = ModelaTasasSaltos(tasas,conf_sim,conf_par)

% Modela tasas de inter�s para series que tienen saltos (tal como tasa b�sica) 
% usando un modelo de Vasicek y lo
% simula para encontrar percentiles de distribuciones futuras
%
% tasas : Estructura con la informaci�n de tasas
% 
% reporte : Estructura con el modelo y los resultados al plazo y niveles de
% confianza determinados

numero_obs = conf_par.DiasHab;

dDatosTasas = tasas.data(end-numero_obs:end);
fFechas = tasas.fechas(end-numero_obs:end);
dCambiosTasa = dDatosTasas(2:end)-dDatosTasas(1:end-1);
ixCambios = (dCambiosTasa~=0);

% N�mero medio de cambios por observacion
frecuencia = sum(ixCambios)/numero_obs;

tasas_solo_cambios.data = dDatosTasas([false;ixCambios]);
tasas_solo_cambios.fechas = fFechas([false;ixCambios]);

conf_sim_solo_cambios.horizonte = ceil(conf_sim.horizonte*frecuencia); % Se usan menos d�as porque son solo los de cambios
conf_sim_solo_cambios.percentiles = conf_sim.percentiles;

% Nueva configuraci�n de parametrizaci�n
conf_par_solo_cambios.TipoEsp = conf_par.TipoEsp;
conf_par_solo_cambios.DiasHab = ceil(conf_par.DiasHab*frecuencia); % Se usan menos d�as porque son solo los de cambios
conf_par_solo_cambios.TasaProm = conf_par.TasaProm;

% Llama a la funci�n que modela y simula, pero con nuevos par�metros
modelo_solo_cambios = ModelaTasasVasicek(tasas_solo_cambios,conf_sim_solo_cambios,conf_par_solo_cambios);

modelo = modelo_solo_cambios;
modelo.lambda = frecuencia;
