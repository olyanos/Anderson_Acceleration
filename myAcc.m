%% Anderson Acceleration by Omar Alolayan
function [xk] = myAcc(g,x_init,n,m,epsilon,options)
%% Attemept to more rubust Anderson Acceleration for Fixed point iteration
% by Omar Alolayan -- olyanos@mit.edu -- March,22-2019
% All of this work is an attempt to write the code for the algorithm
% described by Homer Walker on His 2011 paper Titled:
% Anderson Acceleration for Fixed-Point Iterations, Homer Walker. 2011

% g : function formed as a fixed point iteration
% x_init : initial guess
% m : the space of the linear combination (for more details read the final project paper)
% epsilon : the code will terminate when reaching this error value it
% should be around 1e-9 or so for good accuracy
% options: paramters for lsqlin matlab function to find more look at matlab
% documentation.
xk = g(x_init); % x1 = g(x0)
residual = 1e9;
Fk = [];
alpha=[];
g_mk_bulk=[]; %big matrix each column is g of some (xk)
k =1; % iterations counter
    while( norm(residual) > epsilon)
    mk = min(m,k);
    gxk = g(xk) % to save time and avoid redoing function evals
    residual = xk - gxk;
    if ( k > m)
        g_mk_bulk = [g_mk_bulk(:,2:end),gxk];
        Fk =[Fk(:,2:end),residual];
    else
        g_mk_bulk = [g_mk_bulk,gxk];
        Fk = [Fk,residual]; 
    end
%     while ( cond(Fk) > 1e20)
%         [row,col]=size(Fk);
%         fprintf('Fk Matrix is badly conditioned=%e reducing mk to=%d\n',cond(Fk),col);
%     end
    [row,col]=size(Fk);
    b = zeros(n,1);
    
    %% Naive, solving opt at each step
    %Iv = ones(1,col);
    %alpha = lsqlin(Fk,b,[],[],Iv,1,[],[],[],options);
    
    %% Reformulate the minimization probelm
    tempvec = -Fk(:,end); % storing in a temp vec to avoid recalculation
    if mk==1
        A = Fk;
        alpha = [1];
    else
        A = Fk(:,1:end-1);
        A = A + tempvec;
       
        %A = RankDeficient(A,1e-9,1);
        [Q,R] = qr(A);
        alpha = R \ Q'*tempvec;
        if( strcmp(lastwarn,'') )
        %alpha = lsqminnorm(A,tempvec);
        alpha = [alpha; 1 - sum(alpha)];
        else
        % if A is singular fall to Pickard
        fprintf('Rank deicient A, Falling back to Picard\n');
        g_mk_bulk = [g_mk_bulk(:,end)];
        Fk =[Fk(:,end)];
        m =1;
        alpha = [1];
        end
    end
    %% solving for xk+1

    xk1 = g_mk_bulk * alpha;
    xk = xk1;
    
    fprintf('iter = %d res_norm=%e\n',k,norm(residual))
    %fprintf('iter = %d res_norm=%e cond(A)=%e\n',k,norm(residual),cond(A))

    k = k+1;
    end

end

