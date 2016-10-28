function [H] = get_H(prob)
epi = 0.0000001;
prob = prob + epi;
H = -sum(prob.*log(prob),1);


end