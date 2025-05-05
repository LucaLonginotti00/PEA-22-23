clear all;

fileID = fopen('Data1.txt','r');
formatSpec = '%f';
AT = fscanf(fileID,formatSpec);

SD = std(AT);
CV = SD/(sum(AT)/length(AT));
KU = kurtosis(AT);

M1=sum(power(AT,1))/length(AT);
M2=sum(power(AT,2))/length(AT);
M3=sum(power(AT,3))/length(AT);
M4=sum(power(AT,4))/length(AT);
M5=sum(power(AT,5))/length(AT);

MC2=sum(power(AT-M1,2))/length(AT);
MC3=sum(power(AT-M1,3))/length(AT);
MC4=sum(power(AT-M1,4))/length(AT);
MC5=sum(power(AT-M1,5))/length(AT);

MS3=sum(power((AT-M1)/SD,3))/length(AT);
MS4=sum(power((AT-M1)/SD,4))/length(AT);
MS5=sum(power((AT-M1)/SD,5))/length(AT);

P10=prctile(AT,10);
P25=prctile(AT,25);
P50=prctile(AT,50);
P75=prctile(AT,75);
P90=prctile(AT,90);

LAG1= sum((AT(1:length(AT)-1)-M1).*(AT(2:length(AT))-M1))/(length(AT)-1);
LAG2= sum((AT(1:length(AT)-2)-M1).*(AT(3:length(AT))-M1))/(length(AT)-2);
LAG3= sum((AT(1:length(AT)-3)-M1).*(AT(4:length(AT))-M1))/(length(AT)-3);

PEA1= LAG1/MC2;
PEA2= LAG2/MC2;
PEA3= LAG3/MC2;

FX = sort(AT);
plot(FX, [1:length(AT)]/length(AT),".");  


fprintf(1, "M1: %g\n", M1);
fprintf(1, "M2: %g\n", M2);
fprintf(1, "M3: %g\n", M3);
fprintf(1, "M4: %g\n", M4);
fprintf(1, "M5: %g\n\n", M5);
fprintf(1, "MC2: %g\n", MC2);
fprintf(1, "MC3: %g\n", MC3);
fprintf(1, "MC4: %g\n", MC4);
fprintf(1, "MC5: %g\n\n", MC5);
fprintf(1, "MS3: %g\n", MS3);
fprintf(1, "MS4: %g\n", MS4);
fprintf(1, "MS5: %g\n\n", MS5);
fprintf(1, "Std dev: %g\n", SD);
fprintf(1, "Cv: %g\n", CV);
fprintf(1, "Ku: %g\n\n", KU);
fprintf(1, "P10: %g\n", P10);
fprintf(1, "P25: %g\n", P25);
fprintf(1, "P50: %g\n", P50);
fprintf(1, "P75: %g\n", P75);
fprintf(1, "P90: %g\n\n", P90);
fprintf(1, "CC1: %g\n", LAG1);
fprintf(1, "CC2: %g\n", LAG2);
fprintf(1, "CC3: %g\n\n", LAG3);
fprintf(1, "PEA1: %g\n", PEA1);
fprintf(1, "PEA2: %g\n", PEA2);
fprintf(1, "PEA3: %g\n", PEA3);

fclose(fileID);