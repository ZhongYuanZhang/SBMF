function [A] = artdata(N,k,zin,zout)
% A: adjacency matrix. 
% N: node number.
% k: community number.
% note that mod(N,k) should be zero.
% zin: edges number connected to its own community.
% zout: edges number connected to outer community.
% % % % % % % % % % % % % % % % % % % % % % % % % % %
temp_U = [];
U = [];
temp_V = [];
V = [];
temp_S = [];
S = [];
L = []; 
T = N/k; % node number in each community.
max = 25;

for i = 1:N-1
    %%=============== adding the new generated part into the main graph===
     if mod(i,max) == 0 || i == N-1
       U = [U temp_U];
       temp_U = [];
       V = [V temp_V];
       temp_V = [];
       S = [S temp_S];
       temp_S = [];
     end
    %%===================================================
    
    %%==============  generating part of the graph ==============
    for j = i+1:N
        if ceil(j/T) == ceil(i/T) % whether the community id of node j is identical with node i.
            if rand < zin/(T-1)
                temp_U(end+1) = i;
                temp_V(end+1) = j;
                temp_S(end+1) = 1;
            end
        else
            if rand < zout/(N-T)
                temp_U(end+1) = i;
                temp_V(end+1) = j;
                temp_S(end+1) = 1;
            end
        end
    end
end

%%========= Making the adjacency matrix symmetric =========
temp = U;
U(end+1:2*size(V,2)) = V; % the sizes of U and V are identical
V(end+1:2*size(V,2)) = temp;
clear temp .
S(end+1:2*size(S,2)) = 1;
U(end+1:end+N) = 1:N;
V(end+1:end+N) = 1:N;
S(end+1:end+N) = 1;
A = sparse(U,V,S);
%%=================================================

