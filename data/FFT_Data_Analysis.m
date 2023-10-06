% EAS 4810C Lab 3 Supplement
% FFT Data Analysis
% Alexander Latzko

clc; clear;

% Read simulated data file
load('Simulated_Data_File.mat')

% Create array to store points sequentially
ptsPerArray = 1000;
numArrays = length(X)/ptsPerArray;
Data_File = zeros(numArrays,ptsPerArray);

% Write the data into the cell array
for arrayNum = 1:numArrays
    for val = 1:ptsPerArray       
        % Insert correct points into Data_File
        Data_File(arrayNum,:) = X((arrayNum-1)*ptsPerArray+1:arrayNum*ptsPerArray);
    end
end

% Calculate the means of each Data_File array
means = zeros(numArrays,1);
for arrayNum = 1:numArrays
    means(arrayNum) = mean(Data_File(arrayNum,:));
end

% Create new array to store data with mean subtracted
Data_File_with_Mean_Subtracted = zeros(numArrays,ptsPerArray);

% Subtract the mean of each array and store
for arrayNum = 1:numArrays
    Data_File_with_Mean_Subtracted(arrayNum,:) = Data_File(arrayNum,:) - means(arrayNum);
end

% Check if new arrays have a mean of zero
new_means = zeros(numArrays,1);
for arrayNum = 1:numArrays
    new_means(arrayNum) = mean(Data_File_with_Mean_Subtracted(arrayNum,:));
end

% Create new array to store FFT data
FFT_array = zeros(numArrays,ptsPerArray);

% FFT each array
for arrayNum = 1:numArrays
    FFT_array(arrayNum,:) = fft(Data_File_with_Mean_Subtracted(arrayNum,:),ptsPerArray)/ptsPerArray;
end

% Multiply each element in each array by its complex conjugate
for arrayNum = 1:numArrays
    FFT_array(arrayNum,:) = FFT_array(arrayNum,:) .* conj(FFT_array(arrayNum,:));
end

% Find the average of the elements of the arrays
average = zeros(ptsPerArray,1);
for val = 1:ptsPerArray
    average(val) = mean(FFT_array(:,val));
end

% Plot
t_step = t(2) - t(1);
fs = 1/t_step;
L = length(X);

ampl = average(1:500);
freq = linspace(0,fs/2,length(ampl));

figure;
plot(freq,ampl)
xlim([0,1000])
title('Test File')
xlabel('Frequency in Hz')
ylabel('Variance at each frequency')