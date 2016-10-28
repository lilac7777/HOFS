function [idx] = get_I_selected(data,label,selected)
global MIL MIH MIHXY
Nstructure = size(selected,2);
I = -inf*ones(size(data,2),1);
%  for i = 1:Nstructure
%      htmp(i) = get_joint_H_ICA(data(:,selected{i}));
%  end
for index = 1:size(data,2)
    h=0;tmp = 0;
    flag = 0;
    for i = 1:Nstructure
        if (~isempty(find(selected{i} == index)))
            flag = 1;
            break;
        end
    end
    if flag == 0
        h1 = MIL(index);
        for i = 1:Nstructure
            tmp = tmp + length(selected{i});
            h = h - MIH(index)  + get_joint_H_ICA(data(:,[index;selected{i}]))...
                +MIHXY(index)  - get_joint_H_ICA([label,data(:,[index;selected{i}])]);
        end
        if h ==0
            I(index) =  h1;
        else
            I(index) = h/tmp + h1;
        end
    end
end

idxtmp = find(I == max(I));
idx = idxtmp(1);
f = fopen('MI.txt','a+');
for index = 1:size(data,2)
    fprintf(f,'%f\t',I(index));
end
fprintf(f,'\n');
fclose(f);
end



