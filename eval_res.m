function []=eval_res()
res_folder = 'E:\MIFS\';
data_folder = 'E:\MIFS\MIFSdata\';
dataset = {'KrVsKp','Lung','Musk2','promote','spambase','splice','waveform'};
Methods = {'MIM','mRMR','JMI','CMIM','HOFS'};
% dataset = {'spambase','splice','waveform'};
dataset = {'KrVsKp','Lung','Musk2','Optdigits','promoters','semeion','spambase','splice','waveform','Madelon'};
for met = 1:5
    for exp = 1:length(dataset)
        load(['RES',Methods{met},'\',dataset{exp},'_wrong'],'wrong');
        WRONG{exp}(met,:,:) = wrong;
        load(['RES',Methods{met},'\',dataset{exp},'_globalI'],'globalI')
        GLOBALI{exp}(met) = globalI;
       load(['RES',Methods{met},'\',dataset{exp},'_correct'],'correct');
        CORRECT{exp}(met,:,:) = correct;
        load(['RES',Methods{met},'\',dataset{exp},'_ARAE'],'ARAE');
        load(['RES',Methods{met},'\',dataset{exp},'_AMS'],'AMS');
         load(['RES',Methods{met},'\',dataset{exp},'_error'],'error');
         ERROR{exp}(met,:,:) = error;
    end
end
end