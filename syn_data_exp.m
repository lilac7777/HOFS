function[selected] = syn_data_exp()
Y = [];X = [];
for i = 1:3
R = 0.9+0.5*randn(4);
tmp =real( R^(1/2)*randn(4,200));
tmp = tmp';
X = [X,tmp(:,2:end)];
Y= [Y,tmp(:,1)];
end
Y = mean(Y,2);
idx = 1:9;
selected{1} = [];
for n = 1:3
    Imax = -inf;
    i =1;
    while i <= length(idx)
        j = i+1;
        while j <=length(idx)
            k = j+1;
            while k <= length(idx)    
                    list = [idx(i),idx(j),idx(k)];
                    Itmp = get_I(X(:,list),Y);
                    if Itmp>Imax
                        Imax = Itmp;
                        selected{n} = [idx(i),idx(j),idx(k)];
                    end
                  k = k+1;
            end
            j = j+1;
        end    
        i= i+1;
    end
        disp(i);
    
    tt=1;newidx = [];
    
    for t = 1:length(idx)
        if isempty(find(selected{n}==idx(t)))
            newidx(tt) = idx(t);
            tt = tt+1;
        end
    end
    idx=[];
    for t = 1:length(newidx);
        idx(t) = newidx(t);
    end
end
end

