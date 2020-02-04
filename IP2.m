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

%% i Negative Image
g1 = (L - 1) - gray;
figure();

subplot(4, 1, 1); imshow(gray);
subplot(4, 1, 2); plot(color, hist, 'r');
subplot(4, 1, 3);
imshow(g1);
subplot(4, 1, 4);
hist_img = imhist(g1);
hist_img = hist_img / (y * x);
color = 0 : 255;
plot(color, hist_img, 'r');

%% ii Thresholding 1
[y, x] = size(gray);
g2 = zeros(y, x, 3);
t = [40, 120, 160] / 255;

figure();
for i = 1:3    
    g2(:, :, i) = im2double(gray);
    g = g2(:, :, i);       
    g(g < t(i)) = 0;
    g(g >= t(i)) = (L - 1) / 255;
    g2(:, :, i) = g;
    
    hist_img = imhist(g);
    hist_img = hist_img / (y * x);
    color = 0 : 255;
    
    subplot(4,3,i);     imshow(gray);
    subplot(4,3,i + 3); plot(color, hist, 'r');
    subplot(4,3,i + 6); imshow(g2(:, :, i),[]); title(['Threshold = ',num2str(t(i) * 255)]);    
    subplot(4,3,i + 9); plot(color, hist_img, 'r');
end

%% iii Thresholding 2
t = [60, 180] / 255; 
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

%% iv Logarithmic Transformation
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

%% v Gamma Transformation
[y, x] = size(gray);
g5 = zeros(y, x, 3);
gamma = [.5, 1.6, 2.5];

figure();
for i = 1:3    
    g5(:, :, i) = im2double(gray);
    g = g5(:, :, i);       
    g = g.^gamma(i);
    g5(:, :, i) = g;
    
    hist_img = imhist(g);
    hist_img = hist_img / (y * x);
    color = 0 : 255;
    
    subplot(4,3,i);     imshow(gray);
    subplot(4,3,i + 3); plot(color, hist, 'r');
    subplot(4,3,i + 6); imshow(g5(:, :, i),[]); title(['Gamma = ',num2str(gamma(i))]);
    subplot(4,3,i + 9); plot(color, hist_img, 'r');
end

%% Q2 Histogram
% It is calculated and shown along with the output itself.