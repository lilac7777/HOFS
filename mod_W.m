function [S,W] = mod_W(w,X)
%%X (feature , sample)
%%iteration for unmixing matrix
W = zeros(size(X,1));
W(1:size(w,1),1:size(w,2)) = w;
W(end,:)=rand(1,size(X,1));
W(end,end) = 1;
lr = 0.001;
m = size(X,2);
maxIter =100;
batchsize = max(floor(m/10));
for i = 1:maxIter
    rd = randi([1,m],batchsize,1);
    x = X(:,rd);
    tmp =(1-2*g((W*x)));
    step = tmp*x'+inv(W');
    W = W + lr* step;
    W(1:end-1,end) = 0;
    W(1:size(w,1),1:size(w,2)) = w;
end

S = W*X;
end

function[y] = g(x)
y = 1./(1+exp(-x));
end