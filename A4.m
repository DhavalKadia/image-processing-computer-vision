close all; clear all; clc

%% Assignment 4 [Dhaval Kadia : 101622808]

%% 1. Holistic CSLBP based Output
image = imread('cameraman.jpg');
image = image(:,:,2);

[y, x] = size(image);

I = zeros(y + 2, x + 2);
output = zeros(y, x);

I(2 : y + 1 , 2 : x + 1) = image;

[y, x]=size(I);
Th = 0;
for i=2:y-1
    for j=2:x-1
        b0 = ((I(i,j+1) - I(i, j-1) > Th ) * 2^0 );        
        b1 = ((I(i+1,j+1) - I(i-1, j-1) > Th ) * 2^1 );
        b2 = ((I(i+1,j) - I(i-1, j) > Th ) * 2^2 );
        b3 = ((I(i+1,j-1) - I(i - 1, j + 1) > Th ) * 2^3 );
        
        output(i, j) = b3 + b2 + b1 + b0;
    end    
end

figure(); imshow(output);

%% Local CSLBP features 
image = imread('image.jpg');
image = image(:,:,2);

[y, x] = size(image);

m = int16(y / 16);
n = int16(x / 16);
h2 = zeros(m * n * 16, 1);
hNorm = zeros(m * n, 1);

count = 1;
for a = 1:2
    for b = 1:2
        h = CSLBP(image((a-1)*16+1:a*16, (b-1)*16+1:b*16));
        h2((count-1)*16+1:count*16) = h;
        hNorm(count) = norm(h);
        count = count + 1;
    end
end

h2          % Features
figure(); hist(h2);  
hNorm       % L2-Norm
figure(); hist(hNorm);


%% Function
function h = CSLBP(I)
h=zeros(16,1);
[y, x]=size(I);
Th = 0;
for i=2:y-1
    for j=2:x-1
        b0 = ((I(i,j+1) - I(i, j-1) > Th ) * 2^0 );        
        b1 = ((I(i+1,j+1) - I(i-1, j-1) > Th ) * 2^1 );
        b2 = ((I(i+1,j) - I(i-1, j) > Th ) * 2^2 );
        b3 = ((I(i+1,j-1) - I(i - 1, j + 1) > Th ) * 2^3 );
        
        total = b3 + b2 + b1 + b0;
        h(total+1) = h(total+1) + 1;
    end    
end
end