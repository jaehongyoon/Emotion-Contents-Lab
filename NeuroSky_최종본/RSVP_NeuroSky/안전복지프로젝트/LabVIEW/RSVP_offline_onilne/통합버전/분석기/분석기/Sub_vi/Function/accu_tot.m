function [acc correct_score] = accu_tot(online_label, ERP)
    length = size(ERP,1);
    correct_score = 0;
    for i = 1:length
        if(ERP(i) == online_label(i))
            correct_score = correct_score+1;
        end
    end
    
    acc = correct_score./length;
