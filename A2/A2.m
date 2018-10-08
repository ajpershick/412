% Assignment 2: Tennis Ball Locator
% CMPT 412
% Alec Pershick
% 301190478

close all;
image=imread('images/TwoBallsVerticalLarge.jpg');
bw=(double(image(:,:,1))+double(image(:,:,2))+double(image(:,:,3)))/(3*255);
%Run examples of Canny edge detection
ec4 = edge(bw,'canny', .1, 60);

multi=cat(4,bw,ec4);
% figure; montage(multi);
% title('Canny Gradient Detector Edges at Sigma default, 1, 10');

% figure; imshow(tw); %Two or more commands can go on one line
cs=500.5;   %generate disks of radius 30.5  (must always be something + 1/2)
border=5;  %border to go around the disk
ms=2*(cs+border);   %define masksize for circular disk. Must be odd.
msh=floor(ms/2)+1;  %midway point to use as center
mask=ones(ms,ms);  %initialize mask with -1 everywhere

for i=1:ms
    for j=1:ms
        if (i-msh)^2+(j-msh)^2<=cs^2
            mask(i,j)=-1;
        end
    end
end

c=conv2(mask,ec4);  %convolve mask with thresholded image to measure how
                   %disk-like each region is
                   
c01 = c-min(c(:)); c01=c01/max(c01(:)); %Adjust to [0 1] for display only
% Indexed c as c(:) in line above as a 1D vector even though it's also a 2D matrix
% imshow(c01);

y=find(c>850);  %locations of candidate circular disks are those with high
%values after the convolution

res=zeros(size(c));  %Important here that 'c' is in fact bigger than 'bw'
                     %because of convolution boundaries.

res(y)=1;   %Mark all candidate locations in res

figure; imshowpair(bw,res,'montage')
title('White dots indicate disk centers');
% input('Hit any key to continue.');
result=bwmorph(res,'shrink',Inf);  %shrink connected objects to single points
figure; imshowpair(bw,result,'montage')
[xcenter, ycenter]=find(result>0);
'Number of circles found is: '
length(xcenter)

'Circle locations are: '

[xcenter ycenter]

