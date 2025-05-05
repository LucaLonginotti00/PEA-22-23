clear all;

N_jobs = 50000;
gam = 0.95;
MaxErrRel = 0.05;
d_gamma = norminv((1+gam)/2);

lamdaHyperexp=[0.02,0.2];
ProbHyperexp=[0.1,0.9];
CduHyperexp=cumsum(ProbHyperexp);

for k = 1:N_jobs
    r1 = rand();
    for i = 1:2
        if r1 < CduHyperexp(1,i)
            r2 = rand();
            resHyperExp(k,1) = -(log(r2)/lamdaHyperexp(1,i));
            break
        end
    end
end

for k = 1:N_jobs
    r = rand();
    resUnif(k,1) = 5 + ((10-5).* r);
end

ArrTime=cumsum(resHyperExp);
ServTime = resUnif;

CompTime=ArrTime(1)+ServTime(1);
for i = 2:N_jobs
    CompTime= [CompTime;max(CompTime(end),ArrTime(i))+ServTime(i)];
end

Rt = CompTime - ArrTime;
W = sum(Rt);
R = W / N_jobs;
D1 = sum ((Rt - R).^2); 
s1 = (1/(N_jobs-1)) * D1;

%Confidence intervals of average response time
Lb1 = R - d_gamma*(sqrt(s1/N_jobs));
Ub1 = R + d_gamma*(sqrt(s1/N_jobs));

A = 1;
M = 250;
K = 200;
U = 0;
U2 = 0;
s=0;

for i=1:K
    Bi = 0;
    Ti = CompTime(M*i)-ArrTime(A);
    for j=1:M
        Bi = Bi + ServTime(A + s);
        s = s + 1;
    end
    A = A + M;
    s = 0;
    Ui = Bi /Ti;
    U = U + Ui;
    U2 = U2 + Ui^2;
end

s2 = (U2 - U^2/K)/(K-1);

%Confidence intervals of Utilization
Lb2 = (U/K) - d_gamma*(sqrt(s2/K));
Ub2= (U/K) + d_gamma*(sqrt(s2/K));


A = 1;
X = 0;
X2 =0;

for i=1:K
    Ti = CompTime(M*i)-ArrTime(A);
    A = A + M;
    Xi = M /Ti;
    X = X + Xi;
    X2 = X2 + Xi^2;
end

s3 = (X2 - X^2/K)/(K-1);

%Confidence intervals of Throughput
Lb3 = (X/K) - d_gamma*(sqrt(s3/K));
Ub3= (X/K) + d_gamma*(sqrt(s3/K));

A = 1;
N = 0;
N2 = 0;
s=0;

for i=1:K
    Wi = 0;
    Ti = CompTime(M*i)-ArrTime(A);
    for j=1:M
        Wi = Wi + Rt(A + s);
        s = s + 1;
    end
    A = A + M;
    s = 0;
    Ni = Wi /Ti;
    N = N + Ni;
    N2 = N2 + Ni^2;
end

s4 = (N2 - N^2/K)/(K-1);

%Confidence intervals of average number of jobs
Lb4 = (N/K) - d_gamma*(sqrt(s4/K));
Ub4= (N/K) + d_gamma*(sqrt(s4/K));





