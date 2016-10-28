function [data] = normdata(data)
%%data  Nsample by Nfeatures
epi = 0.000000001;
data = data - repmat(min(data,[],1),size(data,1),1);
data = data./repmat(max(data,[],1)+epi*ones(1,size(data,2)),size(data,1),1);
end