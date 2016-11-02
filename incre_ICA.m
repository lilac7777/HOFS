function [Zica, A , mu] = incre_ICA(Z,W)
maxSamples = 800;  % Max # data points in sample mean calculation

 [Zc mu] = myCenter(Z);

[d n] = size(Zc);
if (n > maxSamples)
    % Truncate data for sample mean calculations
    Zct = Zc(:,randperm(n,maxSamples));
else
    % Full data
    Zct = Zc;
end
if nargin == 1 %
 [~,W] = compute_W(Zc);
else
    W = mod_W(W,Zc); %incremental ICA
end
% Transformation matrix
A = W;

% Independent components
Zica = A * Zc;
