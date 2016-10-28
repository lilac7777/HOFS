function [idx,Wout] = get_I_selected_new(data,label,selected,W)
global MIL MIH MIHXY Zica
Nstructure = size(selected,2);
I = -inf*ones(size(data,2),1);
%  for i = 1:Nstructure
%      htmp(i) = get_joint_H_ICA(data(:,selected{i}));
%  end
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
%            [S, W1] = mod_W(W{i},[Zica{i};data(:,index)']);
%            [S, W2] = mod_W(W1,[Zica{i};data(:,index)';label']);
             [S1{index}, W1{index}] = incremental_ICA(W{i},[Zica{i};data(:,index)']);
           [S2, W2{index}] = incremental_ICA(W1{index},[Zica{i};data(:,index)';label']);
           S2 = S2';
     S2 = normdata(S2);
            h(index) =h(index)-get_H_mix(S2(:,end),1,size(data,1))- MIH(index)+MIHXY(index);
          %  disp(h);
        end
        if h(index) ==0
            I(index) =  h1;
        else
            I(index) = h(index)/40/tmp+ h1;
        end
    end
end

idxtmp = find(I == max(I));
idx = idxtmp(1);
if ~exist('W1','var');
    [Zica{1},Wout,~] = mymyICA(data(:,idx)');

else
    Wout = W1{idx};
    Zica{end} = S1{idx};
end
end



