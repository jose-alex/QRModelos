function hist = CargaDatos(sNombresArchivos,escoge)

% Función que lee los archivos excel con los datos históricos
%
% sNombresArchivos : Cell con los nombres de los archivos a leer
% escoge : Estructura con variables lógicas indicando cuáles variables se
% deben leer

% Tasa básica
h = waitbar(0,'Cargando información histórica...');

if escoge.tasabasica
    waitbar(1/10,h,'Cargando tasa básica...');
    
    try
        [num,txt,raw]=xlsread(sNombresArchivos{1});
        % TODO try catch
        
        info = LeeExcelBCCR(num,raw);
        
        %     diasemana = weekday(info.fechas);
        %     lHabiles = not((diasemana==1)|(diasemana==7)); % TODO Faltan otros feriados?
        
        hist.tasabasica.data = info.data/100; % Las tasas vienen en puntos porcentuales
        hist.tasabasica.fechas = info.fechas;
    catch
        h1=errordlg('Error leyendo el archivo de Tasa Básica','Error','modal');
        close(h)
        return
        
    end
end

if escoge.libor
    waitbar(1/3,h,'Cargando Libor...');
    try
        [num,txt,raw]=xlsread(sNombresArchivos{2});
        
        %     validos = ~isnan(num);
        %     data = num(validos);
        %
        %     fechas = datenum(txt(70:end,1),'dd/mm/yyyy'); % TODO parametrizar el 70
        %     fechas = fechas(validos);
        info = LeeExcelBCCR(num,raw);
        
        hist.libor.fechas = info.fechas;
        hist.libor.data = info.data/100;
    catch
        h1=errordlg('Error leyendo el archivo de Tasa Libor','Error','modal');
        close(h)
        return
        
    end
    
    
end

if escoge.tipocolondolar
    waitbar(2/3,h,'Cargando tipo de cambio...');
    try
        [num,txt,raw]=xlsread(sNombresArchivos{3});
        % TODO try catch
        
        info = LeeExcelBCCR(num,raw);
        
        %     diasemana = weekday(info.fechas);
        %     lHabiles = not((diasemana==1)|(diasemana==7)|(info.data==0)); % TODO Faltan otros feriados?
        
        hist.tipocolondolar.data = info.data;
        hist.tipocolondolar.fechas = info.fechas;
    catch
        h1=errordlg('Error leyendo el archivo de Tipo de Cambio','Error','modal');
        close(h)
        return       
    end
    
end
waitbar(1,h,'Finalizando carga de datos...');
close(h)

end