function [ foreground ] = removeBg( img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[row, col, clr] = size(img);

% -- creating mask
imgg = rgb2hsv(img);
% def histogram thresh foreach channel
min1 = 0.000; max1 = 1.000;
min2 = 0.077; max2 = 1.000;
min3 = 0.000; max3 = 1.000;
mask = (imgg(:,:,1) >= min1)&(imgg(:,:,1)<= max1)&(imgg(:,:,2)>= min2)&(imgg(:,:,2)<= max2)&(imgg(:,:,3)>= min3)&(imgg(:,:,3)<= max3);
maskedImg = img;
% Set background pixels where mask is false to zero.
maskedImg(repmat(mask,[1 1 3])) = 0;
%-----------------
mask = imfill(mask, 'holes');
mask = bwconvhull(mask);
maskedImg = bsxfun(@times, img, cast(mask, 'like', img)); % mul each channel

props = regionprops(mask, 'BoundingBox');
croppedImage = imcrop(img, props.BoundingBox);

foreground = croppedImage;

subplot(2, 2, 4);
imshow(croppedImage, []);

end

