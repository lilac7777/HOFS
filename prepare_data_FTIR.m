function [] = prepare_data_FTIR()

d = 'E:\SCET\FTIR Sample Data';
directory = dir(d);
tmp = 1;
data=[];label=[];
for i = 3 : length(directory)
        name = directory(i).name;
        if name(end-1)=='a' &&name(1) ~='b'&&name(1) ~='t'
            datatmp = importdata(name);
            datatmp = reshape(datatmp,[],1506);
            data = [data;datatmp(1:10,:)];
            label = [label;tmp*ones(10,1)];
          tmp = tmp +1;
        end
end
idx=[];
for i = 1:1506
    if max(data(:,i)) - min(data(:,i))>0.05
        idx = [idx;i];
    end
end
save('dataFTIRori','data');
data = data(:,idx);
save('dataFTIR','data');
save('labelFTIR','label');
save('idx','idx');
end

