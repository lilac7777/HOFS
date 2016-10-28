function[error,wrong,correct] = tenfoldvalidLP(data,label,index)
%%divide trainset
uni = unique(label);
Ncls = length(uni);
for i = 1:Ncls
    settmp = find(label == uni(i));
    rd = randperm(length(settmp));
    clsset{i}  = settmp(rd);
    nsample(i) = length(settmp);
end
for  i = 1:10
    trainsample = [];testsample=[];trainlabel=[];
    for j = 1:Ncls
        testsample =[testsample; clsset{j}(floor(nsample(j)/10)*(i-1)+1:floor(nsample(j)/10)*i)];
       % trainsample = [trainsample;clsset{j}([1:floor(nsample(j)/10)*(i-1),floor(nsample(j)/10)*i+1:end])];
        trainsample = [trainsample;clsset{j}];
        labeltmp = zeros(Ncls,1);
        labeltmp(j) = 1;
       % trainlabel=[trainlabel,repmat(labeltmp,1,length( clsset{j}([1:floor(nsample(j)/10)*(i-1),floor(nsample(j)/10)*i+1:end])))];
       trainlabel=[trainlabel,repmat(labeltmp,1,length( clsset{j}))];
    end
    test = data(testsample,index);testlabel = label(testsample);
    train = data(trainsample,index);
    tmp = 1;
    W = Linearclsf(trainlabel,train');
    correct(i) = 0;wrong(i) = 0;
    pred = W*test';
    
    for j = 1:length(testsample)
        p = find(pred(:,j)==max(pred(:,j)));
        if uni(p) == testlabel(j)
            correct(i) = correct(i) +1;
        else
            wrong(i) = wrong(i)+1;
        end
    end
    error(i) = wrong(i)/length(testsample);
end
end

            
        
        
        
        
