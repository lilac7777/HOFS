function [predict_label]= linear_SVM(data,label,trainsample,testsample,index)
train = data(trainsample,index);
test = data(testsample,index);
trainlabel = label(trainsample);
testlabel = label(testsample);
%svmstruct = svmtrain(train,trainlabel,'autoscale',false,'boxconstraint',16,'kktviolationlevel',0.05,'kernel_function','rbf','rbf_sigma',2);
model = svmtrain(train,trainlabel);
[predict_label,accuracy,asd] = svmpredict(testlabel,test,model);
% pred = svmclassify(svmstruct,data(testsample,index));
% correct = 0;wrong = 0;
% for i = 1:length(testsample)
%     if pred(i) == label(testsample(i))
%         correct = correct +1;
%     else
%         wrong = wrong  + 1;
%     end
% end
% error =wrong/(correct+wrong);
error = 1-0.01*accuracy(1);

end