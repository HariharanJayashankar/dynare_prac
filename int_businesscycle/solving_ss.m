vars0 = [1, 1, 1, 1, 1, 1];

cbeta = 0.98;
cdelta = 0.05;
calpha = 0.4;
crho = 0.85;
cgamma = 2;

params = [cbeta, cdelta, calpha, crho, cgamma];

save('params.mat', 'params')

f = @steadyS;
[vars_ss, fval, exitflag] = fsolve(f, vars0);

save('ss_vars.mat', 'vars_ss')
