function res_mean = F_execute_trees(features)
    if ismac; use_bracket = '/'; else use_bracket = '\'; end;
    addpath(genpath([pwd use_bracket 'Decision_trees']))
    res_all = [];
    No_tree = 20;
    for fn =1:No_tree
        File_name = sprintf('tree%d.csv',fn);
        [ID_Node_arr,ID_Feature_arr,Thres_arr,ID_left_arr,ID_right_arr] = Read_DecisionTree(File_name);
        tree_matrix = [ID_Node_arr,ID_Feature_arr,Thres_arr,ID_left_arr,ID_right_arr];
        res = F_recurse_execute(features, tree_matrix,0);
        res_all = [res_all ,res];        
        %fprintf('Tree %d \n',fn);
    end
    res_mean = mean(res_all);
end
