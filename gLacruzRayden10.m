%% exponentail test function 10
function [gvalue] = gLacruzRayden10(x,n)
% from La Cruz and Rayden 2003 paper
% code written by Omar Alolayan -- olyanos@mit.edu
% n is the number of variables
gvalue = zeros(n,1);
    for i=1:n
        gvalue(i) = log(x(i) +1 ) - (x(i)/n);
    end
end