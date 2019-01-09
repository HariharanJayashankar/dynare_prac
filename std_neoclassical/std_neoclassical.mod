// preamble

var c l k z;
varexo cepsilon;

parameters cbeta ctheta ctau calpha cdelta crho cs;

cbeta = 0.987;
ctheta = 0.357;
cdelta = 0.012;
calpha = 0.4;
ctau = 2;
crho = 0.95;
cs = 0.007;


// model

model;
  (c^ctheta * (1 - l)^(1 - ctheta))^(1 - ctau)/c = cbeta * (((c(+1)^ctheta * (1 - l(+1))^(1 - ctheta))^(1 - ctau))/c(+1))*(1 + calpha * exp(z(-1)) * k^(calpha - 1) * l ^ calpha - cdelta);
  ((1 - ctheta)/ctheta) * (c/(1 - l)) = (1 - calpha) * exp(z(-1)) * k^calpha * l^(-calpha);
  k = exp(z(-1)) * k(-1)^calpha * l^(1 - calpha) - c + (1 - cdelta) * k(-1);
  z = crho * z(-1) + cs*cepsilon;
end;

initval;
k = 1;
c = 1;
l = 0.3;
z = 0;
cepsilon = 0;
end;

shocks;
var cepsilon;
stderr 1;
end;

steady;
check;
stoch_simul(periods = 1000);
dynasave(simudata);
