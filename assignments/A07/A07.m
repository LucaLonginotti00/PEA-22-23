CurrRountTime = 0;


TsSensing = 0;
TsComputing = 0;
TsCooling = 0;
TsHeating = 0;
s = 1;
flag = 0;
Counter1 = 0;
Counter2 = 0;
Counter3 = 0;
Counter4 = 0;

%T?
for i = 1:500

%SENSING
    if s == 1 
        lamdaErl = 0.1;
        ns = 2;
        dt =-((log(rand())+log(rand())+log(rand()))/lamdaErl);
        TsSensing= TsSensing + dt;
        CurrRountTime= CurrRountTime + dt;
        Counter1 = Counter1 + 1;
    end

 %COMPUTING
    if s == 2 

        Sel= rand();

        if Sel <= 0.5
            ns = 1;
        end
        if Sel > 0.5 && Sel <= 0.8
            ns = 3;
        end
        if Sel > 0.8
            ns = 4;
        end
        
        dt =10+((20-10).*rand());
        TsComputing = TsComputing + dt;
        CurrRountTime= CurrRountTime + dt;
        Counter2 = Counter2 + 1;
    end
%COOLING
    if s == 3 
        lamdaExp=0.05;
        Counter3 = Counter3 + 1;
        ns = 1;
        dt =-(log(rand())/lamdaExp);
        TsCooling = TsCooling + dt;
        CurrRountTime= CurrRountTime + dt;
    end

%HEATING
    if s == 4 
        lamdaExp=0.03;
        Counter4 = Counter4 + 1;
        ns = 1;
        dt =-(log(rand())/lamdaExp);
        TsHeating = TsHeating + dt;
        CurrRountTime= CurrRountTime + dt;
    end
    s = ns;
    
end

% Probability of being in a certain state

pi1=TsSensing/CurrRountTime;
pi2=TsComputing/CurrRountTime;
pi3=TsCooling/CurrRountTime;
pi4=TsHeating/CurrRountTime;
fprintf(1, "Probability of being in State 1: %g\n", pi1);
fprintf(1, "Probability of being in State 2: %g\n", pi2);
fprintf(1, "Probability of being in State 3: %g\n", pi3);
fprintf(1, "Probability of being in State 4: %g\n", pi4);
%Frequency of entering a state

phi1= Counter1/CurrRountTime;
phi2= Counter2/CurrRountTime;
phi3= Counter3/CurrRountTime;
phi4= Counter4/CurrRountTime;
fprintf(1, "Frequency of entering State 1: %g\n", phi1);    
fprintf(1, "Frequency of entering State 2: %g\n", phi2); 
fprintf(1, "Frequency of entering State 3: %g\n", phi3); 
fprintf(1, "Frequency of entering State 4: %g\n", phi4); 

