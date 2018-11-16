% Assignment 2: Tennis Ball Locator
% CMPT 412
% Alec Pershick
% 301190478

close all; % Clears previous figures each run
 image=imread('images/OneBallVerticalLarge.jpg');
%image=imread('images/OneBallLetteringVerticalLarge.jpg');
% image=imread('images/TwoBallsVerticalLarge.jpg');
% image=imread('images/OneBallLetteringLarge.jpg');
%image=imread('images/TwoBallsTouchingVerticalLarge.jpg');




% Converting the image to black and white in order to more easily detect edges
bw=(double(image(:,:,1))+double(image(:,:,2))+double(image(:,:,3)))/(3*255);

% Canny edge detection with threshold of 0.1 and sigma of 60 
ec4 = edge(bw,'canny', .2, 50);
multi=cat(4,bw,ec4);
figure; imshow(ec4);
title('Edges found with Canny Edge Detection');

cs=300.5;           % Generate disks of radius 300.5 (must always be something + 1/2)
border=2;           % Border to go around the disk
ms=2*(cs+border);   % Mask size for the disk
msh=floor(ms/2)+1;  % Midpoint of the disk
mask=-ones(ms,ms);  % Initialize mask with a bunch of (-1)s

% Fill inside the disk with 1s (white)
for i=1:ms
    for j=1:ms
        if (i-msh)^2+(j-msh)^2<=cs^2
            mask(i,j)=1;
        end
    end
end

c=conv2(mask,ec4);  % Convolve mask with thresholded image to 
                    % measure how disk-like each region is

y=find(c>1500);     % Locations of candidate circular disks are 
                    % those with high values after the convolution

res=zeros(size(c)); % Important here that 'c' is in fact bigger 
                    % than 'bw' because of convolution boundaries.

res(y)=1;           % Mark all candidate locations in res

% Display the original image vs the approximate tennis ball locations
figure; 
subplot(1,2,1);
imshow(bw);
subplot(1,2,2);
imshow(res);
title('White dots indicate approximate centers of tennis balls');

result=bwmorph(res,'shrink',Inf);  %shrink connected objects to single points

[xcenter, ycenter]=find(result>0);

'Number of circles found is: '

length(xcenter)

'Circle locations are: '

[xcenter ycenter]

