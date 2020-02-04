close all; clear all; clc
%% Assignment 1 [Dhaval Kadia : 101622808]

%%


%% 1. Loading the Image.
A = imread('checkershadow.jpg');
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

%% 7. Click on those two points, and hit the Enter key.
figure(); imshow(A);
fprintf('\nClick on those two points, and hit the Enter key.')

impixelinfo;
[col, row, data] = impixel(A);

fprintf('\nPixel 1: ')
disp(data(1, :));
fprintf('\nPixel 2: ')
disp(data(2, :));

%% 8. Finding Pixel per Inch. Do the Zoom In/Out from Tools menu, as per requirement.
R = imread('xruler.tif');
figure(); imshow(R);
line = imdistline;

api = iptgetapi(line);
pause();
dist = api.getDistance();
fprintf('Pixels per Inch = %g Pixels\n',dist);
% (comment:) Pixels per Inch = 300 Pixels

%% 9. Calculation of distance covered and velocity
% The (perpendicular) distance between camera and vehicle, dist = 100 meter
%
% The half distance covered by image is x
%
% tan(15 degree (half of the FOV)) = x / dist
%
% So, x = tan(15 degree) * dist
%
% x = 0.268 * 100 = 26.8 meter
%
% So, the total horizontal distance covered by (512 pixels) image is 2x = 53.6 meter
%
% So, One pixel covers 53.6 / 512 = 0.1046875 meter
%
% The City Block Distance is calculated as the distance in x plus the distance in y
%
% Total distance (in pixels)covered by the moving vehicle is |10 - 10| + |115 - 15| = 100 pixels
%
% Total real world distance covered = Distance covered by one pixel * Distance covered in pixels = 0.1046875 * 100 = 10.46875 meters
%
% This difference is calculated between 1st frame and 30th frame, and the camera is having 30 fps, so calculation represents time of 1 second
%
% So, its velocity is 10.46875 meter / second
