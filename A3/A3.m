% CMPT 412 Assignment 3: Photometric Stereo
% Alec Pershick
% 301190478

clear;
close all; % Clears previous figures each run

% Reading the images into the program and convert to greyscale
image1 = rgb2gray(imread('synthetic/sphere1.tif'));
image2 = rgb2gray(imread('synthetic/sphere2.tif'));
image3 = rgb2gray(imread('synthetic/sphere3.tif'));

% Showing the images together
images = cat(2, image1, image2, image3);
montage(images);
title('The three input images showing three different light sources')

% Setting up the light vectors
lightStraightAbove = [0, -1, -0.25];
lightLeftCorner = [1, -0.5, -0.25];
lightRightCorner =  [-1, -0.5, -0.25];

[Gmag, Gdir] = imgradient(image1);
% surfnorm(Gmag);
figure
imshowpair(Gmag, Gdir, 'montage');
title('Gradient Magnitude, Gmag (left), and Gradient Direction, Gdir (right)')

[imgHeight, imgWidth, ~] = size(image1);

[Gx1, Gy1] = imgradientxy(image1);
[Gx2, Gy2] = imgradientxy(image2);
[Gx3, Gy3] = imgradientxy(image3);

PQMatrix = zeros(imgHeight, imgWidth);

E1 = zeros(imgHeight, imgWidth);
E2 = zeros(imgHeight, imgWidth);
E3 = zeros(imgHeight, imgWidth);

for h = 1:imgHeight
    for w = 1:imgWidth
        E1(h,w) = ((Gx1(h, w)*lightStraightAbove(1)) + (Gy1(h, w)*lightStraightAbove(2)) + ((-1)*lightStraightAbove(3)));
        E2(h,w) = ((Gx2(h, w)*lightLeftCorner(1)) + (Gy2(h, w)*lightLeftCorner(2)) + ((-1)*lightLeftCorner(3)));
        E3(h,w) = ((Gx3(h, w)*lightRightCorner(1)) + (Gy3(h, w)*lightRightCorner(2)) + ((-1)*lightRightCorner(3)));
    end
end

intensities = cat(2, E1, E2, E3);
montage(intensities);
title('The intensities E1, E2, and E3')