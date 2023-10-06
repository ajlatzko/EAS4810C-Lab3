% EAS 4810C Lab 3 Supplement
% Data File Generator
% Alexander Latzko

clc; clear;

% Set variables
A = 5;
B = 6;
C = 7;
D = 3;

% Set frequencies (in Hz)
f1 = 200;
f2 = 400;
f3 = 900;

numPts = 100000;
fs = 4000; % Sampling frequency
duration = (1/fs) * numPts;
t = 0:1/fs:duration-1/fs;

% Convert frequencies to rad/s
w1 = 2*pi*f1;
w2 = 2*pi*f2;
w3 = 2*pi*f3;

% Generate points
X = A*cos(w1*t) + B*sin(w2*t) + C*cos(w3*t) + D;

% Save points to binary .mat file
save('Simulated_Data_File.mat','t','X')