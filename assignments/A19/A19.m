clear all;

%rates
lambdaE=5;
lambdaP=10;
lam=[5;10];
v=[1, 1; 1, 1];

%Demands
D1e=50/1000;
D2e=100/1000;

D1p=60/1000;
D2p=40/1000;

Xck= v.* [lam lam];
Xk= sum(Xck);
Xc=lam;
X=sum(Xc);


%solution

U1e= lambdaE * D1e;
U2e= lambdaE * D2e;

U1p= lambdaP * D1p;
U2p= lambdaP * D2p;



%utilization
U1=U1e+U1p
U2=U2e+U2p



%residence time

R1E = D1e / (1 - U1);
R2E = D2e / (1 - U2);
R1P = D1p / (1 - U1);
R2P = D2p / (1 - U2);
Rck= [R1E,R2E;R1P,R2P];

PHIck=Rck ./v;
Nck=Xck .* PHIck;
Nk=sum(Nck);

Rk=Nk./ Xk
PHI = sum(Rk)

