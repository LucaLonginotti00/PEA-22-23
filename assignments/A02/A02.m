clear all;

AC = csvread("Log1.csv");

AT = size(AC,1);

ArrTime=seconds(AC);
CompTime=ArrTime(1)+seconds(1.2);
for i = 2:AT
    CompTime= [CompTime;max(CompTime(end),ArrTime(i))+seconds(1.2)];
end

T = sum(AC,1);
A = T/AT;
Lambda = 1/A;


Std = std(AC);
Rt = CompTime - ArrTime;
W = sum(Rt);
R = W / AT;
XY = [AC(1:end-1,1), AC(2:end,1)];
plot(XY(:,1),XY(:,2),".");

fprintf(1, "Average inter-arrival time: %g\n",A);
fprintf(1, "Arrival Rate: %g\n", Lambda);
fprintf(1, "Dev std: %g\n", Std);
fprintf(1, "Average Response Time: %g\n\n", seconds(R));