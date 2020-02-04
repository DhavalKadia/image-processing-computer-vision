close all; clear all; clc

%% Assignment 3 [Dhaval Kadia : 101622808]

%% i. Feature detection

%GF = [1,2,1;2,4,2;1,2,1] / 16;
GF = fspecial('gaussian', [3,3], 2); % Not using [9, 9] size

%i1 = rgb2gray(imread('viprectification_deskLeft.png'));
%i2 = rgb2gray(imread('viprectification_deskRight.png'));

i1 = rgb2gray(imread('left.jpg'));
i2 = rgb2gray(imread('right.jpg'));

[x, y] = size(i1);

I1 = zeros(x + 2, y + 2);
I1(2 : x + 1 , 2 : y + 1) = i1;
I2 = zeros(x + 2, y + 2);
I2(2 : x + 1, 2 : y + 1) = i2;

Gx = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
Gy = [-1, 0, 1; -2, 0, 2; -1, 0, 1];

[x, y] = size(i1);
I1x = zeros(x, y);
I1y = zeros(x, y);
I2x = zeros(x, y);
I2y = zeros(x, y);

[x, y] = size(I1x);
for i = 1 : x
    for j = 1 : y
        I1x(i, j) = sum(sum(I1(i : i + 2, j : j + 2) .* Gx));        
        I1y(i, j) = sum(sum(I1(i : i + 2, j : j + 2) .* Gy));
        I2x(i, j) = sum(sum(I2(i : i + 2, j : j + 2) .* Gx));        
        I2y(i, j) = sum(sum(I2(i : i + 2, j : j + 2) .* Gy));
    end
end

I1x2 = I1x .* I1x;
I1y2 = I1y .* I1y;
I1xy = I1x .* I1y;

I2x2 = I2x .* I2x;
I2y2 = I2y .* I2y;
I2xy = I2x .* I2y;

S1x2 = zeros(x, y);
S1y2 = zeros(x, y);
S1xy = zeros(x, y);

S2x2 = zeros(x, y);
S2y2 = zeros(x, y);
S2xy = zeros(x, y);

i1x2 = zeros(x + 2, y + 2);
i1x2(2 : x + 1 , 2 : y + 1) = I1x2;
i1y2 = zeros(x + 2, y + 2);
i1y2(2 : x + 1 , 2 : y + 1) = I1y2;
i1xy = zeros(x + 2, y + 2);
i1xy(2 : x + 1 , 2 : y + 1) = I1xy;

i2x2 = zeros(x + 2, y + 2);
i2x2(2 : x + 1 , 2 : y + 1) = I2x2;
i2y2 = zeros(x + 2, y + 2);
i2y2(2 : x + 1 , 2 : y + 1) = I2y2;
i2xy = zeros(x + 2, y + 2);
i2xy(2 : x + 1 , 2 : y + 1) = I2xy;

for i = 1 : x
    for j = 1 : y        
        S1x2(i, j) = sum(sum(i1x2(i : i + 2, j : j + 2) .* GF));
        S1y2(i, j) = sum(sum(i1y2(i : i + 2, j : j + 2) .* GF));
        S1xy(i, j) = sum(sum(i1xy(i : i + 2, j : j + 2) .* GF));
        
        S2x2(i, j) = sum(sum(i2x2(i : i + 2, j : j + 2) .* GF));
        S2y2(i, j) = sum(sum(i2y2(i : i + 2, j : j + 2) .* GF));
        S2xy(i, j) = sum(sum(i2xy(i : i + 2, j : j + 2) .* GF));
    end
end

%%

%Th1 = 1000000000;
%Th2 = 1000000000;

Th1 = 30000000000;
Th2 = 30000000000;

location1 = [1, 1];
location2 = [1, 1];

for i = 1 : 3 : x - 3
    for j = 1 : 3 : y - 3
        
        k1 = -1000000;  k2 = -1000000;
        p1x = 1; p1y = 1; p2x = 1; p2y = 1;
        
        for m = 0 : 2
            for n = 0 : 2
                M1 = [S1x2(i + m,j + n), S1xy(i + m,j + n); S1xy(i + m,j + n), S1y2(i + m,j + n)];
                M2 = [S2x2(i + m,j + n), S2xy(i + m,j + n); S2xy(i + m,j + n), S2y2(i + m,j + n)];
                
                R1 = det(M1) - 0.04 * (trace(M1) ^ 2);
                R2 = det(M2) - 0.04 * (trace(M2) ^ 2);
        
                if R1 > Th1 && R1 > k1
                    k1 = R1;
                    p1x = i; p1y = j;                        
                end  
        
                if R2 > Th2 && R2 > k2
                    k2 = R2;
                    p2x = i; p2y = j;                        
                end
            end
        end
        location1 = [location1; [p1x, p1y]];
        location2 = [location2; [p2x, p2y]]; 
    end
end
FD1 = insertMarker(i1,location1,'size',10);
figure(); imshow(FD1);

FD2 = insertMarker(i2,location2,'size',10);
figure(); imshow(FD2);

%% ii. Feature description

corners1 = cornerPoints(location1);
[features1, valid_corners1] = extractFeatures(i1, corners1);

corners2 = cornerPoints(location2);
[features2, valid_corners2] = extractFeatures(i2, corners2);

%% iii. Feature matching

link = zeros(valid_corners1.Count,1);

for i = 1 : valid_corners1.Count
    Diff = 10000000;
    for j = 1 : valid_corners2.Count
        diff = sum(abs(features1.Features(i,:) - features2.Features(j,:)));
        if diff < Diff
            Diff = diff;
            link(i) = j;
        end
    end
end

%%

indexPairs = zeros(valid_corners1.Count, 2);
indexPairs(:,1) = [1:valid_corners1.Count];
indexPairs(:,2) = link;

matchedPoints1 = valid_corners1(indexPairs(:,1),:);
matchedPoints2 = valid_corners2(indexPairs(:,2),:);

figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2); % For plotting the points       