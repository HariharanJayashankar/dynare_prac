function f = steadyS(vars0);

  load params;

  c_1 = vars0(1);
  c_2 = vars0(2);
  A_1 = vars0(3);
  A_2 = vars0(4);
  k_1 = vars0(5);
  k_2=  vars0(6);

  cbeta = params(1);
  cdelta = params(2);
  calpha = params(3);
  crho = params(4);
  cgamma = params(5);

  f = zeros(1, 6);

  f(1) = c_1 - c_2;
  f(2) = c_1^(-cgamma) - cbeta * c_1(+1)^(-cgamma) * (calpha * A_1(+1) * k_1^(calpha - 1) + 1 - cdelta);
  f(3) = c_2^(-cgamma) - cbeta * c_2(+1)^(-cgamma) * (calpha * A_2(+1) * k_2^(calpha - 1) + 1 - cdelta);
  f(4) = A_1 * k_1^calpha + A_2 * k_2^calpha - (c_1 + c_2 + k_1 - (1 - cdelta)*k_1 + k_2 - (1 - cdelta)*k_2);
  f(5) = log(A_1) - crho * log(A_1);
  f(6) = log(A_2) - crho * log(A_2);
