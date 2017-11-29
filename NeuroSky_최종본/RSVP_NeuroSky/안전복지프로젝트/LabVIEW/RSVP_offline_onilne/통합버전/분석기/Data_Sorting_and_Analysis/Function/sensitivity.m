function [acc1 correct_score] = sensitivity(target, ERP)
    length = size(target,2);
    data = ERP(target);
    correct_score = sum(data);
    acc1 = correct_score./length;
    