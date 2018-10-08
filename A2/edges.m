%Edge Detection Examples
%Fall 2018 Brian Funt

image=imread('images/OneBallVerticalLarge.jpg');
%%Convert to greyscale normalized to 0-1 range
bw=(double(image(:,:,1))+double(image(:,:,2))+double(image(:,:,3)))/(3*255);

%%%%Simple gradient-based edge detection
Threshold = 0.1;
cx=conv2(bw,[-1 1],'same');  %Horizontal derivative
cy=conv2(bw,[-1 1]','same'); %Vertical derivative
magsq=cx.^2+cy.^2;   %Magnitude of the gradient
edgesdetected=zeros(size(magsq));
edgesdetected(magsq/max(magsq(:))>Threshold)=1;  %Threshold on gradient
imshow(edgesdetected)
multigrad=cat(4, bw, edgesdetected);
montage(multigrad);

title('Simple Gradient Edges')
input('Simple gradient edge detection result. Hit any key to continue')

%Run examples of Canny edge detection
ec1 = edge(bw,'canny');
ec2 = edge(bw,'canny', .1, 1);
ec3 = edge(bw,'canny', .1, 10);

multi=cat(4,bw,ec1,ec2,ec3);
figure; montage(multi)
title('Canny Gradient Detector Edges at Sigma default, 1, 10')
input('Canny edge result3. Hit any key to continue')

[eg1, thresh]= edge(bw,'log'); %Returns the edge image and the threshold used
[eg2, thresh]= edge(bw,'log', thresh, 3);
[eg3, thresh]= edge(bw,'log', thresh, 4);
[eg4, thresh]= edge(bw,'log', thresh, 5);
multieg=cat(4,eg1,eg2,eg3,eg4);
figure; montage(multieg)
title('Zerocrossings of Laplacian of Gaussian edges: sigma of Default, 3, 4, 5')
disp('LoG results for various thresholds')
