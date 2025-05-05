clear all;

D = 0.015;
lambda1 = 50;

mu = 1/D;
p0 = 1 - (lambda1/mu);
p1 = p0 * (lambda1/mu);
p2 = p0* ((lambda1/mu)^2);
p3 = p0* ((lambda1/mu)^3);
p4 = p0 + p1 + p2 + p3;
rho1 = lambda1 * D;

U1 = rho1;
R1 = 1/(mu-lambda1);
Nq1 = rho1^2 / (1-rho1);

prob = exp(-(0.5/R1));
perc = -log(1-(90/100))*R1;

lambda2 = 85;

U2 = lambda2/mu;
avgU2 = lambda2/(2*mu);
rho2 = (lambda2 * D) / 2;
pp0= (1-rho2) / (1+rho2);
pp1 = 2*pp0*rho2;
pp2 = 2*pp0*(rho2^2);
pp3 = 2*pp0*(rho2^3);
pp4= pp0 + pp1 + pp2 + pp3;
R2 = D / (1-rho2^2);
Nq2 = (2*rho2 / (1-(rho2^2))) - U2;
