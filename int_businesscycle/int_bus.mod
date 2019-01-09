// endogenous variables
var c_1 c_2 A_1 A_2 k_1 k_2;

//exogen
varexo epsilon_1 epsilon_2;

//params
parameters cbeta cdelta calpha crho cgamma;

load params;
load ss_vars;


cbeta = params(1);
cdelta = params(2);
calpha = params(3);
crho = params(4);
cgamma = params(5);

// model block
model;
c_1 = c_2;
c_1^(-cgamma) = cbeta * c_1(+1)^(-cgamma) * (calpha * A_1(+1) * k_1^(calpha - 1) + 1 - cdelta);
c_2^(-cgamma) = cbeta * c_2(+1)^(-cgamma) * (calpha * A_2(+1) * k_2^(calpha - 1) + 1 - cdelta);
A_1 * k_1(-1)^calpha + A_2 * k_2(-1)^calpha = c_1 + c_2 + k_1 - (1 - cdelta)*k_1(-1) + k_2 - (1 - cdelta)*k_2(-1);
log(A_1) = crho * log(A_1(-1)) + epsilon_1;
log(A_2) = crho * log(A_2(-1)) + epsilon_2;
end;

//init values
initval;
c_1=vars_ss(1);
c_2=vars_ss(2);
A_1=vars_ss(3);
A_2=vars_ss(4);
k_1=vars_ss(5);
k_2=vars_ss(6);
epsilon_1=0;
epsilon_2=0;
end;

shocks;
var epsilon_1;
stderr .08;
var epsilon_2;
stderr .08;
end;

steady;

stoch_simul(periods=1000);
