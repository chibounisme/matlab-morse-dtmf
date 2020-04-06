# Un convertisseur Texte-Morse en utilisant le décodage DTMF

Faisant partie de mes études, je propose comme application un convertisseur Texte-Morse.
Vu le mécanisme sur lequel est basé le code Morse  (Les 'dots' et les 'dashes'), un texte "source" sera codé en code Morse et envoyé dans un canal téléphonique en utilisant le décodage DTMF.

Le code Morse utilise deux types d'impulsions:
- Des impulsions courtes représentées par un point => .
- Des impulsions longues représentées par un trait => -

Chaque caractère (alphanumérique) est reprsenté en code Morse par une combinaison unique de ces deux impulsions.

Par exemple:
Le mot 'SOS' se traduit en code Morse comme suit:
- S: ...
- O: ---
- SOS: ...---...


En utilisant le décodage DTMF, on assigne deux fréquences particuliéres pour chaque impulsion, on prend comme exemple:
- 445 Hz et 1825Hz pour les impulsions courtes
- 556 Hz et 1996Hz pour les impulsions longues

Ces impulsions doivent couler des intervalles de temps fixes.
D'après Wikipedia, le code Morse international respecte les régles suivantes:
1. Un tiret est égal à trois points.
2. L’espacement entre deux éléments d’une même lettre est égal à un point.
3. L’espacement entre deux lettres est égal à trois points.
4. L’espacement entre deux mots est égal à sept points.

D'ou la nécessité de définir la durée d'un point.

Je propose alors les deux fonctions suivantes:

1- [signal] = text2morse(input_text, fs, dot_duration, output_file, playFile):  qui permet de générer un fichier WAV qui est la représentation en code  Morse d'un texte en entrée.

Les paramètres sont:
- input_text: Une variable contenant le texte d'entrée
- fs: La fréquence d'échantillonage du fichier généré
- dot_duration: La durée en secondes d'un point
- output_file: Le nom du fichier généré
- playFile: un paramètre booléen, qui si mis en 'true', jouera le fichier WAV généré.

La sortie représente le signal généré après le décodage DTMF en code Morse.

2- [output_text] = morse2text(input_file, fs, dot_duration): qui permet de décoder un message codé en code Morse à partir d'un fichier WAV lu en entrée.

Les paramètres sont:
- input_file: Le nom du fichier 
- fs: La fréquence d'échantillonage du fichier WAV
- dot_duration: La durée en secondes d'un point

La seule sortie est une chaine de caractères représentant le texte source après décodage.

