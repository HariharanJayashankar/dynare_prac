function [residual, g1, g2, g3] = int_bus_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations.
%                                          Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g3        [M_.endo_nbr by (M_.endo_nbr)^3] double   Third derivatives matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 6, 1);

%
% Model equations
%

T13 = y(1)^(-params(5));
T21 = y(5)^(params(3)-1);
T25 = 1+params(3)*y(3)*T21-params(2);
T28 = y(2)^(-params(5));
T33 = y(6)^(params(3)-1);
T36 = 1+params(3)*y(4)*T33-params(2);
T39 = y(5)^params(3);
T41 = y(6)^params(3);
lhs =y(1);
rhs =y(2);
residual(1)= lhs-rhs;
lhs =T13;
rhs =T13*params(1)*T25;
residual(2)= lhs-rhs;
lhs =T28;
rhs =params(1)*T28*T36;
residual(3)= lhs-rhs;
lhs =y(3)*T39+y(4)*T41;
rhs =y(6)+y(5)+y(1)+y(2)-y(5)*(1-params(2))-y(6)*(1-params(2));
residual(4)= lhs-rhs;
lhs =log(y(3));
rhs =log(y(3))*params(4)+x(1);
residual(5)= lhs-rhs;
lhs =log(y(4));
rhs =params(4)*log(y(4))+x(2);
residual(6)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(6, 6);

  %
  % Jacobian matrix
  %

T64 = getPowerDeriv(y(1),(-params(5)),1);
T68 = getPowerDeriv(y(2),(-params(5)),1);
  g1(1,1)=1;
  g1(1,2)=(-1);
  g1(2,1)=T64-T25*params(1)*T64;
  g1(2,3)=(-(T13*params(1)*params(3)*T21));
  g1(2,5)=(-(T13*params(1)*params(3)*y(3)*getPowerDeriv(y(5),params(3)-1,1)));
  g1(3,2)=T68-T36*params(1)*T68;
  g1(3,4)=(-(params(1)*T28*params(3)*T33));
  g1(3,6)=(-(params(1)*T28*params(3)*y(4)*getPowerDeriv(y(6),params(3)-1,1)));
  g1(4,1)=(-1);
  g1(4,2)=(-1);
  g1(4,3)=T39;
  g1(4,4)=T41;
  g1(4,5)=y(3)*getPowerDeriv(y(5),params(3),1)-(1-(1-params(2)));
  g1(4,6)=y(4)*getPowerDeriv(y(6),params(3),1)-(1-(1-params(2)));
  g1(5,3)=1/y(3)-params(4)*1/y(3);
  g1(6,4)=1/y(4)-params(4)*1/y(4);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],6,36);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],6,216);
end
end
end
end
