function[data,idx] = preprocessing(d)
idx = [];
for i = 1:size(d,2)
    maxval = max(d(:,i));
    minval = min(d(:,i));
    diff = maxval-minval;
    if diff>0.2
        idx = [idx;i];
    end
end
data = d(:,idx);


end