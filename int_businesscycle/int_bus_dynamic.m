function [residual, g1, g2, g3] = int_bus_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(6, 1);
T17 = params(1)*y(11)^(-params(5));
T23 = y(9)^(params(3)-1);
T27 = 1+params(3)*y(13)*T23-params(2);
T33 = params(1)*y(12)^(-params(5));
T37 = y(10)^(params(3)-1);
T40 = 1+params(3)*y(14)*T37-params(2);
T45 = y(3)^params(3);
T49 = y(4)^params(3);
lhs =y(5);
rhs =y(6);
residual(1)= lhs-rhs;
lhs =y(5)^(-params(5));
rhs =T17*T27;
residual(2)= lhs-rhs;
lhs =y(6)^(-params(5));
rhs =T33*T40;
residual(3)= lhs-rhs;
lhs =y(7)*T45+y(8)*T49;
rhs =y(10)+y(9)+y(5)+y(6)-y(3)*(1-params(2))-y(4)*(1-params(2));
residual(4)= lhs-rhs;
lhs =log(y(7));
rhs =params(4)*log(y(1))+x(it_, 1);
residual(5)= lhs-rhs;
lhs =log(y(8));
rhs =params(4)*log(y(2))+x(it_, 2);
residual(6)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(6, 16);

  %
  % Jacobian matrix
  %

T78 = params(1)*getPowerDeriv(y(11),(-params(5)),1);
T83 = params(1)*getPowerDeriv(y(12),(-params(5)),1);
T100 = getPowerDeriv(y(3),params(3),1);
T104 = getPowerDeriv(y(9),params(3)-1,1);
T105 = params(3)*y(13)*T104;
T108 = getPowerDeriv(y(4),params(3),1);
T111 = getPowerDeriv(y(10),params(3)-1,1);
T112 = params(3)*y(14)*T111;
  g1(1,5)=1;
  g1(1,6)=(-1);
  g1(2,5)=getPowerDeriv(y(5),(-params(5)),1);
  g1(2,11)=(-(T27*T78));
  g1(2,13)=(-(T17*params(3)*T23));
  g1(2,9)=(-(T17*T105));
  g1(3,6)=getPowerDeriv(y(6),(-params(5)),1);
  g1(3,12)=(-(T40*T83));
  g1(3,14)=(-(T33*params(3)*T37));
  g1(3,10)=(-(T33*T112));
  g1(4,5)=(-1);
  g1(4,6)=(-1);
  g1(4,7)=T45;
  g1(4,8)=T49;
  g1(4,3)=y(7)*T100-(-(1-params(2)));
  g1(4,9)=(-1);
  g1(4,4)=y(8)*T108-(-(1-params(2)));
  g1(4,10)=(-1);
  g1(5,1)=(-(params(4)*1/y(1)));
  g1(5,7)=1/y(7);
  g1(5,15)=(-1);
  g1(6,2)=(-(params(4)*1/y(2)));
  g1(6,8)=1/y(8);
  g1(6,16)=(-1);

if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(28,3);
  v2(1,1)=2;
  v2(1,2)=69;
  v2(1,3)=getPowerDeriv(y(5),(-params(5)),2);
  v2(2,1)=2;
  v2(2,2)=171;
  v2(2,3)=(-(T27*params(1)*getPowerDeriv(y(11),(-params(5)),2)));
  v2(3,1)=2;
  v2(3,2)=203;
  v2(3,3)=(-(T78*params(3)*T23));
  v2(4,1)=2;
  v2(4,2)=173;
  v2(4,3)=  v2(3,3);
  v2(5,1)=2;
  v2(5,2)=139;
  v2(5,3)=(-(T78*T105));
  v2(6,1)=2;
  v2(6,2)=169;
  v2(6,3)=  v2(5,3);
  v2(7,1)=2;
  v2(7,2)=141;
  v2(7,3)=(-(T17*params(3)*T104));
  v2(8,1)=2;
  v2(8,2)=201;
  v2(8,3)=  v2(7,3);
  v2(9,1)=2;
  v2(9,2)=137;
  v2(9,3)=(-(T17*params(3)*y(13)*getPowerDeriv(y(9),params(3)-1,2)));
  v2(10,1)=3;
  v2(10,2)=86;
  v2(10,3)=getPowerDeriv(y(6),(-params(5)),2);
  v2(11,1)=3;
  v2(11,2)=188;
  v2(11,3)=(-(T40*params(1)*getPowerDeriv(y(12),(-params(5)),2)));
  v2(12,1)=3;
  v2(12,2)=220;
  v2(12,3)=(-(T83*params(3)*T37));
  v2(13,1)=3;
  v2(13,2)=190;
  v2(13,3)=  v2(12,3);
  v2(14,1)=3;
  v2(14,2)=156;
  v2(14,3)=(-(T83*T112));
  v2(15,1)=3;
  v2(15,2)=186;
  v2(15,3)=  v2(14,3);
  v2(16,1)=3;
  v2(16,2)=158;
  v2(16,3)=(-(T33*params(3)*T111));
  v2(17,1)=3;
  v2(17,2)=218;
  v2(17,3)=  v2(16,3);
  v2(18,1)=3;
  v2(18,2)=154;
  v2(18,3)=(-(T33*params(3)*y(14)*getPowerDeriv(y(10),params(3)-1,2)));
  v2(19,1)=4;
  v2(19,2)=39;
  v2(19,3)=T100;
  v2(20,1)=4;
  v2(20,2)=99;
  v2(20,3)=  v2(19,3);
  v2(21,1)=4;
  v2(21,2)=35;
  v2(21,3)=y(7)*getPowerDeriv(y(3),params(3),2);
  v2(22,1)=4;
  v2(22,2)=56;
  v2(22,3)=T108;
  v2(23,1)=4;
  v2(23,2)=116;
  v2(23,3)=  v2(22,3);
  v2(24,1)=4;
  v2(24,2)=52;
  v2(24,3)=y(8)*getPowerDeriv(y(4),params(3),2);
  v2(25,1)=5;
  v2(25,2)=1;
  v2(25,3)=(-(params(4)*(-1)/(y(1)*y(1))));
  v2(26,1)=5;
  v2(26,2)=103;
  v2(26,3)=(-1)/(y(7)*y(7));
  v2(27,1)=6;
  v2(27,2)=18;
  v2(27,3)=(-(params(4)*(-1)/(y(2)*y(2))));
  v2(28,1)=6;
  v2(28,2)=120;
  v2(28,3)=(-1)/(y(8)*y(8));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),6,256);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],6,4096);
end
end
end
end
