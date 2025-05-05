clear all;

AC = fopen("apache1.log");
previousLine = fgetl(AC);
T2 = extractBetween(previousLine,'[15/Sep/2022:',' -200');
S = milliseconds(str2num(extractAfter(previousLine,'"Mozilla 8.1" ')));
td2 = duration(T2,'inputformat','hh:mm:ss.SSS');
A = td2;
C = S(end) + A(end);
currentline = fgetl(AC);
Ttemp = S(end);


while not(feof(AC))
    T1 = extractBetween(currentline,'[15/Sep/2022:',' -200');
    td1=duration(T1,'inputformat','hh:mm:ss.SSS');
    out=[td2;td1];
    Ttemp = [Ttemp;diff(out)];
    A = [A;A(end)+diff(out)];
    S = [S;milliseconds(str2num(extractAfter(currentline,'"Mozilla 8.1" ')))];
    C = [C; max(C(end),A(end))+S(end) ];
    currentline = fgetl(AC);
    td2=td1;
end
T = sum(Ttemp);

A=seconds(A);
S=seconds(S);
C=seconds(C);
T=seconds(T);


Rt = C - A;
W = sum(Rt);
Lambda = length(A) / T;
X = length(A) / T;

R = W / length(A);
N = W / T;

PR_1 = sum(Rt < 1) / length(A);
PR_2 = sum(Rt < 5) / length(A);
PR_3 = sum(Rt < 10) / length(A);
B=sum(S);
sC=length(C);

comb = [A(:,1), ones(size(A,1),1);
        C(:,1), -ones(size(C,1),1)];

comb = sortrows(comb,1);
NofT = cumsum(comb(:,2));
dT = comb(2:end,1) - comb(1:end-1,1);
Y0 = sum(dT .* (NofT(1:end-1,:) == 0));
Y1 = sum(dT .* (NofT(1:end-1,:) == 1));
Y2 = sum(dT .* (NofT(1:end-1,:) == 2));
Y3 = sum(dT .* (NofT(1:end-1,:) == 3));

fprintf(1, "Average Number of jobs: %g\n",N);
fprintf(1, "Average inter-arrival time: %g\n",T/length(A));
fprintf(1, "Average Service Time: %g\n", B./sC);
fprintf(1, "W: %g\n",W);
fprintf(1, "Utilization: %g\n",B/T);
fprintf(1, "Busy Time: %g\n",B);
fprintf(1, "Arrival Rate: %g, Throughput %g\n", Lambda, X);
fprintf(1, "Average Response Time: %g\n", R);
fprintf(1, "Pr(R<1): %g\n", PR_1);
fprintf(1, "Pr(R<5): %g\n", PR_2);
fprintf(1, "Pr(R<10): %g\n", PR_3);
fprintf(1, "Probability of having m jobs in the web server with m = 0: %g\n", Y0/T);
fprintf(1, "Probability of having m jobs in the web server with m = 1: %g\n", Y1/T);
fprintf(1, "Probability of having m jobs in the web server with m = 2: %g\n", Y2/T);
fprintf(1, "Probability of having m jobs in the web server with m = 3: %g\n\n\n", Y3/T);

fprintf(1, "Apache2: %g\n");

clear all;

AC = fopen("apache2.log");
previousLine = fgetl(AC);
T2 = extractBetween(previousLine,'[15/Sep/2022:',' -200');
S = milliseconds(str2num(extractAfter(previousLine,'"Mozilla 8.1" ')));
td2 = duration(T2,'inputformat','hh:mm:ss.SSS');
A= td2;
C = S(end) + A(end);
currentline = fgetl(AC);
Ttemp = S(end);


while not(feof(AC))
    T1 = extractBetween(currentline,'[15/Sep/2022:',' -200');
    td1=duration(T1,'inputformat','hh:mm:ss.SSS');
    out=[td2;td1];
    Ttemp = [Ttemp;diff(out)];
    A = [A;A(end)+diff(out)];
    S = [S;milliseconds(str2num(extractAfter(currentline,'"Mozilla 8.1" ')))];
    C = [C; max(C(end),A(end))+S(end) ];
    currentline = fgetl(AC);
    td2=td1;
end
T = sum(Ttemp);

A=seconds(A);
S=seconds(S);
C=seconds(C);
T=seconds(T);


Rt = C - A;
W = sum(Rt);
Lambda = length(A) / T;
X = length(A) / T;

R = W / length(A);
N = W / T;

PR_1 = sum(Rt < 1) / length(A);
PR_2 = sum(Rt < 5) / length(A);
PR_3 = sum(Rt < 10) / length(A);
B=sum(S);
sC=length(C);

comb = [A(:,1), ones(size(A,1),1);
        C(:,1), -ones(size(C,1),1)];

comb = sortrows(comb,1);
NofT = cumsum(comb(:,2));
dT = comb(2:end,1) - comb(1:end-1,1);
Y0 = sum(dT .* (NofT(1:end-1,:) == 0));
Y1 = sum(dT .* (NofT(1:end-1,:) == 1));
Y2 = sum(dT .* (NofT(1:end-1,:) == 2));
Y3 = sum(dT .* (NofT(1:end-1,:) == 3));

fprintf(1, "Average Number of jobs: %g\n",N);
fprintf(1, "Average inter-arrival time: %g\n",T/length(A));
fprintf(1, "Average Service Time: %g\n", B./sC);
fprintf(1, "W: %g\n",W);
fprintf(1, "Utilization: %g\n",B/T);
fprintf(1, "Busy Time: %g\n",B);
fprintf(1, "Arrival Rate: %g, Throughput %g\n", Lambda, X);
fprintf(1, "Average Response Time: %g\n", R);
fprintf(1, "Pr(R<1): %g\n", PR_1);
fprintf(1, "Pr(R<5): %g\n", PR_2);
fprintf(1, "Pr(R<10): %g\n", PR_3);
fprintf(1, "Probability of having m jobs in the web server with m = 0: %g\n", Y0/T);
fprintf(1, "Probability of having m jobs in the web server with m = 1: %g\n", Y1/T);
fprintf(1, "Probability of having m jobs in the web server with m = 2: %g\n", Y2/T);
fprintf(1, "Probability of having m jobs in the web server with m = 3: %g\n", Y3/T);

