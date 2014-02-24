function FormatoExcel(fileName,format,Sheet)


% Check whether the file exists
if ~exist(fileName,'file')
    error([fileName ' does not exist !']);
else
    % Check whether it is an Excel file
    typ = xlsfinfo(fileName);
    if ~strcmp(typ,'Microsoft Excel Spreadsheet')
        error([fileName ' not an Excel sheet !']);
    end
end

% If fileName does not contain a "\" the name of the current path is added
% to fileName. The reason for this is that the full path is requiredwork for
% the command "excelObj.workbooks.Open(fileName)" to work properly.
if isempty(strfind(fileName,'\'))
    fileName = [cd '\' fileName];
end

% Abre el servidor Activex
excelObj = actxserver('Excel.Application');
excelWorkbook = excelObj.workbooks.Open(fileName);
WorkSheets = excelObj.sheets;

TargetSheet = get(WorkSheets,'item',Sheet);
Activate(TargetSheet);

[n,m] = size(format);
for iRow = 1:n
    for iCol = 1:m
        if ~isempty(format{iRow,iCol})
            sRango = [xlscol(iCol),num2str(iRow) ':' xlscol(iCol),num2str(iRow)];
            theCell = TargetSheet.Range(sRango);
            theCell.NumberFormat = format{iRow,iCol};
        end
    end
end


excelObj.EnableSound = true;
excelWorkbook.Save;
excelWorkbook.Close(false);
excelObj.Quit;
delete(excelObj);
return;

