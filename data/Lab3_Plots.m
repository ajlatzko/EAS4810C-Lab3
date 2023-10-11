% EAS 4810C Lab 3
% Plot generation

%% Plot V vs dP

clc; clear; close all;

dP = [0.230164
0.465510
0.697333
0.937918
1.173332
1.399124
1.643272
1.869627
2.110773
2.579601];

V = [2.848186
3.196808
3.417166
3.588717
3.730116
3.861450
3.971786
4.072112
4.160987
4.341081];
    
figure;
hold on;
plot(V,dP,'k.','MarkerSize',20);
ylabel('P_{amb} - P_{ts} (inH_2O)')
xlabel('Voltage (V)')
grid on;
box off;
matlab2tikz('cal.tex','height','\fheight','width','\fwidth')

%% Plot anemometer calibration curve

clc; clear; close all;

V = [2.848186
3.196808
3.417166
3.588717
3.730116
3.861450
3.971786
4.072112
4.160987
4.341081];

Vel = [7.524611
10.701145
13.097422
15.189660
16.989322
18.552126
20.105755
21.445843
22.786963
25.190799];

err = [0.04
0.04
0.04
0.04
0.04
0.04
0.04
0.04
0.04
0.04];

x = linspace(V(1), V(length(V)));
trend = 0.005847742*x.^4 - 0.893933615*x.^3 + 11.22711866*x.^2 - 34.84761768*x + 35.9679161;
    
figure;
c = '#A6A6A6';
hold on;
errorbar(V,Vel,err,'k.','MarkerSize',20);
plot(x,trend,'Color',c,'LineWidth',2.5);
xlabel('Voltage (V)')
ylabel('Velocity (m/s)')
grid on;
box off;
matlab2tikz('calCurve.tex','height','\fheight','width','\fwidth')

%% Plot velocity profile

clc; clear; close all;

pos = [-8.0
-7.0
-6.0
-5.0
-4.0
-3.0
-2.0
-1.0
0.0
1.0
2.0
3.0
4.0
5.0
6.0
7.0
8.0
1.0
-0.9];

Vel = [17.63302121
17.66766483
17.57029602
17.36951483
17.09044626
16.76010295
15.86014131
14.5694144
14.01914389
15.00864139
16.22321569
16.80958078
17.15024428
17.41338612
17.52997475
17.53175424
17.57363723
15.0918459
14.46785862];
    
figure;
hold on;
plot(Vel,pos,'k.','MarkerSize',20);
ylabel('Position (cm)')
xlabel('Velocity (m/s)')
grid on;
box off;
matlab2tikz('vProfile.tex','height','\fheight','width','\fwidth')

%% Plot velocity profile

clc; clear; close all;

pos = [-8.0
-7.0
-6.0
-5.0
-4.0
-3.0
-2.0
-1.0
0.0
1.0
2.0
3.0
4.0
5.0
6.0
7.0
8.0];

Std = [0.173818062
0.239959547
0.483283962
0.919045562
1.299192436
1.661433296
2.108859546
2.417891131
2.529128388
2.351792533
1.967515128
1.519674248
1.136372042
0.724403928
0.380683268
0.222989909
0.162576465];
    
figure;
hold on;
plot(Std,pos,'k.','MarkerSize',20);
ylabel('Position (cm)')
xlabel('Standard Deviation of Velocity (m/s)')
grid on;
box off;
matlab2tikz('vStdDev.tex','height','\fheight','width','\fwidth')