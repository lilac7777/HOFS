function [S,W] = compute_W(X)
%%X feature , sample
W = rand(size(X,1),size(X,1));
lr = 0.003;
m = size(X,2);
maxIter = 30;
batchsize = max(floor(m/10));
for i = 1:maxIter
    rd = randi([1,m],batchsize,1);
    x = X(:,rd);
    tmp =(1-2*g((W*x)));
    step = tmp*x'+inv(W');
    W = W + lr* step;
end

S = W*X;
end

