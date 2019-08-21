function [x, y, topIndex] = getTopPriorSet(x, topK)
    fs = 2560;
    yFFT = [];
    xSize = size(x)

    for i = 1:xSize(2)
        [xLocation, fftP1] = self_fft(x(:, i), fs); 
        yFFT = [yFFT fftP1];
    end
    
    disp('fft')
    size(yFFT(:, 1:20))
    meanDiff = (mean(yFFT(:, 1:20), 2) - mean(yFFT(:, 21:40), 2)).^2;
    varSum = var(yFFT(:, 1:20),0,2) + var(yFFT(:, 21:40),0,2);
    score = meanDiff ./ varSum;
    size(score)
    fish_x = linspace(0,19201, 19201);
    size(fish_x)

    [out,idx] = sort(score, 'descend');
    topIndex = idx(1:topK, 1);
    disp('top-3 idx:');
    disp(idx(1:topK, 1));
    disp('top-3 value:');
    disp(out(1:topK, 1));

    y = yFFT(topIndex, :).';
end