clear all;

G1 = 10;
G2 = 20;
G3 = 10;
B1 = 50;
B2 = 2;
B3 = 5;

l1 = 1/G1;
l2 = 1/G2;
l3 = 1/G3;
m1 = 1/B1;
m2 = 1/B2;
m3 = 1/B3;

Q = [-l1,l1,0,0;
    m1,-m1-l2-l3,l2,l3;
    0,m2,-m2,0;
    0,m3,0,-m3];

p0 = [1,0,0,0];

[t,Sol] = ode45 (@(t,x) Q'*x,[0,500],p0');

plot(t,Sol,"-");
legend("s1","s2","s3","s4");

u = [1,0,0,0];
Qp = [ones(4,1), Q(:,2:4)];

pis = u*inv(Qp);

%Utilization
alfa1 = [0,1,1,1];
avg1 = Sol(end,:) * alfa1';

%Average power consumption
alfa2 = [0.1,2,10,0.5];
avg2 = Sol(end,:) * alfa2';

%System throughput
e1=[0,0,0,0;
    1,0,0,0;
    0,0,0,0;
    0,0,0,0];

%GPU through
e2=[0,0,0,0;
    0,0,0,0;
    0,1,0,0;
    0,0,0,0];

%I/O frequency
e3 =[0,0,0,0;
    0,0,0,0;
    0,0,0,0;
    0,1,0,0];

avg3 = sum((Q.*e1)') * pis';
avg4 = sum((Q.*e2)') * pis';
avg5 = sum((Q.*e3)') * pis';

i1=sum((Q.*e1)');
i2=sum((Q.*e2)');
i3=sum((Q.*e3)');

plot(t,Sol * alfa1',"-");
legend("U");

plot(t,Sol * alfa2',"-");
legend("APC");

plot(t,Sol*i1',"-");
legend("St");

plot(t,Sol*i2',"-");
legend("GPUt");

plot(t,Sol*i3',"-");
legend("I/Of");