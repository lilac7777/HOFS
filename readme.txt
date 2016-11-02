compute_W(X)  compute unmixing ICA matrix. X---feature space 
data_preprocess proeprocess data to continuous version. dataori---origin data,isdiscrete---if origin data is discrete choose 1 else choose 0.
exp_syn synthetic experiment
get_H_cond compute conditional entropy. X---data,Y---label
get_H_mix compute single or joint entropy.
get_I compute mutual infomation.X---data,Y---label,cons---condition
get_I_selected_ICA select next feature.  selected---selected feature subsets, W---unmixing matrix
HOFS main function 
incre_ICA incremental ICA iteration. Z---data for ICA, W current unmixing matrix
incremental_ICA incremental ICA iteration.  W_---current unmixing matrix, X---data
mod_W compute unmixing ICA matrix.  w---current unmixing matrix, X---data
normdata normalize input data


data format 
data.mat
data should be save in 2-d matrix 
(#sample,#feature)

label.mat
label should be save in 2-d matrix 
(#sample,1)