%Smoothing and Filtering Examples
%Fall 2018 Brian Funt

image=imread('ThreePenniesAreduced.jpg');
bw=(double(image(:,:,1))+double(image(:,:,2))+double(image(:,:,3)))/(3*255);
%%normalized to 0-1 range
figure; imshow(bw);

%Uniform averaging mask
hu=fspecial('average',15); %hu = fspecial('average', hsize) returns
                          % an averaging filter h of size hsize.
bg=filter2(hu, bw); %filter2 is like conv2 but is correlation (i.e., filter not reflected)

figure; imshow(bg);
title('Filtered by Uniform Mask')
figure; surf(hu);
title('Uniform mask')
input('Hit a key to continue');

hg13_3 = fspecial('gaussian',13,3);
bg=filter2(hg13_3, bw);
figure; imshow(bg);
title('Filtered by Gaussian Mask with Sigma = 3')
figure; surf(hg13_3);
title('Gaussian Mask Sigma = 3')
input('Hit a key to continue');

hg31_7 = fspecial('gaussian',31,7);
bg=filter2(hg31_7, bw);
figure; imshow(bg);
title('Filtered by Gaussian Mask with Sigma = 7')

%Display a plot of the convolution mask h
figure; surf(hg31_7);
input('Hit a key to continue');
%Examples of the laplacian of Gaussian
%Sigma of 3. Masksize of 15
hlog15_3 = fspecial('log',15,3);
bg=filter2(hlog15_3, bw);
figure; surf(hlog15_3);  %Display the mask
title('Laplacian of Gaussian Mask (Sigma = 15)')
input('Hit a key to continue');
%Can't display the result of the convolution directly because it has
%negative values.
%Add an offset and then scale to 0-1 range for display purposes
bgs=bg+.5;
bgs=bgs-min(bgs(:));
bgs=bgs/max(bgs(:));
figure; imshow(bgs);
title('Filtered by Laplacian of Gaussian Mask (plus offset) Sigma = 15')
input('Hit a key to continue');

hlog31_5 = fspecial('log',31,5);  %Sigma 5, mask size of 31
bg=filter2(hlog31_5, bw);
figure; surf(hlog31_5);
title('Laplacian of Gaussian Mask (Sigma = 5)')
input('Hit a key to continue');
bgs=bg+.5;
bgs=bgs-min(bgs(:));
bgs=bgs/max(bgs(:));
figure; imshow(bgs);
title('Filtered by Laplacian of Gaussian Mask (plus offset) Sigma = 5')