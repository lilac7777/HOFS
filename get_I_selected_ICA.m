function [idx,Wout] = get_I_selected_ICA(data,label,selected,W)
global MIL MIH MIHXY Zica COV
Nstructure = size(selected,2);
I = -inf*ones(size(data,2),1);
if nargin == 3
for i = 1:Nstructure
     [Zica{i},W{i},MU{i}] = mymyICA(data(:,selected{i})');
end
end
for index = 1:size(data,2)
    h(index)=0;tmp = 0;
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
           [S1{index}, W1{index}] = incremental_ICA(W{i},[Zica{i};data(:,index)']);%incremental ICA for a new feature candidate
           [S2, W2{index}] = incremental_ICA(W1{index},[Zica{i};data(:,index)';label']);%incremental ICA for label
           S2 = S2';
           S2 = normdata(S2);
            h(index) =h(index)-get_H_mix(S2(:,end),1,size(data,1))- MIH(index)+MIHXY(index);
        end
        if h(index) ==0
            I(index) =  h1;
        else
            I(index) = h(index)/tmp+ h1;
        end
    end
end

idxtmp = find(I == max(I));
idx = idxtmp(1);
if ~exist('W1','var');
    [Zica{1},Wout,~] = incre_ICA(data(:,idx)');
    Zica{1} = data(:,idx)';
else
    Wout = W1{idx};
    Zica{end} = S1{idx};
end
end



