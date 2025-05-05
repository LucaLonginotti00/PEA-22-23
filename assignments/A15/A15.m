clear all;

lambda0=10;
Scpu=0.04;
Sdisk=0.1;
Snet=0.12;

lambdaCpu=lambda0;
lambdaNet=0.2*lambdaCpu;
lambdaDisk=0.3*lambdaCpu+0.8*lambdaNet;

visitCpu=lambdaCpu/lambda0;
visitNet=lambdaNet/lambda0;
visitDisk=lambdaDisk/lambda0;

demandCpu=visitCpu*Scpu;
demandNet=visitNet*Snet;
demandDisk=visitDisk*Sdisk;

Xcpu=visitCpu*lambda0;
Xnet=visitNet*lambda0;
Xdisk=visitDisk*lambda0;

