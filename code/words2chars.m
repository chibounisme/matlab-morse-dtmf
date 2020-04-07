function [char_bounds] = words2chars(signal, fs, dot_duration)
    char_bounds = [];
    i = 1;
    curr_l_bound = 1;
    while i < numel(signal)-3*dot_duration*fs
        if sum(signal(i:i+round(3*dot_duration*fs))) == 0
           char_bounds = [char_bounds; curr_l_bound i-1];
           i = i + round(3*dot_duration*fs);
           curr_l_bound = i + 1;
        else
           i = i + 1;
        end
    end
    char_bounds = [char_bounds; curr_l_bound numel(signal)];
end