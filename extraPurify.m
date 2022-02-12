function [ pure2Img ] = purify( pure1Img )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
img = pure1Img;
se = [0 1 0; 1 1 1; 0 1 0];
img = imclose(img,se);
%img = imdilate(img,ones(3,3));
%img = bwareaopen(img,1);
figure, imshow(img);
%pure2Img = img;

% ------- get biggest components
CC = bwconncomp(img);
numOfPixels = cellfun(@numel,CC.PixelIdxList);
[unused,indexOfMax] = max(numOfPixels);
biggest = zeros(size(img));
biggest(CC.PixelIdxList{indexOfMax}) = 1;
figure, imshow(biggest);

pure2Img = biggest;
end

