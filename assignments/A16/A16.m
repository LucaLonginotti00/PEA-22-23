clear all;

S1 = 0.085;
S2 = 0.075;
S3 = 0.060;

lambdaIN1 = 10;
lambdaIN3 = 5;

lambda0 = lambdaIN1 + lambdaIN3;
lambda1 = lambdaIN1;
lambda2 = lambda1;
lambda3 = lambdaIN3 + lambda2;

visitWeb = lambda1/lambda0;
visitDB = lambda2/lambda0;
visitStorage = lambda3/lambda0;

demand1 = visitWeb * S1;
demand2 = visitDB * S2;
demand3 = visitStorage * S3;

U1 = lambda0 * demand1;
U2 = lambda0 * demand2;
U3 = lambda0 * demand3;

X = lambda0;

N1 = U1 / (1-U1);
N2 = U2 / (1-U2);
N3 = U3 / (1-U3);

R1 = demand1/(1-U1); 
R2 = demand2/(1-U2); 
R3 = demand3/(1-U3);

R = R1 + R2 + R3;