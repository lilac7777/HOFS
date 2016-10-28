function[H] = get_H_con(y,joint)
H = get_H(joint) - get_H(y);
end