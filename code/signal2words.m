function [word_bounds] = signal2words(signal, fs, dot_duration)
    word_bounds = [];
    i = 1;
    curr_l_bound = 1;
    while i < numel(signal)-7*dot_duration*fs
        if sum(signal(i:i+round(7*dot_duration*fs))) == 0
           word_bounds = [word_bounds; curr_l_bound i-1];
           i = i + round(7*dot_duration*fs);
           curr_l_bound = i + 3;
        else
           i = i + 1;
        end
    end
    word_bounds = [word_bounds; curr_l_bound numel(signal)];
end