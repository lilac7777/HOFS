clear variables
num=100000;
y = randi([1,2],num,1)-1;
x(:,1) = randn(num,1)+y;
x(:,2) = randn(num,1)+y/1.5;
x(:,3) = randn(num,1)+y/2.25;
x(:,4) = randn(num,1)+x(:,1);
x(:,5) = randn(num,1)+x(:,1);
x(:,6) = randn(num,1)+x(:,2);
x(:,7) = randn(num,1)+x(:,2);
x(:,8) = randn(num,1)+x(:,3);
x(:,9) = randn(num,1)+x(:,3);
y = y/5;
Z = cov(x);
% figure

%imshow(Z,[],'InitialMagnification',10000)
[selected,rank]= HOFS(x,y);