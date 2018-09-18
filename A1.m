%%% CMPT 412: Assignment #1 %%%
%%% Alec Pershick 301190478 %%%

image = imread('coolcat.jpg');
% image=zeros(6,6,3); a(:,:,1)=magic(6); a(:,:,2)=magic(6)'; a(:,:,3)=ones(6)/2; a=a/max(a(:));
figure() 
subplot(1,2,1);
imshow(image); % Original image
% shrink(image);
zoom(image);
% subsample(image, 4);
% dim(image, 2);
% contrast_compress(image);
% reflect(image);
% myrotate(image);

%Reduces the size of an image by taking only pixels every "factor" pixels apart
function subsample(image, factor)
    image = image(1:factor:end,1:factor:end,:);
    subplot(1,2,2);
    imshow(image);
    size(image)
end

% return an image rotated by 90 degrees clockwise
function myrotate(image)
    permuted = permute(image, [2 1 3]);
    reflected_permuted = permuted(:,(end:-1:1),:);
    subplot(1,2,2);
    imshow(reflected_permuted);
end

% return an image that is reflected about the vertical axis
function reflect(image)
    image=image(:,(end:-1:1),:);
    subplot(1,2,2);
    imshow(image);
end

% return an image that is scaled to be darker by �fraction�
function dim(image,fraction)
   imshow(image);
   dimmed = image/fraction;
   subplot(1,2,2);
   imshow(dimmed);
end

% take the square root of each colour channel and then
% rescale so that the image uses the full [0,1] intensity range.
% This is just an arbitrary modification--- the resulting image
function contrast_compress(image)
    firstChannel = sqrt(double(image(:,:,1)));
    secondChannel = sqrt(double(image(:,:,2)));
    thirdChannel = sqrt(double(image(:,:,3)));
    combinedChannels = firstChannel + secondChannel + thirdChannel;
    rescaledByMax = combinedChannels / max(combinedChannels(:));
    rescaledImage = rescaledByMax - min(rescaledByMax(:));
    subplot(1,2,2);
    imshow(rescaledImage);
end

% Makes the image half as large in both height and width. Each pixel should be the
% average of 4 pixels. Assume input image has even number of rows/columns.
function shrink(image)
    oldSize = size(image);
    newSize = oldSize(1) * 2;
    newImage = zeros(newSize,newSize,3);
    newImage((1:2:end),(1:2:end),:) = image;
    newImage((2:2:end),(2:2:end),:) = image;
    subplot(1,2,2);
    imshow(newImage);
    size(newImage)
    newImage
end

% Makes the image twice as large in both height and width. Each pixel in the input
%image is replicated to become 4 pixels in the output image.
function zoom(image)
    oldSize = size(image);
    newSize = oldSize(1) * 2;
    newImage = zeros(newSize,newSize,3);
    newImage((1:2:end),(1:2:end),1) = image(:,:,1);
    newImage((2:2:end),(2:2:end),2) = image(:,:,2);
    newImage((2:2:end),(2:2:end),3) = image(:,:,3);
    subplot(1,2,2);
    imshow(newImage);
    size(newImage)
    newImage
end



