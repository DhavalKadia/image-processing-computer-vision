close all; clear all; clc

%% Assignment 3 [Dhaval Kadia : 101622808]

%%
img = im2double(imread('moon.tif'));
figure(); imshow(img,[]);
[x, y] = size(img);
I = zeros(x + 2, y + 2);
I(2 : x + 1 , 2 : y + 1) = img;

%% 1
LO = [0, -1, 0; -1, 4, -1; 0, -1, 0];
L = zeros(x, y);
for i = 1 : x
    for j = 1 : y
        L(i, j) = sum(sum(I(i : i + 2, j : j + 2) .* LO));  
    end
end

L = normalize(L);
figure(); imshow(L,[]);

%% 2
S = img + L;
S = normalize(S);
figure(); imshow(S,[]);

%% 3
Sx = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
Sy = [-1, 0, 1; -2, 0, 2; -1, 0, 1];

Gx = zeros(x, y);
for i = 1 : x
    for j = 1 : y
        Gx(i, j) = abs(sum(sum(I(i : i + 2, j : j + 2) .* Sx)));
        Gy(i, j) = abs(sum(sum(I(i : i + 2, j : j + 2) .* Sy)));
    end
end

Gxy = Gx .* Gx + Gy .* Gy;

Gx = normalize(Gx);
Gy = normalize(Gy);
Gxy = normalize(Gxy);
%figure(); imshow(Gx,[]);
%figure(); imshow(Gy,[]);
figure(); imshow(Gxy,[]);

%% 4
GO = [1,4,7,4,1;
    4,16,26,16,4;
    7,26,41,26,7;
    4,16,26,16,4;
    1,4,7,4,1] / 273;

gxy = zeros(x + 4, y + 4);
gxy(3 : x + 2 , 3 : y + 2) = Gxy;
G = zeros(x, y);
for i = 1 : x
    for j = 1 : y
        G(i, j) = sum(sum(gxy(i : i + 4, j : j + 4) .* GO));  
    end
end

G = normalize(G);
figure(); imshow(G,[]);

%% 5
Mask = S .* G;

Mask = normalize(Mask);
figure(); imshow(Mask,[]);

%% 6
Sh = img + Mask;
Sh = normalize(Sh);

figure(); imshow(Sh,[]);

%% 7
g = zeros(x, y, 3);
gamma = [.5, .85, 1.6, 2.5];
color = 0 : 255;

figure();
for x = 1:4    
    g(:, :, x) = im2double(Sh);
    g = g(:, :, x);       
    g = g.^gamma(x);
    g(:, :, x) = g;
    
    subplot(1,4,x); imshow(g(:, :, x),[]); title(['Gamma = ',num2str(gamma(x))]);
end

%%
function N = normalize(n)
    N = n;
    minR = min(N(:));
    maxR = max(N(:));
    N = (N - minR) / (maxR - minR);
end