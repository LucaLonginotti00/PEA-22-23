clear all;

FILE = csvread("random.csv");

N=500;
% continuos uniform
t = [0:0.1:100];
CU=5+((15-5).*FILE(:,1));

AnaliticCU=max(0,min(1,(t-5)/(15 - 5)));

plot(sort(CU),[1:500]/500,"+",t, AnaliticCU);
a=CU(1:10,1)


% discrete 
p = [0.3,0.4,0.3];
valuesdu=[5,10,15];
Cdu = cumsum(p);
for k = 1:N
    for i = 1:3
        if FILE(k,1) < Cdu(1,i);
            resdu(k,1) = valuesdu(1,i);
            break;
        end;
    end;
end; 
b=resdu(1:10,1)
tUni=0:0.01:0.99;
yUni= zeros(size(tUni,2),1);
for i = 1:size(tUni,2)
    for k = 1:size(p,2)
        if tUni(1,i) < Cdu(1,k)
            yUni(i,1) = valuesdu(1,k);
            break;
        end
    end
end

plot(sort(resdu),[1:500]/500,"+",sort(yUni),tUni);

% exponential distribution 
lamdaExp=1/10;
Exp= -(log(FILE(:,1))/lamdaExp);
AnaliticExp=1 - exp((-lamdaExp) * t);
plot(sort(Exp),[1:500]/500,"+",t, AnaliticExp);
c=Exp(1:10,1)

% Hyper-exponential distribution 
lamdaHyperexp=[0.05,0.175];
ProbHyperexp=[0.3,0.7];
CduHyperexp=cumsum(ProbHyperexp);
for k = 1:N
    for i = 1:2
        if FILE(k,1) < CduHyperexp(1,i)
            resHyperExp(k,1) = -(log(FILE(k,2))/lamdaHyperexp(1,i));
            break
        end;
    end;
end;
AnaliticHyperExp= 1-(ProbHyperexp(1,1)*exp(-lamdaHyperexp(1,1)*t) + (1-ProbHyperexp(1,1))*exp(-lamdaHyperexp(1,2)*t));
d=resHyperExp(1:10,1)                 
plot(sort(resHyperExp),[1:500]/500,"+",t, AnaliticHyperExp);

% Hypo-exponential distribution
lamdaHypoexp=[0.25, 0.16667];

HypoExp=-(log(FILE(:,2))/lamdaHypoexp(1,1))-(log(FILE(:,3))/lamdaHypoexp(1,2));
AnaliticHypoExp=1-1/(lamdaHypoexp(1,2)-lamdaHypoexp(1,1))*(lamdaHypoexp(1,2)*exp(-lamdaHypoexp(1,1)*t) - lamdaHypoexp(1,1)*exp(-lamdaHypoexp(1,2)*t));
plot(sort(HypoExp),[1:500]/500,"+",t, AnaliticHypoExp);
e=HypoExp(1:10,1)
% Hyper-Erlang distribution
lamdaHyperErl=[0.05,0.35];
ProbHyperErl=[0.3,0.7];
CduHyperErl=cumsum(ProbHyperErl);
for k = 1:N
    for i = 1:2
        if FILE(k,1) < CduHyperErl(1,i)          

            resHyperErl(k,1) = -((log(FILE(k,2))+log(FILE(k,3)))/lamdaHyperErl(1,i));
            break
        end;
    end;
end;
AnaliticHyperErl= 1-ProbHyperErl(1,1).*exp(-lamdaHyperErl(1,1)*t)- (1-ProbHyperErl(1,1)).*(exp(-lamdaHyperErl(1,2)*t)+ lamdaHyperErl(1,2)*t.*exp(-lamdaHyperErl(1,2)*t));
f=resHyperErl(1:10,1)
plot(sort(resHyperErl),[1:500]/500,"+",t, AnaliticHyperErl);





