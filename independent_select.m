function [index]  = independent_select(data,label,n,pindex)
if nargin == 3
  pindex = [];
end
index = [];
J = zeros(size(data,2));
for i = 1:n
    MI= zeros(size(data,2),1);
    for k = 1:size(data,2);
        
        if isempty(find([pindex;index]==k))
            MI(k) = get_I(data(:,k),label) ;
            for j = 1:length(index)
                
                tmp = get_I(data(:,k),data(:,index(j)))   /length(index); 
                MI(k)=MI(k)- tmp;
            end
        end
    end
    idx = find(MI == max(MI));
    index = [index;idx(1)];
end
end
       