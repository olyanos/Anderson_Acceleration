%% exponentail test function 1
function [gvalue] = gLacruzRayden(x,n)
% from La Cruz and Rayden 2003 paper
% code written by Omar Alolayan -- olyanos@mit.edu
% n is the number of variables
gvalue = zeros(n,1);
gvalue(1) = exp(x(1) - 1) ;
    for i=2:n
        gvalue(i) = i * ( exp(x(i) -1) -x(i) );
    end
end