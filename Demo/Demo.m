% Demo
%%%%%
% text2morse 

clear variables;
close all;
clc;

in_txt = 'JE COMPTE DE 1 JUSQUA 456';
fs = 8192;
dot_duration = 0.05;
% Utiliser une durée minimale dun point égale à 50 millisecondes!
dot_duration = max(dot_duration, 0.05);
out_file = 'out.wav';
fprintf('Le message codé est: %s!\n', in_txt);
out_sig = text2morse(in_txt, fs, dot_duration, out_file, true);

% Représentation temporelle du signal
axe_t = 0+1/fs:1/fs:size(out_sig, 2)/fs;
plot(axe_t, out_sig);
title('Audio Généré');
xlabel('T (secondes)');
ylabel('S(T)')

% Sauvegarde de la représentation temporelle du signal en une image
saveas(gcf,'signal.png')

fprintf("Appuyez sur n'importe quel boutton pour aller au test suivant!\n");
pause;
fprintf('\n');
%%%%%

%%%%%
% morse2text

clear variables;
close all;

dot_duration = 0.05;
in_file = 'out.wav';
out_txt = morse2text(in_file, dot_duration);
fprintf("Le message décodé à partir du fichier '%s' est: %s!\n", in_file, out_txt);
