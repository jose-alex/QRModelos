function EscribeReporte(reporte,escoge,sNombresArchivos)

% Función que escribe los reportes a excel
%
% reporte : Estructura con los reportes a escribir
% escoge : Estructura con las variables lógicas que indica cuáles reportes
% se escriben
% sNombresArchivos : Cell con los nombres de los archivos asociados a la
% corrida
%
% TODO variable indicadora del resultado de la escritura

global sRutaSalida


% TODO Hay que eliminar contenido previo

hw = waitbar(0,'Escribiendo reporte de modelos...');

sNomSalida = sNombresArchivos{4}; % TODO Pasar el 4 a una configuración
encabezado = {'QR Modelos';''};
encabezado = AgregaCellAbajo(encabezado,{'Fecha de corrida : ',date()});

% Hoja de resultados principales
hoja_principal = encabezado;
formato_principal = cell(3,2);
if escoge.tipocolondolar
    hoja_principal = AgregaCells(hoja_principal,{'Modelo de Tipo de Cambio Colón-Dólar',''},...
        reporte.tipocolondolar.proy,reporte.tipocolondolar.escenarios);
    formato_principal = AgregaCells(formato_principal,cell(1,2),...
        reporte.tipocolondolar.NumberFormat.proy,reporte.tipocolondolar.NumberFormat.escenarios);
    hoja_tipocolondolar = AgregaCells(encabezado,{'Modelo de Tipo de Cambio Colón-Dólar',''},...
        reporte.tipocolondolar.proy,reporte.tipocolondolar.escenarios,...
        reporte.tipocolondolar.coef,reporte.tipocolondolar.distr);
    formato_tipocolondolar = AgregaCells(cell(3,2),cell(1,2),...
        reporte.tipocolondolar.NumberFormat.proy,reporte.tipocolondolar.NumberFormat.escenarios,...
        reporte.tipocolondolar.NumberFormat.coef,reporte.tipocolondolar.NumberFormat.distr);
end
if escoge.libor
    hoja_principal = AgregaCells(hoja_principal,{'Modelo de Tasa Libor',''},...
        reporte.libor.proy,reporte.libor.escenarios);
    formato_principal = AgregaCells(formato_principal,cell(1,2),...
        reporte.libor.NumberFormat.proy,reporte.libor.NumberFormat.escenarios);
    
    hoja_libor = AgregaCells(encabezado,{'Modelo de Tasa Libor',''},reporte.libor.proy,...
        reporte.libor.escenarios,reporte.libor.coef,...
        reporte.libor.distr);
    formato_libor = AgregaCells(cell(3,2),cell(1,2),reporte.libor.NumberFormat.proy,...
        reporte.libor.NumberFormat.escenarios,reporte.libor.NumberFormat.coef,...
        reporte.libor.NumberFormat.distr);
end
if escoge.tasabasica
    hoja_principal = AgregaCells(hoja_principal,{'Modelo de Tasa Básica Pasiva',''},...
        reporte.tasabasica.proy,reporte.tasabasica.escenarios);
    formato_principal = AgregaCells(formato_principal,cell(1,2),...
        reporte.tasabasica.NumberFormat.proy,reporte.tasabasica.NumberFormat.escenarios);

    hoja_tasabasica = AgregaCells(encabezado,{'Modelo de Tasa Libor',''},...
        reporte.tasabasica.proy,reporte.tasabasica.escenarios,...
        reporte.tasabasica.coef,reporte.tasabasica.distr);
    formato_tasabasica = AgregaCells(cell(3,2),cell(1,2),...
        reporte.tasabasica.NumberFormat.proy,reporte.tasabasica.NumberFormat.escenarios,...
        reporte.tasabasica.NumberFormat.coef,reporte.tasabasica.NumberFormat.distr);

end
    
warning off MATLAB:xlswrite:AddSheet

sigue = true;
while sigue
    try
        xlswrite(sNomSalida,hoja_principal,'Principal','A1');
        FormatoExcel(sNomSalida,formato_principal,'Principal');
        sigue = false;
    catch
        h=errordlg('Problema al abrir el archivo de salida','Error','modal');
        uiwait(h);
        [FileName,PathName,~] = uiputfile({'*.xlsx'},...
            'Seleccione el archivo de salida',sRutaSalida);
        if ~isnumeric(FileName)
            sNomSalida = [PathName,FileName];
        else
            close(hw);
            return            
        end
    end

end

waitbar(1/6,hw,'Escribiendo reporte de tipo de cambio...');

if escoge.tipocolondolar
    xlswrite(sNomSalida,hoja_tipocolondolar,'Tipo de cambio' ,'A1');
    FormatoExcel(sNomSalida,formato_tipocolondolar,'Tipo de cambio');
end
waitbar(2/3,hw,'Escribiendo reporte de Libor...');
if escoge.libor
    xlswrite(sNomSalida,hoja_libor,'Libor','A1');
    FormatoExcel(sNomSalida,formato_libor,'Libor');
end
waitbar(5/6,hw,'Escribiendo reporte de Tasa Básica...');
if escoge.libor
    xlswrite(sNomSalida,hoja_tasabasica,'Tasa Básica','A1');
    FormatoExcel(sNomSalida,formato_tasabasica,'Tasa Básica');
end

% Borra hojas vacías y ajusta formato
% DeleteEmptyExcelSheets(sNomSalida);
FormatoHojas(sNomSalida);
close(hw);