function[error,wrong,correct] = tenfoldvalid(data,label,index)
%%divide trainset
uni = unique(label);
Ncls = length(uni);NSAMPLE = 0;
for i = 1:Ncls
    settmp = find(label == uni(i));
    rd = randperm(length(settmp));
    clsset{i}  = settmp(rd);
    nsample(i) = length(settmp);
	
end

NSAMPLE = sum(nsample);
ratio = min(3000/NSAMPLE,1);
for i = 1:Ncls
    clsset{i}  =clsset{i}(1:floor(length(clsset{i})*ratio));
    nsample(i) = length( clsset{i} );
	
end
for  i = 1:10
    trainsample = [];testsample=[];
    for j = 1:Ncls
        testsample =[testsample; clsset{j}(floor(nsample(j)/10)*(i-1)+1:floor(nsample(j)/10)*i)];
        for k = j+1:Ncls
            trainsample = [clsset{j}([1:floor(nsample(j)/10)*(i-1),floor(nsample(j)/10)*i+1:end]);clsset{k}([1:floor(nsample(k)/10)*(i-1),floor(nsample(k)/10)*i+1:end])];
            %trainsample = [clsset{j};clsset{k}];
            train = data(trainsample,index);
            %trainlabel = label(trainsample);
            trainlabel=[zeros(length(clsset{j}([1:floor(nsample(j)/10)*(i-1),floor(nsample(j)/10)*i+1:end])),1) ;ones(length(clsset{k}([1:floor(nsample(k)/10)*(i-1),floor(nsample(k)/10)*i+1:end])),1)];
            %trainlabel=[zeros(length(clsset{j}),1) ;ones(length(clsset{k}),1)];
            options.MaxIter = 1000000;
           % model{j,k} = svmtrain(train,trainlabel,'kktviolationlevel',0.1,'kernel_function','rbf','rbf_sigma',2,'Options', options);
           model{j,k} = svmtrain(train,trainlabel,'kktviolationlevel',0.05,'boxconstraint',2,'Options', options);
        end
    end
    test = data(testsample,index);testlabel = label(testsample);
    tmp = 1;
    for j = 1:Ncls
        for k = j+1:Ncls
            [res{j,k}] = svmclassify(model{j,k},test);
        end
    end
    correct(i) = 0;wrong(i) = 0;
    pred = oneVsAllSvm(res);
    for j = 1:length(testsample)
        
        if uni(pred(j)) == testlabel(j)
            correct(i) = correct(i) +1;
        else
            wrong(i) = wrong(i)+1;
        end
    end
    error(i) = wrong(i)/length(testsample);
end
end

            
        
        
        
        
