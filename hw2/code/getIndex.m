function y = getIndex(x1, x2, topK)
    fs = 2560;
    healthArr = [];
    faultArr = [];
    xSize = size(x1);

    for i = 1:xSize(2)

        [xHealth, fftHP1] = self_fft(x1(:, i), fs);
        healthArr = [healthArr fftHP1];
        
        [xFault, fftFP1] = self_fft(x2(:, i), fs);
        faultArr = [faultArr fftFP1];
    end
    meanDiff = (mean(healthArr, 2) - mean(faultArr, 2)).^2;
    varSum = var(healthArr,0,2) + var(faultArr,0,2);
    score = meanDiff ./ varSum;
    
    [out,idx] = sort(score, 'descend');
    y = idx(1:topK, 1);
    disp('top-3 idx:');
    disp(idx(1:3, 1));
    disp('top-3 value:');
    disp(out(1:3, 1));
   
end