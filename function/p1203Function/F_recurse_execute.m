function res = F_recurse_execute(features, tree_matrix,node_id)
        row = find(tree_matrix(:,1)==node_id);
        feature_id = int16(tree_matrix(row,2)); 
        feature_thres = tree_matrix(row,3);
        left_child = int16(tree_matrix(row,4));
        right_child = int16(tree_matrix(row,5));
        
        if(feature_id == -1)
            res = feature_thres;
        else
            feature_value = features(feature_id+1);% Matlab: array start with 1
            if ( feature_value< feature_thres)
                res = F_recurse_execute(features, tree_matrix,left_child);
            else
                res = F_recurse_execute(features, tree_matrix,right_child);
            end
        end
end