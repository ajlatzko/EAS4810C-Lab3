%This program creates the Spectra
%Created by BHL on 9-18-23
clc; clear;


T = readtable('Spectra.xlsx');
%Number of bins
n = 10;

%Number of elements in each bin
N = 1000;
Fs = 2000;
%Generate frequency domain limits
f = linspace(0, Fs/2, N/2);
f = (f*0.01905)/17.67;
filenames = {'centerlineSpectra.tex';
    'topSpectra.tex';
    'insideSpectra.tex';
    'outsideSpectra.tex'};
for kk = 1:4
    X = table2array(T(:,kk));

    %Initialize empty variables
    Data_File = cell(1,n);
    Data_File_with_Mean_Subtracted = Data_File;
    means = zeros(1,n);
    meanCheck = zeros(1,n);
    FFT_array = Data_File;
    amp = zeros(4,N);

    %Process bins
    for ii = 1:n
        %Place data into bins
        Data_File{ii} = X((ii-1)*N+1:ii*N);
        %Find mean of each bin
        means(ii) = mean(Data_File{ii});
        %Subtract mean from data
        Data_File_with_Mean_Subtracted{ii} = Data_File{ii} - means(ii);
        %Place values into array to check means
        meanCheck(ii) = mean(Data_File_with_Mean_Subtracted{ii});
        %Perform FFT on each bin
        tempFFT = fft(Data_File_with_Mean_Subtracted{ii},N)/N;
        %Multiply by complex conjugate
        FFT_array{ii} = tempFFT.*conj(tempFFT);
    end

    %Average elements across bins
    for ii = 1:N
        sum = 0;
        for jj = 1:n
            sum = sum + FFT_array{jj}(ii);
        end
        amp(kk,ii) = sum/n;
    end
    
    %Plot data
    figure(kk);
    plot(f,amp(kk,1:500),'b');
    xlabel('Strouhal Number')
    ylabel('Variance (m^2/s^2)')
    xlim([0 1])
    grid on;
    box off;
    matlab2tikz(filenames{kk},'height','\fheight','width','\fwidth')
end