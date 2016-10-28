function[sample] = gen_sample(label,num)
sample = [];
uni = unique(label);
for i = 1:length(num)
    settmp = find(label ==uni( i));
    
    rd = randperm(length(settmp));
    sample =[ sample;settmp(rd(1:num(i)))];
    

end

end