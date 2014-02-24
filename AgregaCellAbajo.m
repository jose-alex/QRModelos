function nuevo = AgregaCellAbajo(anterior,extra)

% Concatena verticalmente dos variables cell que podrían tener números de
% columnas distintos. Agrega vacíos para hacer calzar las dimensiones.

[iNRows0,iNCols0]=size(anterior);
[iNRows1,iNCols1]=size(extra);

if iNCols0<iNCols1
    nuevo = [anterior cell(iNRows0,iNCols1-iNCols0);extra];
elseif iNCols0>iNCols1
    nuevo = [anterior; extra cell(iNRows1,iNCols0-iNCols1)];
else
    nuevo = [anterior;extra];
end
    


