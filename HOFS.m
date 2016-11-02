function[selected,rank]= HOFS(data,label)
global MIL MIH MIHXY Zica COV

if nargin == 0
    datafolder = '...';%please put your data in this folder
    load('data.mat');load('label.mat');
    load([datafolder,'\',d(exp).name]);
    load([datafolder,'\',d(exp+11).name]);
end
%% mutual info feature selection
[data,idx] =data_preprocess(data,0); 
[label,~] =data_preprocess(label,0);
Nfeatures = size(data,2);
Nsamples= size(data,1);
N =min(100, length(idx));%Number of selected features
Zica = cell(0);%ICA space feature
Stmp = []; Atmp = []; tmp = 1;rank = [];
s = 0;
selected = cell(0);
disp('preparing single feature entropy');
for i = 1:Nfeatures
    MIL(i) = get_I(data(:,i),label);
    MIH(i) = get_H_mix(data(:,i),1,size(data,1));
    MIHXY(i) = get_H_mix([data(:,i),label],2,length(label));
    MIY = get_H_mix(label,1,size(data,1));
end
combo=1;
W = cell(0);%ICA unmixing matrix
[ index ,W{combo}]=  get_I_selected_ICA(data,label,selected,W);
s = s + 1;
selected{combo} = index;
rank = [rank;index];
while s < N
      disp([num2str(s),' feature selected']);
      [index ,W{combo}] =  get_I_selected_ICA(data,label,selected,W);
      rank = [rank;index];
      argcov=[];
     for i = 1:combo
         argcov(i) = 0;
         Nfea = length(selected{i});
         for j = 1:Nfea
             C = corrcoef([data(:,index),data(:,selected{i}(j))]);
             argcov(i) = argcov(i) + C(1,2);
         end
         argcov(i) = argcov(i)/Nfea;
     end
     MaxC = max(argcov);
     if (MaxC <=0.2)
            Atmp = [];
            n = length(Zica);
            Zica{n+1}=Zica{n}(end,:);
             Zica{n}(end,:)=[];
             W{combo+1} =   W{combo}(end,end);
             W{combo} =   W{combo}(1:end-1,1:end-1);
            combo = combo +1;
            selected{combo}=[index];%a new subset
            s=s+1;
            disp(index);
     else
            subidx = find(argcov==MaxC);
            selected{subidx} = [selected{subidx};index];
            s = s+1;
            disp(index);
     end
end
save(['selected_feature'],'selected');
save(['selected_idx'],'idx');
end   

