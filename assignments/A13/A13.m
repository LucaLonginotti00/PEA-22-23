clear all;

D = 0.00125;
lambda = 1200;

% M/M/1/16 
mu = 1/D;
K=16;
rho = lambda/mu;

U = (rho - rho^(K + 1)) / (1 - rho^(K + 1));
p0 = (1 - rho)/(1-rho^(K+1));
p14 = p0* (rho^14);
AVGnoj= (rho / (1-rho))- (((K+1)*rho^(K+1))/(1-rho^(K+1)));
Dr= lambda * ((rho^K-rho^(K+1)) / (1- rho^(K+1)));
X=lambda - Dr;
R=AVGnoj/(lambda*(1-(p0* (rho^K))));
Avgtimeinqueue=R-D;

% M/M/2/16 
c=2;
rho = lambda/ (c * mu);
p0new=0;
for i=0:(c-1)
    p0new=p0new+ (((c*rho)^i)/factorial(i));
end;
p0new=p0new+((((c*rho)^c)/factorial(c))*((1-(rho^(K-c+1)))/(1-rho)));
p0new=p0new^(-1);

AVGUt=(lambda * D)/c;  
pn = @(n) (p0new / (factorial(c) * c^(n - c))) * (lambda / mu)^n;
p14new=pn(14);

N=0;

for i=1:K
    if i<=c
       
       N=N+i*(rho^i)*p0new/(factorial(i)) ;
    else
       N=N+i*pn(i) ; 
       
    end
end

AVGnojnew=N;
Xnew= lambda * (1-pn(K));
Drnew=lambda*pn(K);
Rnew= AVGnojnew/(lambda*(1-pn(K)));
Avgtimeinqueuenew=Rnew-D;