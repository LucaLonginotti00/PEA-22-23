clear all;

N=530;
Z=120;
Sm = 0.080;
Sf = 0.120;
Sd = 0.011;

vm=1;
vf=0.75;
vd=10;


demandm = vm * Sm;
demandf = vf * Sf;
demandd = vd * Sd;

Dk=[demandm demandf demandd]

Nk=[0 0 0];

for i=1:N

    Rk = Dk .* (Nk + 1);
    R = sum(Rk);
    X = i / (R + Z);
    Nk= X * Rk;
end     

ResponseTime=R
Throughput=X
Utilization= Dk * X
N_not_thinking=sum(Nk)