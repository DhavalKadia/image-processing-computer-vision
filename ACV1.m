close all; clear all; clc
%% Assignment 1 [Dhaval Kadia : 101622808]

%%


%% 1. Loading the Image.
T = imread('turing.jpg');

%% 2. Showing the Image
figure(); imshow(T);

%% 3. Showing one of the channels / Gray Image.
green = T(:,:,2);
figure(); imshow(green);

green = rgb2gray(T);
figure(); imshow(green);

%% 4. Cropping by defaule / By user Input. Select the crop, and double click on it.
green2a = imcrop(green, [20, 50, 100, 200]);
figure(); imshow(green2a);

green2b = green(20 : 100, 20: 200);
figure(); imshow(green2b);

[crop, rect] = imcrop(green);
crop = imcrop(green, rect);
rect;
imshow(crop)

%% 5. Binary Image after converting it to Double.
B = double(green);
B = B / 255;
figure(); imshow(B,[])

%% 6. Histogram is of Black and White image.
[Y, X] = size(B);
subplot(2, 1, 1);
imshow(B);
subplot(2, 1, 2);
hist_img = imhist(B);

hist_img = hist_img / (Y * X);
color = 0 : 1 : 255;
plot(color, hist_img, 'r');

%% 7. LFOV. Do the Zoom In/Out from Tools menu, as per requirement.
R = imread('cup_chip.tif');
[row, col] = size(R); 
row = row / 3; col = col / 3; % This is an RGB Image
fprintf('col = %g \n', col);

figure(); imshow(R);
line = imdistline;

api = iptgetapi(line);
pause();
dist = api.getDistance();
fprintf('dist = %g \n', dist);
meterPerPixel = 109.8 / dist;
fprintf('Meter per Pixel = %g meter\n', meterPerPixel);
LFOV = col * meterPerPixel;
fprintf('LFOV = %g meter\n', LFOV);

%% 8. Calculation of distance covered and velocity
depth = 100;
halfFOV = 15;
frameDiff = 30;
FPS = 30;
time = frameDiff / FPS;
halfDist = tan(halfFOV * pi/180) * depth;
totalDist = 2*halfDist;

distPerPixel = totalDist / 512;
euclidianDistance = sqrt((10 - 10)^2 + (115 - 15)^2);

distance = euclidianDistance * distPerPixel;
velocity = distance / time;

fprintf("\nDistance crossed = %g meter",distance);
fprintf("\nVelocity = %g meter / s\n",velocity);