clear all;

MTTF1 = 20;
MTTF2 = 3;
MTTR1 = 2;
MTTR2 = 8;
MTTR3 = 100;

l1 = 1/MTTF1;
l2 = 1/MTTF2;
m1 = 1/MTTR1;
m2 = 1/MTTR2;
m3 = 1/MTTR3;

Q = [-l1-l2,l1,l2,0;
    m1,-m1-l2,0,l2;
    m2,0,-m2-l1,l1;
    m3,0,0,-m3];

p0 = [1,0,0,0];

[t,Sol] = ode45 (@(t,x) Q'*x,[0,300],p0');

plot(t,Sol,"-");
legend("s1","s2","s3","s4");
