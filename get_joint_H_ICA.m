function [H] = get_joint_H_ICA(data,W,Zica)
%% label in last
if nargin==1
%     [Zica,A,T,mu] = myICA(data');
    [Zica,A,mu] = mymyICA(data');
    Zica = Zica';
    W = A;
elseif nargin==2
%     [Zica,A,T,mu] = myICA(data',W);
    [Zica,A,mu] = mymyICA(data',W);
    Zica = Zica';
    W = A;
end
h = 0;
for i = 1:size(data,2)
    h = h+ get_H_mix(Zica(:,i),1,size(data,1));
end
% h = h -log( mean(tmpup)/tmpdown);
%H = h - log(norm(W));
ref = get_H_mix(data,size(data,2),size(data,1));
H = h - log(abs(det(W)));
disp([num2str(H-ref),'rate:',num2str((H-ref)/ref)]);
end