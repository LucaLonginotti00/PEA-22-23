CurrRountTime = 0;
CurrGarbage = 0;

Ts1 = 0;
Ts2 = 0;
Ts3 = 0;

s = 1;
Counter1 = 0;
Counter2 = 0;
Counter3 = 0;

lamdaExpPrep = 0.05;
lamdaGarbageStart=0.1;
lamdaGarbageduration=0.4;
lamdaJobnoGarbage=1;
lamdaJobGarbage=0.3;
%T?
for i = 1:500

%Preparation
    if s == 1 
        
        
        dt =-(log(rand)/lamdaExpPrep);

        Gi=-(log(rand)/lamdaGarbageStart);
        Gduration=-(log(rand)/lamdaGarbageduration);
        CurrGarbage=CurrGarbage + Gi + Gduration;

        while CurrRountTime+dt > CurrGarbage
            Gi=-(log(rand)/lamdaGarbageStart);
            Gduration=-(log(rand)/lamdaGarbageduration);
            CurrGarbage=CurrGarbage + Gi + Gduration;
        end
        
        if (CurrGarbage-Gduration) <= (CurrRountTime+dt) &&  (CurrRountTime+dt) < (CurrGarbage)
            
            ns = 2;            
        
        end

        if (CurrGarbage - Gi - Gduration) <= (CurrRountTime+dt) &&  (CurrRountTime+dt) < (CurrGarbage-Gduration)
            
            ns = 3;            
        
       end
        Ts1= Ts1 + dt;
        CurrRountTime= CurrRountTime + dt;
        Counter1 = Counter1 + 1;
    end

 %Job-Garbage
    if s == 2 
        
        ns=1;
        dt =-(log(rand)/lamdaJobGarbage);
        Ts2 = Ts2 + dt;
        CurrRountTime= CurrRountTime + dt;
        Counter2 = Counter2 + 1;
    end
%Job-noGarbage
    if s == 3 
        
        ns=1;
        dt =-(log(rand)/lamdaJobnoGarbage);
        Ts3 = Ts3 + dt;
        CurrRountTime= CurrRountTime + dt;
        Counter3 = Counter3 + 1;
    end
    s=ns;
end

    


% Probability of being in a certain state

pi1=Ts1/CurrRountTime;
pi2=Ts2/CurrRountTime;
pi3=Ts3/CurrRountTime;

fprintf(1, "Probability of being in State 1: %g\n", pi1);
fprintf(1, "Probability of being in State 2: %g\n", pi2);
fprintf(1, "Probability of being in State 3: %g\n", pi3);

%Frequency of entering a state

phi1= Counter1/CurrRountTime;

fprintf(1, "throughput: %g\n", phi1);    
