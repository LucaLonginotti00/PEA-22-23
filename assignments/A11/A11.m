clear all;

N = 16;
m = 100;
lambda0 = 200;
N0=8;

pn = zeros(1, N+1);
pd = zeros(1, N+1);

pn(1,1) = 0;
pd(1,1) = 0;

for i=1:N
	if i < N0
		lim1 = lambda0;
    else
        lim1 =lambda0*(N-i)/(N-N0);
	end
	mi = m;
	pn(1, i+1) = pn(1,i) + log(lim1);
	pd(1, i+1) = pd(1,i) + log(mi);
end

p = exp(pn - pd);
p = p / sum(p)

plot([0:N], p, "+");
