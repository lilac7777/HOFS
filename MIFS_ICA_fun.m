function[selected,rank]= MIFS_ICA_fun(data,label)
global MIL MIH MIHXY Zica
rank = [];
idx = 1:9;
%[label,~] =data_preprocess(label,0);
 Nfeatures = size(data,2);
N =min(100, length(idx));
% data = normdata(data);
% label = normdata(label);
Zica = cell(0);
s = 0;
selected = cell(0);
disp('preparing I');
for i = 1:Nfeatures
    MIL(i) = get_I(data(:,i),label);
    MIH(i) = get_H_mix(data(:,i),1,size(data,1));
    MIHXY(i) = get_H_mix([data(:,i),label],2,length(label));
    MIY = get_H_mix(label,1,size(data,1));
end
combo=1;
W = cell(0);
[ index ,W{combo}]=  get_I_selected_new2(data,label,selected);
s = s + 1;
selected{combo} = index;
disp(index);
rank = [rank;index];
while s < N
      disp([num2str(s),'  selected']);
     [ index ,W{combo}] =  get_I_selected_new2(data,label,selected);
     rank = [rank;index];
     c=[];
     for i = 1:combo
         c(i) = 0;
         Nfea = length(selected{i});
         for j = 1:Nfea
             C = corrcoef([data(:,index),data(:,selected{i}(j))]);
             c(i) = c(i) + C(1,2);
         end
         c(i) = c(i)/Nfea;
     end
     MaxC = max(c);
     if (MaxC <=0.2)
          combo = combo +1;
          selected{combo}=[index];
          s=s+1;
     else
         subidx = find(c==max(c));
         selected{subidx} = [selected{subidx};index];
         s = s+1;
     end
end
save(['syn_selected_feature'],'selected');
save(['syn_selected_idx'],'idx');
end   

