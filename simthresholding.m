function [w] = simthresholding(V,W)

if nargin < 3
     L = ones(size(V));
end

II = max(max(W));
testw = 0:.01:II;%discretize h and w;
[~,nn] = size(testw);
temp = inf;
  
for i = 1:nn
    newW = signstar(W,testw(i));
    WW = newW*newW';
    WW(WW>1) = 1;
    newtemp = norm((V-WW),1)+sum((sum(newW,2)==0));
    if newtemp < temp
        temp = newtemp;
        w = testw(i);
    end
end
  
  
  
  
  
  
  
  