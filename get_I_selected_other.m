function [idx] = get_I_selected_other(data,label,selected,method)
global MIL
Nselected = length(selected);
I = -inf*ones(size(data,2),1);
beta = 1;lambda = 1; 
for index = 1:size(data,2)
    h=0;
    if ~isempty(find(selected == index))
        continue;
    else
        htmp(index) = 0;
    end
    if strcmp(method,'mRMR')
        
        for i = 1:Nselected
            htmp(index) = htmp(index) - get_I(data(:,index),data(:,selected(i)));
        end
        htmp(index) = htmp(index)/max(Nselected,1);
    elseif strcmp(method,'JMI')
        for i = 1:Nselected
            htmp(index) = htmp(index) - beta*get_I(data(:,index),data(:,selected(i))) + lambda*get_I(data(:,index),data(:,selected(i)),label);
        end
    elseif strcmp(method,'CMIM')
        htmptmp = [];
        for i = 1:Nselected
            htmptmp(i) = beta*get_I(data(:,index),data(:,selected(i))) - lambda*get_I(data(:,index),data(:,selected(i)),label);
        end
        if Nselected >0
            htmp(index) = -min(htmptmp);
        end
    elseif strcmp(method,'MIM')
        htmp(index) = 0;
    else
        exit(0);
    end
    I(index) = MIL(index) + htmp(index);
end

idxtmp = find(I == max(I));
idx = idxtmp(1);

end



