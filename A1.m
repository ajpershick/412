image = imread('coolcat.jpg'); 
figure; imshow(image);
% shrink(image);
% zoom(image);
% subsample(image, 4);
% dim(image, 2);
% contrast_compress(image);
% reflect(image);
% myrotate(image);

% function subsample(image, factor)
%     %Reduces the size of an image by taking only pixels every �factor� pixels apart
% end

% function shrink(image)
%    % Makes the image half as large in both height and width. Each pixel should be the
%    % average of 4 pixels. Assume input image has even number of rows/columns.
% end

% function zoom(image)
%    % Makes the image twice as large in both height and width. Each pixel in the input
%     %image is replicated to become 4 pixels in the output image.
% end

% function myrotate(image)
%    % return an image rotated by 90 degrees clockwise
% end

function reflect(image)
   % return an image that is reflected about the vertical axis
    image=image(:,(end:-1:1),:);
    figure; imshow(image);
    end

function dim(image,fraction)
   % return an image that is scaled to be darker by �fraction�
   imshow(image);
   dimmed = image/fraction;
   figure; imshow(dimmed);
end

function contrast_compress(image)
   % take the square root of each colour channel and then
   % rescale so that the image uses the full [0,1] intensity range.
   % This is just an arbitrary modification--- the resulting image
    contrasted = sqrt(double(image(:,:,1)));
    figure; imshow(contrasted);
    firstChannel = sqrt(double(image(:,:,1)));
    secondChannel = sqrt(double(image(:,:,2)));
    thirdChannel = sqrt(double(image(:,:,3)));
    combinedChannels = firstChannel + secondChannel + thirdChannel;
    rescaledByMax = combinedChannels / max(combinedChannels(:));
    rescaledImage = rescaledByMax - min(rescaledByMax(:));
   figure; imshow(rescaledImage);
end


