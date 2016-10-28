function [error] = eval_MIFS_LP()
res_folder = 'E:\MIFS\';
data_folder = 'E:\MIFS\MIFSdata\';
 dataset = {'KrVsKp','Lung','Musk2','promoters','spambase','splice','waveform'};
 Methods = {'MIM','mRMR','JMI','CMIM','HOFS'};
 % dataset = {'spambase','splice','waveform'};
 %  dataset = {'promoters','semeion','spambase','splice','waveform'};
for met = 1:4
    mkdir(['RES',Methods{met},'LP']);
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
        for i = 10:length(index)
            [error(i-9,:),wrong(i-9,:),correct(i-9,:)] = tenfoldvalidLP(data,label,index(1:i));
            AMS = min(wrong,2);
            ARAE = min(error,[],2);
            save(['RES',Methods{met},'LP\',dataset{exp},'_wrong'],'wrong');
            save(['RES',Methods{met},'LP\',dataset{exp},'_correct'],'correct');
            save(['RES',Methods{met},'LP\',dataset{exp},'_ARAE'],'ARAE');
            save(['RES',Methods{met},'LP\',dataset{exp},'_AMS'],'AMS');
            save(['RES',Methods{met},'LP\',dataset{exp},'_error'],'error');
            disp(i);
        end
        save(['RES',Methods{met},'LP\',dataset{exp},'_wrongLP'],'wrong');
        save(['RES',Methods{met},'LP\',dataset{exp},'_correctLP'],'correct');
        save(['RES',Methods{met},'LP\',dataset{exp},'_ARAELP'],'ARAE');
        save(['RES',Methods{met},'LP\',dataset{exp},'_AMSLP'],'AMS');
        save(['RES',Methods{met},'LP\',dataset{exp},'_errorLP'],'error');
    end
end
end