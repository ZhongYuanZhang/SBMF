function [F] = symnmf(X,k,iter, isnormalize)
% standard NMF.
% X = FF';

if nargin < 3
    iter = 100;
    isnormalize = 0;
end
if nargin < 4
     isnormalize = 0;
end

[m] = size(X,1);
Temp = inf;

for iter2 = 1:5
F = rand(m,k); 
% F = F./repmat(sum(F,2),1,k);
for i = 1:iter
    F = F.*(X*F)./((F*F')*F);
    if isnormalize
       F = F./repmat(sum(F,2),1,k);
    end
  F = max(F,eps);
end
    if (Temp-sum(sum((X-F*F').^2))) > 0
        Final_F = F;
        Temp = sum(sum((X-F*F').^2));
    end
end

F = Final_F;







