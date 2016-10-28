function [Zica, A , mu] = mymyICA(Z,W)
%--------------------------------------------------------------------------
% Syntax:       Zica = myICA(Z,r);
%               Zica = myICA(Z,r,dispFlag);
%               [Zica A T mu] = myICA(Z,r);
%               [Zica A T mu] = myICA(Z,r,dispFlag);
%               
% Inputs:       Z is an (d x n) matrix containing n samples of an
%               d-dimensional random vector
%               
%               r is the desired number of independent components
%               
%               [OPTIONAL] dispFlag = {true false} sets the stdout print
%               state. The default value is dispFlag = true
%               
% Outputs:      Zica is an (r x n) matrix containing the r independent
%               components - scaled to variance 1 - of the input samples
%               
%               A and T are the ICA transformation matrices such that
%               Zr = T \ pinv(A) * Zica + repmat(mu,1,n);
%               is the r-dimensional ICA approximation of Z
%               
%               mu is the (d x 1) sample mean of Z
%               
% Description:  This function performs independent component analysis (ICA)
%               on the input samples using the FastICA algorithm with 
%               Gaussian negentropy
%               
% Author:       Brian Moore
%               brimoor@umich.edu
%               
% Date:         April 26, 2015
%--------------------------------------------------------------------------

% Knobs
eps = 1e-6;         % Convergence criteria
maxSamples = 800;  % Max # data points in sample mean calculation
maxIters = 30;     % Maximum # iterations

% Center and whiten input data

 [Zc mu] = myCenter(Z);

% Parse whitened data
[d n] = size(Zc);
if (n > maxSamples)
    % Truncate data for sample mean calculations
    Zct = Zc(:,randperm(n,maxSamples));
else
    % Full data
    Zct = Zc;
end
if nargin == 1
 [~,W] = compute_W(Zc);
else
    W = mod_W(W,Zc);
end
% Transformation matrix
A = W;

% Independent components
Zica = A * Zc;
