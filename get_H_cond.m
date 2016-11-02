function [H] = get_H_cond(X,Y)
%%compute H(X|Y)
data1 = [X,Y];
data2 = [Y];
H = get_H_mix(data1,size(data1,2),size(data1,1)) - get_H_mix(data2,size(data2,2),size(data2,1));
end