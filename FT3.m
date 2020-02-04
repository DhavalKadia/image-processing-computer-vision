%Dhaval Kadia [101622808]
close all; clear all; clc

%%
f = double(imread('img1.tif'));
pad = 25;
f = padarray(f, [pad,pad], 'symmetric', 'both'); % Zero padding
F = fft2(f);
[N,M] = size(f);
f1 = ([1:M] - (floor(M/2) + 1)) / M;
f2 = ([1:N] - (floor(N/2) + 1)) / N;
[F1,F2] = meshgrid(f1, f2);
D0=.1; % Cutoff frequency
n=2; % Order of the filter
D=sqrt(F1.^2+F2.^2);
D(D==0)=eps; % prevent divide by zero
figure(); imshow( f(pad+1:end-pad,pad+1:end-pad),[] ); title('Input');

%% (a)
g = HFE(.05, 2, 0, D, F, f1, f2, pad, 'D0 = .05, n = 2');
g = HFE(.1, 2, 0, D, F, f1, f2, pad, 'D0 = .1, n = 2');
g = HFE(.2, 2, 0, D, F, f1, f2, pad, 'D0 = .2, n = 2');

g = HFE(.1, 1, 0, D, F, f1, f2, pad, 'D0 = .1, n = 1');
g = HFE(.1, 2, 0, D, F, f1, f2, pad, 'D0 = .1, n = 2');

%% (b)
G = HFE(.3, 3, .5, D, F, f1, f2, pad, 'D0 = .1, n = 2');

%% (c)
eq = histeq(uint8(G));

%% (d)
figure(); imshow(f, []);    title('Original');
figure(); imshow(G, []);    title('Enhanced');
figure(); imshow(eq);       title('Histogram Equalization');

function hfe = HFE(D0, n, K, D, F, f1, f2, pad, Title)
    H = 1 ./ (1 + (D ./ D0).^(-2*n));
    hfe = K + H;   %High-Frequency-Emphasis
    
    figure; mesh(f1,f2,hfe);
    xlabel('f_1 cycles/sample');
    ylabel('f_2 cycles/sample'); title(Title);
    
    H2 = ifftshift(hfe);
    G = H2.*F;
    hfe = ifft2(G);

    figure(); imshow(hfe(pad+1:end-pad,pad+1:end-pad),[]); title(Title);
end