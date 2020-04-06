% Demo
clear variables;
close all;

in_txt = 'SOS';
fs = 8192;
dot_duration = 0.05;
out_file = 'out_hello_world';
sig = text2morse(in_txt, fs, dot_duration, out_file, true);

% Représentation temporelle du signal
axe_t = 0+1/fs:1/fs:size(sig, 2)/fs;
plot(axe_t, sig);
title('Audio Généré');
xlabel('T (secondes)');
ylabel('S(T)')

% Sauvegarde de la représentation temporelle du signal en une image
saveas(gcf,'signal.png')
