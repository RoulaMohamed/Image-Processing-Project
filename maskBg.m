function [ output ] = maskBg( img )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%===============================================================================
% Read in a demo image.

%[testImgName,path] = uigetfile('*.jpg');
%imgPath = strcat(path,'/',testImgName);
%grayImage = imread(imgPath);

grayImage = img;

% Get the dimensions of the image.
% numberOfColorChannels should be = 1 for a gray scale image, and 3 for an RGB color image.
[rows, columns, numberOfColorChannels] = size(grayImage)
if numberOfColorChannels > 1
  % It's not really gray scale like we expected - it's color.
  % Use weighted sum of ALL channels to create a gray scale image.
  grayImage = rgb2gray(grayImage);
  % ALTERNATE METHOD: Convert it to gray scale by taking only the green channel,
  % which in a typical snapshot will be the least noisy channel.
  % grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the image.
figure, imshow(grayImage, []);
%caption = sprintf('Original Gray Scale Image');
%title(caption, 'FontSize', fontSize, 'Interpreter', 'None');

% Binarize the image by thresholding.
mask = grayImage > 128;
% For some reason, the top two lines of his image are all white.  Blacken those 2 lines:
mask(1:2, :) = false;
% Display the mask image.
%-------------------------=====
%figure, imshow(~mask);
%inv = ~mask;
%output = inv;

%axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
%title('Binary Image Mask', 'fontSize', fontSize);
%drawnow;
% Get rid of small blobs.
mask = bwareaopen(mask, 500);
% Label the image.
labeledImage = bwlabel(mask);
% Find the areas and perimeters
props = regionprops(labeledImage, 'Area', 'Perimeter');
allAreas = [props.Area];
sortedAreas = sort(allAreas, 'descend')
allPerimeters = [props.Perimeter];
% Compute circularities
circularities = allPerimeters .^ 2 ./ (4 * pi * allAreas)
sortedC = sort(circularities, 'descend')
% Keep conly blobs that are nowhere close to circular or compact.
minAllowableCircularity = 10;
keeperIndexes = find(circularities >= minAllowableCircularity);
mask = ismember(labeledImage, keeperIndexes);
% Display the mask image.

%figure, imshow(mask);
% Get rid of black islands (holes) in struts without filling large black areas.
mask = ~bwareaopen(~mask, 1000);
%figure, imshow(mask);
figure, imshow(~mask);
inv = ~mask;
output = inv;


end

