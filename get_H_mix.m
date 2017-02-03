function[H] = get_H_mix(x,n_features,n_sample)
joint_states = 1;
for i = 1:n_features
    [num_states(i),norm_vec{i}] = normaliseArray(x(:,i));
    joint_states = joint_states*num_states(i);
end
bias(1) = 1;
for i = 2:n_features
    bias(i) = bias(i-1)*num_states(i-1);
    
end
jointStateCounts = zeros(joint_states,1);
for i = 1:n_sample
    idx= 1;
    for j = 1:n_features
        idx = idx+ norm_vec{j}(i)*bias(j);
    end
     jointStateCounts(idx) =jointStateCounts(idx)+ 1;

end
jointStateProbs = jointStateCounts/n_sample;
epi = 0.0000001;
val = 0;
H = 0;
for i = 1:joint_states
    val = jointStateProbs(i);
    if (val>0)
        H = H  -val*log(val);
    end
end


end


function[num_state, normvec] = normaliseArray(inp)

minval = min(inp);
maxval = max(inp);
normvec =floor((inp - minval)/0.2);

num_state =  (maxval - minval)/0.2 + 1;

num_state = floor(num_state);







end