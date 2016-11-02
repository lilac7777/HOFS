function [d,idx] = data_preprocess(dataori,isdiscrete)
%preprocess data
if nargin==1
    isdiscrete = 1;
end
idx = [];
for i = 1:size(dataori,2)
    maxval = max(dataori(:,i));
    minval = min(dataori(:,i));
    diff = maxval-minval;
    if diff>0.1
        idx = [idx;i];
    end
end

data = dataori(:,idx);
datatmp = data;
if isdiscrete
while((size(data,1)<500))
    data = [data;datatmp];
end
for i = 1:size(data,2)
    val = unique(data(:,i));
    if length(val)>0.6*size(data,1)
        d(:,i)  = data(:,i);
    else
        lsb = val(2)-val(1);
        noise = lsb*rand(size(data,1),1)-lsb/2;
        d(:,i) = data(:,i)+noise;
    end
end

else
    d = data;
end
    d=  normdata(d);%normalize data


end