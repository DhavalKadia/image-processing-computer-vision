close all; clear all; clc

%% Assignment 2 [Dhaval Kadia : 101622808]

%%
L = 256;
gray = imread('cameraman.tif');
%gray = rgb2gray(img);
[y, x] = size(gray);

figure();
subplot(2, 1, 1);
imshow(gray);
subplot(2, 1, 2);
hist = imhist(gray);
hist = hist / (y * x);
color = 0 : 255;
plot(color, hist, 'r');

%% i Thresholding
t = [50, 170] / 255; 
g3 = im2double(gray);      
g3(g3 < t(1)) = 0;
g3(g3 >= t(2)) = (L - 1) / 255;
figure(); 

subplot(4, 1, 1); imshow(gray);
subplot(4, 1, 2); plot(color, hist, 'r');
subplot(4, 1, 3);
imshow(g3, []);
subplot(4, 1, 4);
hist_img = imhist(g3);
hist_img = hist_img / (y * x);
color = 0 : 255;
plot(color, hist_img, 'r');

%% ii Logarithmic Transformation
g4 = im2double(gray); 
g4 = 106.3035 * log(1 + g4);
figure(); 

subplot(4, 1, 1); imshow(gray);
subplot(4, 1, 2); plot(color, hist, 'r');
subplot(4, 1, 3);
imshow(g4, []);
subplot(4, 1, 4);
hist_img = imhist(g4);
hist_img = hist_img / (y * x);
color = 0 : 255;
plot(color, hist_img, 'r');

%% iii Histogram
% It is calculated and shown along with the output itself.

%% Q2 Histogram Equalization
hist = 0 : 255;
hist = imhist(gray) / (x * y);

for i = 2 : 256
    hist(i) = hist(i) + hist(i - 1);
end
hist = uint8(hist * (L - 1));

q2 = zeros(y, x);
for i = 1 : y
    for j = 1 : x
        q2(i, j) = hist(gray(i, j) + 1);
    end
end

figure();
subplot(1, 2, 1); imshow(gray);   title('Original image');
subplot(1, 2, 2); imshow(q2, []); title('Histogram-equalized image');