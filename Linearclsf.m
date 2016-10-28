function [W] = Linearclsf(L,data)
batch_sz = 256;
maxIter =1000;
momentum = 0.5;
thr = 0.1;
for i =1:1
    M = data;
    converge = 0;
    iter = 1;
    W = rand(size(L,1),size(M,1));
    lr=0.00002; 
    while (~converge)
        iter = iter+1;
        rd = randi([1,size(data,2)],batch_sz,1);
        Mtmp = M(:,rd);
        Ltmp = L(:,rd);
        grads = (W*Mtmp - Ltmp)*Mtmp';
       % 
        grad(iter-1) = norm(grads);
        if( norm(grads)<thr || iter >maxIter||lr < 0.00000002)
            converge = 1;
        end
        if(iter ==2)
            gradsp = grads;
        end
        if (mod(iter,50) == 0)
            if (grad(iter-1)/grad(iter-48)>.8)
                lr = lr/10;
            end
            disp(norm(grads));
        end
        g = grads*momentum + gradsp*(1-momentum);
        W = W- lr*g;
        gradsp = grads;
    end
end
end