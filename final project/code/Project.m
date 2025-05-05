clear all;

%Formalize specifications
fileID = fopen('TraceC-Spec.txt','r');
formatSpec = '%f';
Spec = fscanf(fileID,formatSpec);
Spec= Spec .* 3600;
cv1 = sqrt(var(Spec)) / mean(Spec);
M1_spec = sum(Spec) / length(Spec);
M2_spec = sum(Spec.^2) / length(Spec);
M3_spec = sum(Spec.^3) / length(Spec);

ErlangMom = @(p)[p(1,1)/p(1,2), p(1,1)*((p(1,1)+1)/(p(1,2)^2))];
F1 = @(p) (ErlangMom(p) ./[M1_spec,M2_spec]-1);
res_spec=fsolve(F1,[1,1]);

%Design hardware
fileID = fopen('TraceC-Design.txt','r');
formatSpec = '%f';
Design = fscanf(fileID,formatSpec);
Design= Design .* 3600;
cv2 = sqrt(var(Design)) / mean(Design);
M1_Design = sum(Design) / length(Design);
M2_Design = sum(Design.^2) / length(Design);
M3_Design = sum(Design.^3) / length(Design);

ErlangMom = @(p)[p(1,1)/p(1,2), p(1,1)*((p(1,1)+1)/(p(1,2)^2))];
F1 = @(p) (ErlangMom(p) ./[M1_Design,M2_Design]-1);
res_design=fsolve(F1,[1,1]);


%Breadboard hardware
fileID = fopen('TraceC-Breadbrd.txt','r');
formatSpec = '%f';
Breadbrd = fscanf(fileID,formatSpec);
Breadbrd= Breadbrd .* 3600;
cv3 = sqrt(var(Breadbrd)) / mean(Breadbrd);
M1_Breadbrd = sum(Breadbrd) / length(Breadbrd);
M2_Breadbrd = sum(Breadbrd.^2) / length(Breadbrd);
M3_Breadbrd = sum(Breadbrd.^3) / length(Breadbrd);

HyperExpMom = @(p,l1,l2) [p/l1 + (1-p)/l2, 2*(p/l1.^2 + (1-p)/l2.^2), 6*(p/l1.^3 + (1-p)/l2.^3)];
FHyper = @(p) (HyperExpMom(p(1,1),p(1,2),p(1,3))./ [M1_Breadbrd, M2_Breadbrd, M3_Breadbrd] - 1);
res_Breadbrd = fsolve(FHyper,[0.4,0.8/M1_Breadbrd,1.2/M1_Breadbrd]);

%Write software
fileID = fopen('TraceC-Software.txt','r');
formatSpec = '%f';
Software = fscanf(fileID,formatSpec);
Software= Software .* 3600;
cv4 = sqrt(var(Software)) / mean(Software);
M1_Software = sum(Software) / length(Software);
M2_Software = sum(Software.^2) / length(Software);
M3_Software = sum(Software.^3) / length(Software);

HyperExpMom = @(p,l1,l2) [p/l1 + (1-p)/l2, 2*(p/l1.^2 + (1-p)/l2.^2), 6*(p/l1.^3 + (1-p)/l2.^3)];
FHyper = @(p) (HyperExpMom(p(1,1),p(1,2),p(1,3))./ [M1_Software, M2_Software, M3_Software] - 1);
res_Software = fsolve(FHyper,[0.4,0.8/M1_Software,1.2/M1_Software]);

%Test
fileID = fopen('TraceC-Test.txt','r');
formatSpec = '%f';
Test = fscanf(fileID,formatSpec);
Test= Test .* 3600;
cv5 = sqrt(var(Test)) / mean(Test);
M1_Test = sum(Test) / length(Test);
M2_Test = sum(Test.^2) / length(Test);
M3_Test = sum(Test.^3) / length(Test);

res_Test = 1/M1_Test;








