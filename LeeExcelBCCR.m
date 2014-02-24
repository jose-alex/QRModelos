function info = LeeExcelBCCR(num,raw)

% Lee datos de un Excel de la página web del BCCR

[nrows,ncols]=size(num);

alldata = reshape(num,nrows*ncols,1);
anno_inicial = str2double(raw(5,2));

l29Feb = true(nrows*ncols,1);
for iA = 1:ncols
    if (mod(anno_inicial+iA-1,4)~=0) % No es Bisiesto
        l29Feb(60+(iA-1)*366)=false;
    end
end
% Se eliminan los 29 de febrero de los años no bisiestos
alldata = alldata(l29Feb);

% Generación de fechas
% diames_inicial = raw{6,1};
% 
% diames = textscan(diames_inicial,'%d %s');
% 
% meses_bccr = {'Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Set','Oct','Nov','Dic'}; %TODO pasar a archivo de configuración
% iMes = find(strcmpi(diames{2},meses_bccr)); % TODO si no se encuentra el mes

dv = zeros(1,6);
dv(1) = anno_inicial;
dv(2) = 1;%iMes;
dv(3) = 1;%diames{1};
fecha_inicial = datenum(dv);
fecha_final = fecha_inicial+length(alldata)-1;
allfechas = (fecha_inicial:fecha_final)';

% Elimina datos inválidos de fines de semana y feriados
ixDatosValidos = find(~isnan(alldata)&(alldata~=0));
data = alldata(ixDatosValidos);
fechas = allfechas(ixDatosValidos);

info.fechas = fechas;
info.data = data;
