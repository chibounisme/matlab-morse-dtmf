function [sig] = text2morse(input_text, fs, dot_duration, output_file, playFile)
    input_text = strtrim(input_text);
    dot = [445 1825];
    dash = [556 1996];
    sig = [];
    k = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}; 
    v = {"01111" "00111" "00011" "00001" "00000" "10000" "11000" "11100" "11110" "11111" "01" "1000" "1010" "100" "0" "0010" "110" "0000" "00" "0111" "101" "0100" "11" "10" "111" "0110" "1101" "010" "000" "1" "001" "0001" "011" "1001" "1011" "1100"};
    morseCodeMap = containers.Map(k, v);
    words = strsplit(input_text, ' ');
    for i = 1:numel(words)
        word = cell2mat(words(i));
        for j = 1:numel(word)
            impulse = convertStringsToChars(morseCodeMap(word(j)));
            for k = 1:numel(impulse) 
                if impulse(k) == '0'
                    t = 0+1/fs:1/fs:dot_duration;
                    sig = [sig sin(2*pi*dot(1)*t) + (sin(2*pi*dot(2)*t))];
                else
                    t = 0+1/fs:1/fs:3*dot_duration;
                    sig = [sig sin(2*pi*dash(1)*t) + (sin(2*pi*dash(2)*t))];
                end
                if k ~= numel(impulse)
                    sig = [sig zeros(1, round(dot_duration*fs))];
                end
            end
            if j ~= numel(word)
                sig = [sig zeros(1, 3*round(dot_duration*fs))];
            end
        end
        if i ~= numel(words)
            sig = [sig zeros(1, 7*round(dot_duration*fs))];
        end
    end
    sig = sig ./(max(abs(sig)));
    audiowrite(output_file, sig, fs);
    fprintf("Signal généré sauvegardé avec succés dans '%s'!\n", output_file);
    if playFile == true
        fprintf("Fichier généré en cours de jeu!\n");
        playblocking(audioplayer(sig, fs));
        fprintf("Fichier joué avec succés!\n");
    end
end