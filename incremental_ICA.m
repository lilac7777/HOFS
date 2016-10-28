function[S,W] = incremental_ICA(W_ , X)
n = size(W_,1);
W = rand(n+1);
W(1:n,1:n)=W_;
wtmp = rand(1,n+1);
detW = det(W_);
lr = 0.0001;
m = size(X,2);
maxIter = 100;
batchsize = max(floor(m/10));
for i = 1:maxIter
    dia = sum(W_.*eye(n));
    dia = [dia,1];
    dia(2:2:end) = -dia(2:2:end);
    rd = randi([1,m],batchsize,1);
    x = X(:,rd);
    tmp =(1-2*g((wtmp*x)));
    step = tmp*x'+repmat(detW*W(n+1,n+1),1,n+1)./dia;
    wtmp = wtmp + lr* step;
end
W(end,:) =wtmp; 


S = W*X;

end

