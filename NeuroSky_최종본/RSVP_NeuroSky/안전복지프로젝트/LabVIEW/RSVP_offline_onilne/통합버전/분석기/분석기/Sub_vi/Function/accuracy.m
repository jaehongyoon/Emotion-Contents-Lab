function [acc correct_score] = accuracy(target, selected)
    length = size(target,2);
    correct_score = 0;
    for i = 1:length
        if(target(i) == selected(i))
            correct_score = correct_score+1;
        end
    end
    
    acc = correct_score./length;
    
    