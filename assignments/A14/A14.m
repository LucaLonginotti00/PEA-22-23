clear all;

lambda1 = 500;
mu1 = 1500;
mu2 = 1000;

D = 1/mu1 + 1/mu2;
m2 = 1/(mu1^2) + 1/(mu2^2);
rho1 = lambda1 * D;
U1 =rho1;
R1 = D + (lambda1*m2)/2*(1-rho1);
N = rho1 + ((lambda1^2)*m2) / 2*(1-rho1);

lambda2 = 4000;
k = 4;
rho2 = (lambda2 * D)/2;
U2 = lambda2 * D;
ca = 1/sqrt(k);
cv = sqrt((mu1^2 + mu2^2)) / (mu1 + mu2);
R2 = D + ((ca^2 + cv^2)/2)*((rho2^2)*D/(1-rho2^2));
N2 = D*lambda2 + ((ca^2 + cv^2)/2)*((rho2^2)*D*lambda2/(1-rho2^2));