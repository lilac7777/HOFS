function [] = prepare_feature_data()
datafolder = 'E:\MIFS\MIFSdata';
directory = dir(datafolder);
for i = 3:length(directory)
    filename = [datafolder,'\',directory(i).name];
    data = importdata(filename);
    if i == 3
        save('dataLung','data');
    elseif i==4
       save('labelLung','data');
    end
end




end
