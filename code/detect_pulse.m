function value = detect_pulse(signal, fs, minPeakHeight)
    targetFrequencies = [445, 556, 1825, 1996];
    k = {2270, 2552};
    v = {'.', '-'}; 
    DialupKeysMap = containers.Map(k, v);
    Nfft = 2048;    
    axe_f = (0:Nfft/2-1)*(fs/Nfft);
    ffs = real(fft(signal, Nfft));
    ffs = smooth(smooth(smooth(fftshift(ffs))))';
    ffs = ffs(size(ffs, 2)/2 + 1:end); 
    [peaks, locs] = findpeaks(ffs, axe_f, 'NPeaks', 2, 'MinPeakHeight', minPeakHeight);
    locs = interp1(targetFrequencies, targetFrequencies, locs, 'nearest');
    if isKey(DialupKeysMap, locs(1) + locs(2))
        value = DialupKeysMap(locs(1) + locs(2));
    else
        value = -1;
    end