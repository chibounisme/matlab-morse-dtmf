function [elem_bounds] = chars2elems(signal)
    elem_bounds = [];
    l_bound = 1;
    looking_for_zeros = true;
    for i = 1:numel(signal)
        if signal(i) == 0 && signal(i+1) == 0 && looking_for_zeros == true
            elem_bounds = [elem_bounds; l_bound i-1];
            looking_for_zeros = false;
        elseif signal(i) ~= 0 && looking_for_zeros == false
            looking_for_zeros = true;
            l_bound = i;
        end
    end
    elem_bounds = [elem_bounds; l_bound numel(signal)];
end