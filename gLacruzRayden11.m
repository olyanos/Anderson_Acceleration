%% exponentail test function 11
function [gvalue] = gLacruzRayden11(x,n)
% from La Cruz and Rayden 2003 paper
% code written by Omar Alolayan -- olyanos@mit.edu
% n is the number of variables
gvalue = zeros(n,1);
gvalue(1) = (3 - 0.5*x(1))*x(1) -2*x(2) +1;
    for i=2:n-1
        gvalue(i) = (3-0.5*x(i))*x(i) -x(i-1) - 2*x(i+1) +1;
    end
gvalue(n) =  (3 - 0.5*x(n))*x(n) - x(n-1) + 1;
end