function arreglo_cell = AgregaCells(varargin)

% Agrega una lista de cells en forma vertical
% varargin es la variable estándar de matlab y que debe ser un arreglo cell cuyas entradas son los arreglos cell a
% agregar.
% arreglo_cell es el arreglo agregado

arreglo_cell = varargin{1};
for iArg = 2:nargin
    arreglo_cell = AgregaCellAbajo(arreglo_cell,varargin{iArg});
    arreglo_cell = AgregaCellAbajo(arreglo_cell,{''});
end
