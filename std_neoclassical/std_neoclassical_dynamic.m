function [residual, g1, g2, g3] = std_neoclassical_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(4, 1);
T10 = y(3)^params(2);
T14 = (1-y(4))^(1-params(2));
T15 = T10*T14;
T18 = T15^(1-params(3));
T22 = y(7)^params(2);
T25 = (1-y(8))^(1-params(2));
T26 = T22*T25;
T27 = T26^(1-params(3));
T29 = params(1)*T27/y(7);
T37 = params(4)*exp(y(2))*y(5)^(params(4)-1);
T38 = y(4)^params(4);
T42 = 1+T37*T38-params(5);
T45 = (1-params(2))/params(2);
T51 = exp(y(2))*(1-params(4))*y(5)^params(4);
T53 = y(4)^(-params(4));
T58 = exp(y(2))*y(1)^params(4);
T59 = y(4)^(1-params(4));
lhs =T18/y(3);
rhs =T29*T42;
residual(1)= lhs-rhs;
lhs =T45*y(3)/(1-y(4));
rhs =T51*T53;
residual(2)= lhs-rhs;
lhs =y(5);
rhs =T58*T59-y(3)+y(1)*(1-params(5));
residual(3)= lhs-rhs;
lhs =y(6);
rhs =y(2)*params(6)+params(7)*x(it_, 1);
residual(4)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(4, 9);

  %
  % Jacobian matrix
  %

T74 = getPowerDeriv(y(3),params(2),1);
T75 = T14*T74;
T76 = getPowerDeriv(T15,1-params(3),1);
T77 = T75*T76;
T84 = getPowerDeriv(y(7),params(2),1);
T85 = T25*T84;
T86 = getPowerDeriv(T26,1-params(3),1);
T87 = T85*T86;
T92 = params(1)*(y(7)*T87-T27)/(y(7)*y(7));
T96 = (-(getPowerDeriv(1-y(4),1-params(2),1)));
T97 = T10*T96;
T100 = getPowerDeriv(y(4),params(4),1);
T101 = T37*T100;
T108 = getPowerDeriv(y(4),(-params(4)),1);
T111 = getPowerDeriv(y(4),1-params(4),1);
T115 = (-(getPowerDeriv(1-y(8),1-params(2),1)));
T116 = T22*T115;
T119 = params(1)*T86*T116/y(7);
T123 = exp(y(2))*getPowerDeriv(y(1),params(4),1);
T128 = params(4)*exp(y(2))*getPowerDeriv(y(5),params(4)-1,1);
T129 = T38*T128;
T133 = exp(y(2))*(1-params(4))*getPowerDeriv(y(5),params(4),1);
  g1(1,3)=(y(3)*T77-T18)/(y(3)*y(3));
  g1(1,7)=(-(T42*T92));
  g1(1,4)=T76*T97/y(3)-T29*T101;
  g1(1,8)=(-(T42*T119));
  g1(1,5)=(-(T29*T129));
  g1(1,2)=(-(T29*T37*T38));
  g1(2,3)=T45*1/(1-y(4));
  g1(2,4)=T45*y(3)/((1-y(4))*(1-y(4)))-T51*T108;
  g1(2,5)=(-(T53*T133));
  g1(2,2)=(-(T51*T53));
  g1(3,3)=1;
  g1(3,4)=(-(T58*T111));
  g1(3,1)=(-(1-params(5)+T59*T123));
  g1(3,5)=1;
  g1(3,2)=(-(T58*T59));
  g1(4,2)=(-params(6));
  g1(4,6)=1;
  g1(4,9)=(-params(7));

if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(48,3);
T144 = getPowerDeriv(T15,1-params(3),2);
T145 = T75*T144;
T160 = getPowerDeriv(T26,1-params(3),2);
T161 = T85*T160;
  v2(1,1)=1;
  v2(1,2)=21;
  v2(1,3)=(y(3)*y(3)*(T77+y(3)*(T76*T14*getPowerDeriv(y(3),params(2),2)+T75*T145)-T77)-(y(3)*T77-T18)*(y(3)+y(3)))/(y(3)*y(3)*y(3)*y(3));
  v2(2,1)=1;
  v2(2,2)=61;
  v2(2,3)=(-(T42*params(1)*(y(7)*y(7)*(T87+y(7)*(T86*T25*getPowerDeriv(y(7),params(2),2)+T85*T161)-T87)-(y(7)*T87-T27)*(y(7)+y(7)))/(y(7)*y(7)*y(7)*y(7))));
  v2(3,1)=1;
  v2(3,2)=30;
  v2(3,3)=(y(3)*(T97*T145+T76*T74*T96)-T76*T97)/(y(3)*y(3));
  v2(4,1)=1;
  v2(4,2)=22;
  v2(4,3)=  v2(3,3);
  v2(5,1)=1;
  v2(5,2)=34;
  v2(5,3)=(-(T92*T101));
  v2(6,1)=1;
  v2(6,2)=58;
  v2(6,3)=  v2(5,3);
  v2(7,1)=1;
  v2(7,2)=31;
  v2(7,3)=(T97*T97*T144+T76*T10*getPowerDeriv(1-y(4),1-params(2),2))/y(3)-T29*T37*getPowerDeriv(y(4),params(4),2);
  v2(8,1)=1;
  v2(8,2)=70;
  v2(8,3)=(-(T42*params(1)*(y(7)*(T116*T161+T86*T84*T115)-T86*T116)/(y(7)*y(7))));
  v2(9,1)=1;
  v2(9,2)=62;
  v2(9,3)=  v2(8,3);
  v2(10,1)=1;
  v2(10,2)=67;
  v2(10,3)=(-(T101*T119));
  v2(11,1)=1;
  v2(11,2)=35;
  v2(11,3)=  v2(10,3);
  v2(12,1)=1;
  v2(12,2)=71;
  v2(12,3)=(-(T42*params(1)*(T116*T116*T160+T86*T22*getPowerDeriv(1-y(8),1-params(2),2))/y(7)));
  v2(13,1)=1;
  v2(13,2)=43;
  v2(13,3)=(-(T92*T129));
  v2(14,1)=1;
  v2(14,2)=59;
  v2(14,3)=  v2(13,3);
  v2(15,1)=1;
  v2(15,2)=40;
  v2(15,3)=(-(T29*T100*T128));
  v2(16,1)=1;
  v2(16,2)=32;
  v2(16,3)=  v2(15,3);
  v2(17,1)=1;
  v2(17,2)=44;
  v2(17,3)=(-(T119*T129));
  v2(18,1)=1;
  v2(18,2)=68;
  v2(18,3)=  v2(17,3);
  v2(19,1)=1;
  v2(19,2)=41;
  v2(19,3)=(-(T29*T38*params(4)*exp(y(2))*getPowerDeriv(y(5),params(4)-1,2)));
  v2(20,1)=1;
  v2(20,2)=16;
  v2(20,3)=(-(T37*T38*T92));
  v2(21,1)=1;
  v2(21,2)=56;
  v2(21,3)=  v2(20,3);
  v2(22,1)=1;
  v2(22,2)=13;
  v2(22,3)=(-(T29*T101));
  v2(23,1)=1;
  v2(23,2)=29;
  v2(23,3)=  v2(22,3);
  v2(24,1)=1;
  v2(24,2)=17;
  v2(24,3)=(-(T37*T38*T119));
  v2(25,1)=1;
  v2(25,2)=65;
  v2(25,3)=  v2(24,3);
  v2(26,1)=1;
  v2(26,2)=14;
  v2(26,3)=(-(T29*T129));
  v2(27,1)=1;
  v2(27,2)=38;
  v2(27,3)=  v2(26,3);
  v2(28,1)=1;
  v2(28,2)=11;
  v2(28,3)=(-(T29*T37*T38));
  v2(29,1)=2;
  v2(29,2)=30;
  v2(29,3)=T45*1/((1-y(4))*(1-y(4)));
  v2(30,1)=2;
  v2(30,2)=22;
  v2(30,3)=  v2(29,3);
  v2(31,1)=2;
  v2(31,2)=31;
  v2(31,3)=T45*(-(y(3)*((-(1-y(4)))-(1-y(4)))))/((1-y(4))*(1-y(4))*(1-y(4))*(1-y(4)))-T51*getPowerDeriv(y(4),(-params(4)),2);
  v2(32,1)=2;
  v2(32,2)=40;
  v2(32,3)=(-(T108*T133));
  v2(33,1)=2;
  v2(33,2)=32;
  v2(33,3)=  v2(32,3);
  v2(34,1)=2;
  v2(34,2)=41;
  v2(34,3)=(-(T53*exp(y(2))*(1-params(4))*getPowerDeriv(y(5),params(4),2)));
  v2(35,1)=2;
  v2(35,2)=13;
  v2(35,3)=(-(T51*T108));
  v2(36,1)=2;
  v2(36,2)=29;
  v2(36,3)=  v2(35,3);
  v2(37,1)=2;
  v2(37,2)=14;
  v2(37,3)=(-(T53*T133));
  v2(38,1)=2;
  v2(38,2)=38;
  v2(38,3)=  v2(37,3);
  v2(39,1)=2;
  v2(39,2)=11;
  v2(39,3)=(-(T51*T53));
  v2(40,1)=3;
  v2(40,2)=31;
  v2(40,3)=(-(T58*getPowerDeriv(y(4),1-params(4),2)));
  v2(41,1)=3;
  v2(41,2)=4;
  v2(41,3)=(-(T111*T123));
  v2(42,1)=3;
  v2(42,2)=28;
  v2(42,3)=  v2(41,3);
  v2(43,1)=3;
  v2(43,2)=1;
  v2(43,3)=(-(T59*exp(y(2))*getPowerDeriv(y(1),params(4),2)));
  v2(44,1)=3;
  v2(44,2)=13;
  v2(44,3)=(-(T58*T111));
  v2(45,1)=3;
  v2(45,2)=29;
  v2(45,3)=  v2(44,3);
  v2(46,1)=3;
  v2(46,2)=10;
  v2(46,3)=(-(T59*T123));
  v2(47,1)=3;
  v2(47,2)=2;
  v2(47,3)=  v2(46,3);
  v2(48,1)=3;
  v2(48,2)=11;
  v2(48,3)=(-(T58*T59));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),4,81);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],4,729);
end
end
end
end
