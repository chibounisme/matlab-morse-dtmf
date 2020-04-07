function [text] = morse2text(input_file, dot_duration)
    [signal, fs] = audioread(input_file);
    text = "";
    key = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}; 
    v = {"01111" "00111" "00011" "00001" "00000" "10000" "11000" "11100" "11110" "11111" "01" "1000" "1010" "100" "0" "0010" "110" "0000" "00" "0111" "101" "0100" "11" "10" "111" "0110" "1101" "010" "000" "1" "001" "0001" "011" "1001" "1011" "1100"};
    morseCodeMap = containers.Map(key, v);
    %figure;
    %plot(signal);
    % d�couper en mots
    words = signal2words(signal, fs, dot_duration);
    for i = 1:size(words, 1)
        % d�couper chaque mot en caract�res
        chars = words2chars(signal(words(i,1):words(i,2)), fs, dot_duration) + words(i,1) - 1;
        word = "";
        for j = 1:size(chars, 1)
            % d�couper chaque caract�re en impulsions �l�mentaires
            elems = chars2elems(signal(chars(j,1):chars(j,2))) + chars(j, 1) - 1;
            % d�tecter le type d'impulsion
            char_code = "";
            for k = 1:size(elems, 1)
                if detect_pulse(signal(elems(k,1):elems(k,2)), fs, 15) == '-'
                    char_code = char_code + '1';
                else
                    char_code = char_code + '0';
                end
            end
            for kk = keys(morseCodeMap)
                if morseCodeMap(cell2mat(kk)) == char_code
                   word =  word + kk;
                end
            end
        end
        text = text + word;
        if i ~= size(words, 1)
            text = text + ' ';
        end
    end
end