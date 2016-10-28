function[label] = oneVsAllSvm(result)
Ncls = size(result,2);
pred = zeros(size(result{1,2},1),Ncls);

for i = 1:size(result{1,2},1)
    for j = 1:Ncls
        for k = j+1:Ncls
            if result{j,k}(i) == 0
                pred(i,j) = pred(i,j) +1;
            else
                pred(i,k) = pred(i,k) +1;
            end
        end
    end
    tmp = find(pred(i,:) == max(pred(i,:) ));
    label(i) =tmp(1);
end
label = label';






end
