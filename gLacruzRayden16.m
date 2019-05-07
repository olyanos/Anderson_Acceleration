%% exponentail test function 16
function [gvalue] = gLacruzRayden16(x,n)
% from La Cruz and Rayden 2003 paper
% code written by Omar Alolayan -- olyanos@mit.edu
% n is the number of variables
gvalue = zeros(n,1);
    for i=1:n
        gvalue(i) = exp(x(i)) -1;
    end
end