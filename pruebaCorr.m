load datos

[f1,ia,ib] = intersect(hist.tasabasica.fechas,hist.libor.fechas);

tb1 = hist.tasabasica.data(ia);
lb1 = hist.libor.data(ib);

[f2,ia,ib] = intersect(hist.tipocolondolar.fechas,f1);

tc = hist.tipocolondolar.data(ia);
tb = tb1(ib);
lb = lb1(ib);

data = [tb lb tc];
dif_data = [data(2:end,1:2)-data(1:end-1,1:2) data(2:end,3)./data(1:end-1,3)-1]; 

mat_cov = cov(dif_data(end-750:end,:))

montos = [35558498800 1028131110];
dur = [ 1.27  3.77 ];
w = [-dur(1)*montos(1) -dur(2)*montos(2) montos(2)];

zq = norminv(.99,0,1);
var1 = zq*sqrt(20*w(1)*mat_cov(1,1)*w(1))/montos(1)
var2 = zq*sqrt(20*w(2)*mat_cov(2,2)*w(2))/montos(2)
var = zq*sqrt(20*w*mat_cov*w')/sum(montos)
