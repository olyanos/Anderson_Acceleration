%% Attemept to more rubust Anderson Acceleration for Fixed point iteration
% by Omar Alolayan -- olyanos@mit.edu -- March,22-2019
% All of this work is an attempt to write the code for the algorithm
% described by Homer Walker on His 2011 paper Titled:
% Anderson Acceleration for Fixed-Point Iterations, Homer Walker. 2011
%% 
% usual cleaning
clear all; clc;
lastwarn(''); %clearing last warning since clear all doesn't clear it
max_iter=1e6;
epsilon=1e-3;
options = optimoptions(@lsqlin,'MaxIterations',2000,...
        'OptimalityTolerance',1e-10,'StepTolerance',1e-10,...
        'ConstraintTolerance',1e-10,'Display','off');
    

%% test on function 10
mk = 2
n=100; % number of variables
init_guess10= ones(n,1);
y=myAcc(@(x)gLacruzRayden10(x,n),init_guess10,n,mk,1e-3,options);

%% test on function 11
mk = 10
init_guess11= ones(n,1) .* -1;
y=myAcc(@(x)gLacruzRayden11(x,n),init_guess11,n,mk,1e-3,options)


%% test on function 16
n=100; % number of variables
mk = 9

init_guess16= zeros(n,1);
for i=1:n
    init_guess16(i) = i / n;
end

M2 = cputime();

 y=myAcc(@(x)gLacruzRayden16(x,n),init_guess16,n,mk,epsilon,options);
CPU_TIME_IN_MINUTES_MINE = (cputime() - M2)/60
