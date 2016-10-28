function[]= MIFS_Other(method)
datafolder = 'E:\MIFS\MIFSdata';
d = dir(datafolder);
for exp =4:13
    load([datafolder,'\',d(exp).name]);
    load([datafolder,'\',d(exp+11).name]);
    mkdir(method);
    clear global;
    global MIL MIHX MIHXY MIHY
    [data,idx] =data_preprocess(data,0);
    [label,~] =data_preprocess(label,0);
    Nfeatures = size(data,2);
    Nsamples= size(data,1);
    N =min(100, length(idx));
    data = normdata(data);
    label = normdata(label);Zica = cell(0);
    s = 0;selected =[];
    for i = 1:Nfeatures
        MIL(i) = get_I(data(:,i),label);
        MIHX(i) = get_H_mix(data(:,i),1,size(data,1));
        MIHXY(i) = get_H_mix([data(:,i),label],2,length(label));
        MIHY = get_H_mix(label,1,size(data,1));
    end
    while s < N
        [index] =  get_I_selected_other(data,label,selected,method);
        s=s+1;
        selected(s)=[index];
        disp([num2str(s),' features selected']);
    end
    save([method,'\',d(exp).name(5:end-4),'_selected_feature'],'selected');
    save([method,'\',d(exp).name(5:end-4),'_selected_idx'],'idx');
end

end   

