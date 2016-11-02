function[I] = get_I(x,y,cons)
%%compute I(x:y|cons)
if nargin == 2
    data1 = x;
    data2 = y;
    I = get_H_mix(x,size(x,2),size(x,1)) - get_H_cond(data1,data2);
else
    I = get_H_cond(x,cons) - get_H_cond(x,[y,cons]);
end
end
