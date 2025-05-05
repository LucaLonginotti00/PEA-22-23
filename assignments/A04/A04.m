clear all;
AC = csvread("Traces.csv");
AC = sort(AC);

length(AC)

M1 = sum(AC) / length(AC);
M2 = sum(AC.^2) / length(AC);
M3 = sum(AC.^3) / length(AC);

var = sum((AC - M1).^2) / length(AC);
VarCoeff = sqrt(var) ./ M1;

t1 = [0:0.1:35];
t2 = [0:0.1:45];
t3 = [0:0.1:23];

a = M1 - ((1/2)*(sqrt(12*(M2 - M1.^2))));
b = M1 + ((1/2)*(sqrt(12*(M2 - M1.^2))));

lambda_m = 1./M1;

y1_unif_m = max(0,min(1,(t1-a(1,1))./(b(1,1) - a(1,1))));
y2_unif_m = max(0,min(1,(t2-a(1,2))./(b(1,2) - a(1,2))));
y3_unif_m = max(0,min(1,(t3-a(1,3))./(b(1,3) - a(1,3))));

y1_exp_m= 1 - exp((-lambda_m(1,1)) * t1);
y2_exp_m= 1 - exp((-lambda_m(1,2)) * t2);
y3_exp_m= 1 - exp((-lambda_m(1,3)) * t3);

HypoExpMom = @(p) [1/p(1,1) + 1/p(1,2), 2*(1/p(1,1)^2 + 1/(p(1,1)*p(1,2))+1/p(1,2)^2)];
F1 = @(p) (HypoExpMom(p) ./ [M1(1,1), M2(1,1)] - 1);
res_1 = fsolve(F1,[1,2]);
HypoExpCDF =  @(p,t) 1-1/(p(1,2)-p(1,1))*(p(1,2)*exp(-p(1,1)*t) - p(1,1)*exp(-p(1,2)*t));
y1_hypoexp_m = HypoExpCDF(res_1,t1);

F3 = @(p) (HypoExpMom(p) ./ [M1(1,3), M2(1,3)] - 1);
res_3 = fsolve(F3,[1,2]);
HypoExpCDF =  @(p,t) 1-1/(p(1,2)-p(1,1))*(p(1,2)*exp(-p(1,1)*t) - p(1,1)*exp(-p(1,2)*t));
y3_hypoexp_m = HypoExpCDF(res_3,t3);

HyperExpMom = @(p) [p(1,3)/p(1,1)+(1-p(1,3)/p(1,2)),2*(p(1,3)/p(1,1).^2 + (1-p(1,3))/p(1,2).^2),6*(p(1,3)/p(1,1).^3+(1-p(1,3))/p(1,2).^3)];
FHyper = @(p) (HyperExpMom(p)./ [M1(1,2), M2(1,2), M3(1,2)] - 1);
res = fsolve(FHyper,[1,1,1]);
HyperExpCDF =  @(p,t) 1-(p(1,3)*exp(-p(1,1)*t) + (1-p(1,3))*exp(-p(1,2)*t));
y2_hyperexp_m = HyperExpCDF(res,t2);

plot(AC(:,1), [1:1000]/1000,"+",t1,y1_exp_m,"-",t1,y1_unif_m,"*",t1,y1_hypoexp_m);
legend('Sample CDF', 'Exponential', 'Uniform', 'Hypo-Exp');
plot(AC(:,2), [1:1000]/1000,"+",t2,y2_exp_m,"-",t2,y2_unif_m,"*",t2,y2_hyperexp_m);
legend('Sample CDF', 'Exponential', 'Uniform', 'Hyper-Exp');
plot(AC(:,3), [1:1000]/1000,"+",t3,y3_exp_m,"-",t3,y3_unif_m,"*",t3,y3_hypoexp_m);
legend('Sample CDF', 'Exponential', 'Uniform', 'Hypo-Exp');

lambda_l = 1000./sum(AC);

y1_exp_l= 1 - exp((-lambda_l(1,1)) * t1);
y2_exp_l= 1 - exp((-lambda_l(1,2)) * t2);
y3_exp_l= 1 - exp((-lambda_l(1,3)) * t3);


HypoExpPDF = @(t,l1,l2) l1*l2/(l1-l2)*(exp(-l2*t)-exp(-l1*t));
ris_1 = mle(AC(:,1),'pdf',HypoExpPDF,'Start',[1/(0.3*M1(1,1)),1/(0.7*M1(1,1))]);
y1_hypoexp_l = 1 - (ris_1(1,2)*exp(-ris_1(1,1)*t1)) / (ris_1(1,2) - ris_1(1,1)) + (ris_1(1,1)*exp(-ris_1(1,2)*t1)) / (ris_1(1,2) - ris_1(1,1));

ris_3 = mle(AC(:,3),'pdf',HypoExpPDF,'Start',[1/(0.3*M1(1,3)),1/(0.7*M1(1,3))]);
y3_hypoexp_l = 1 - (ris_3(1,2)*exp(-ris_3(1,1)*t3)) / (ris_3(1,2) - ris_3(1,1)) + (ris_3(1,1)*exp(-ris_3(1,2)*t3)) / (ris_3(1,2) - ris_3(1,1));

HyperExpPDF = @(t, b1, b2,p) p*b1*exp(-b1*t) + (1-p)*b2*exp(-b2*t);
ris_2 = mle(AC(:,2),'pdf',HyperExpPDF,'Start',[0.4, 0.8/(M1(1,2)),1.2/(M1(1,2))]);
y2_hyperexp_l = 1 - ris_2(1,3)*exp(-ris_2(1,1)*t2) - (1-ris_2(1,3))*exp(-ris_2(1,2)*t2);

plot(AC(:,1),[1:1000]/1000,"+",t1,y1_exp_l,"-",t1,y1_hypoexp_l);
legend('Sample CDF', 'Exponential', 'Hypo-Exp');
plot(AC(:,2),[1:1000]/1000,"+",t2,y2_exp_l,"-",t2,y2_hyperexp_l);
legend('Sample CDF', 'Exponential', 'Hyper-Exp');
plot(AC(:,3),[1:1000]/1000,"+",t3,y3_exp_l,"-",t3,y3_hypoexp_l);
legend('Sample CDF', 'Exponential','Hypo-Exp');

