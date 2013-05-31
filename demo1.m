% demonstration on how to use SBMF and partiton density.
% 
% Note: we cannot be responsible for its use, misuse, 
% or functionality. 
%

clear
close all


iteration = 100;  % number of iterations.

% GN network:
N = 128; k = 4;
T = N/k;
classLabel = zeros(N,1);
for iter3 = 1:k
    classLabel(T*(iter3-1)+1:T*iter3) = iter3;
end
zout = 8; zin = 16-zout;
A = artdata(N,k,zin,zout);
display(['Artificial data generating finished',' ',num2str(zin),' ',num2str(zout)]);

estimate_k = 10;
best_k = choosek(A,estimate_k); 
                    % select appropriate community number

[F] = symnmf(A,k,iteration,1);
[a] = simthresholding(A,F);
ww = signstar(F,a);
index2 = zeros(N,1);
for iter2 = 1:N
    if sum(ww(iter2,:))==1
        [~,index2(iter2)] = find(ww(iter2,:)==1);
    elseif sum(ww(iter2,:))==0
        index2(iter2) = k+1;
    elseif sum(ww(iter2,:))>1
        index2(iter2) = k+1;
    end
end






