function [error] = eval_MIFS()
res_folder = 'E:\MIFS\';
data_folder = 'E:\MIFS\MIFSdata\';
 dataset = {'KrVsKp','Lung','Musk2','promote','spambase','splice','waveform'};
 Methods = {'MIM','mRMR','JMI','CMIM','HOFS'};
 % dataset = {'spambase','splice','waveform'};
   dataset = {'KrVsKp','Lung','Musk2','Optdigits','promoters','semeion','spambase','splice','waveform','Madelon'};
for met = 1:5
    mkdir(['RES',Methods{met}]);
    for exp = 1:length(dataset)
        load([data_folder,'data',dataset{exp}]);
        load([data_folder,'label',dataset{exp}]);
        load([res_folder,Methods{met},'\',dataset{exp},'_selected_feature']);
        if exist([res_folder,Methods{met},'\',dataset{exp},'_selected_idx']);
            load([res_folder,Methods{met},'\',dataset{exp},'_selected_idx']);
        else
            idx = 1:size(data,2);
        end
        tmp = 1;index=[];
        if strcmp(Methods{met},'HOFS')
            for i = 1:length(selected)
                for j = 1:length(selected{i})
                    index(tmp) = idx(selected{i}(j));
                    tmp = tmp+1;
                end
            end
        else
            for i = 1:length(selected)
                    index(i) = idx(selected(i));
            end
        end
        d= data(1:min(300,size(data,1)),index(1:11));
%         l = normdata(label)/2;
%         d = normdata(d)/3;
        l = label;
        d = d-min(min(d));
        maxval = max(max(d))
        if maxval>5
            ratio = 5/maxval;
            d = round(d*ratio);
        end
        globalI(exp,met) = getHdiscrete(d,11,size(d,1)) ;%- getHdiscrete([d,l(1:size(d,1),1)],10+1,size(d,1))
%         for i = 10:min(length(index),30)
%             [error(i-9,:),wrong(i-9,:),correct(i-9,:)] = tenfoldvalid(data,label,index(1:i));
%             AMS = mean(wrong,2);
%             ARAE = mean(error,2);
%             save(['RES',Methods{met},'\',dataset{exp},'_wrong'],'wrong');
%             save(['RES',Methods{met},'\',dataset{exp},'_globalI'],'globalI');
%             save(['RES',Methods{met},'\',dataset{exp},'_correct'],'correct');
%             save(['RES',Methods{met},'\',dataset{exp},'_ARAE'],'ARAE');
%             save(['RES',Methods{met},'\',dataset{exp},'_AMS'],'AMS');
%             save(['RES',Methods{met},'\',dataset{exp},'_error'],'error');
%             disp(i);
%         end
%         save(['RES',Methods{met},'\',dataset{exp},'_wrong'],'wrong');
%         save(['RES',Methods{met},'\',dataset{exp},'_correct'],'correct');
%         save(['RES',Methods{met},'\',dataset{exp},'_ARAE'],'ARAE');
%         save(['RES',Methods{met},'\',dataset{exp},'_AMS'],'AMS');
%         save(['RES',Methods{met},'\',dataset{exp},'_error'],'error');
    end
end
end