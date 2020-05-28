function [sets_config] = extract_mean_best_config(test_matrix,index_view)

    [r,c_az] = size(test_matrix);

    sets_config = zeros(4,1);

    n_comb = 1;
    cnt_search_comb = 1;
    already_ismember = 0;
    writen = 0;

    for i = 1:c_az %counts vectors from gen_hconfig_best_az

        [r,size_sets_config] = size(sets_config);

        for cnt_search_comb = 1:size_sets_config
            for col = 1:4  %go through memb_matrix element in each collumn 
                if test_matrix(col,i) == sets_config(col,cnt_search_comb)
                    if col == 4  % config needs to be added to sets_config
                        sets_config(5,cnt_search_comb) = sets_config(5,cnt_search_comb) + 1;
                        already_ismember = 1;
                        writen = 1;
                    end
                else   %if vector is not coincident, goes to next vector
                    break;
                end 
            end
             if already_ismember
                 already_ismember = 0;
                 break;
             end
        end
        if writen == 0
            sets_config(1:4,n_comb) = test_matrix(:,i);
            sets_config(5,n_comb) = 1;
            for cnt_view = 1:length(index_view)
                if n_comb == index_view(cnt_view)
                    sets_config(6,n_comb) = 1;
                    break;
                end
                if cnt_view == length(index_view)
                    sets_config(6,n_comb) = 0;
                end
            end
            n_comb = n_comb + 1;
        end
        writen = 0;
    end

end