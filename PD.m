function P = PD(A, label, k)
% get the partition density of the given graph partition.
% A: adjacency matrix.
% label: each cell is the community label of each node.
% k: the community number
% P: partition density

if A(1,1) == 1
    A = A-eye(size(A));
end

N = 0;
M = sum(sum(A))/2;  % number of edges.
pool = cell(k,1);  % each cell is one community containing node labels.
s = zeros(length(A),1); % each element is the label number of the node.

for i = 1:size(label,1)
    if ~isempty(label{i})
        temp = label{i};
        s(i) = length(temp);
        for j = 1:length(temp)
            pool{temp(j)} = union([pool{temp(j)}], i);
        end
    else
        N = N+1;
    end
end
N = N+sum(s);

n = zeros(1,k); % number of nodes in each community
m = zeros(1, k); % number of edges in each community
d = zeros(1,k); % link density of each community
n2 = zeros(1,k); % max label number in each community
for t = 1:k
    n(t) = length(pool{t});
    if ~isempty(s(pool{t}))
        n2(t) = max(s(pool{t}));
    end
    m(t) = sum(sum(A(pool{t}, pool{t})))/2;
    if (n(t) > 2)
        d(t) = (n(t)/n2(t))*(m(t)-(n(t)-1))/((n(t)*(n(t)-1)/2)-(n(t)-1));
    end
end

P = sum(d)/N;