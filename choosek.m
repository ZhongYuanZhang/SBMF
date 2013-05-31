function [bestk,P,STD] = choosek(A,K)

% choose the appropriate community number for BMF


k = 2:K; P = zeros(1, length(k)); STD = zeros(1, length(k));
for iteration = 1:length(k)
    round = 50;
    Temp_P = zeros(round,1);
    for iteration1 = 1:round 
        [F] = symnmf(A,k(iteration),100,1);
        [a] = simthresholding(A,F);
        ww = signstar(F,a);
        label = cell(size(A,1),1);  % each cell is the community label of each person.
        for t = 1:size(A,1)
            label{t} = find(ww(t, :) == 1);
        end
        Temp_P(iteration1) = ...
            PD(A, label, k(iteration));
    end
    P(1, iteration) = mean(Temp_P);
    STD(1, iteration) = std(Temp_P);
end

[~,index] = max(P);
bestk = k(index);