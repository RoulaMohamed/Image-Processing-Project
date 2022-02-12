function [ result ] = SegmentImage( I , thresh )

% I = imresize(I, [500 500]);
%[testImgName,path] = uigetfile('*.jpg');
%imgPath = strcat(path,'/',testImgName);
%im = imread(imgPath);
%I = imread(imgPath);
 [h,w,~] = size(I);
I = imsharpen(I);
 if(h < 100 || w <100)
    I =  imresize(I, [200 200]);
 end

%figure,imshow(I);
% I = imsharpen(I);
x = rgb2gray(I);

% t = graythresh(x);
% x = imbinarize(x,t);
% figure,imshow(x);
x = medfilt2(x,[5,5]);
% t = adaptthresh(x);
% x = imbinarize(x,t);
% figure,imshow(x);
BW = edge(x,'canny');
%figure, imshow(BW);


se = strel('square', 2);
BW = imdilate(BW,se);


% se = strel('square', 2);
% BW = imerode(BW,se);
figure,imshow(BW);
BW = ~BW;
%figure,imshow(BW); 
[L, num] = bwlabel(BW);
L = imfill(L,'holes');
RGB = label2rgb(L);
figure,imshow(RGB);
[h, w, ~] = size(I);
smallRatio = h*w*0.002;

res = (I < smallRatio);
%result = (I < smallRatio);

numberToExtract = 17;
[labeledImage, numberOfBlobs] = bwlabel(BW);
  blobMeasurements = regionprops(labeledImage, 'area');
  % Get all the areas
  allAreas = [blobMeasurements.Area];
  if 1 > 0
    % For positive numbers, sort in order of largest to smallest.
    % Sort them.
    [sortedAreas, sortIndexes] = sort(allAreas, 'descend');
  elseif numberToExtract < 0
    % For negative numbers, sort in order of smallest to largest.
    % Sort them.
    [sortedAreas, sortIndexes] = sort(allAreas, 'ascend');
    % Need to negate numberToExtract so we can use it in sortIndexes later.
    numberToExtract = -numberToExtract;
  else
    % numberToExtract = 0.  Shouldn't happen.  Return no blobs.
    binaryImage = false(size(binaryImage));
    return;
  end
  % Extract the "numberToExtract" largest blob(a)s using ismember().
  if thresh == 176 || thresh == 194
      biggestBlob = ismember(labeledImage, sortIndexes(1:numberToExtract));
  else
    biggestBlob = ismember(labeledImage, sortIndexes(1:1));
    binaryImage = biggestBlob > 0;
    result = BW - binaryImage;
    [L, num] = bwlabel(result);
    L = imfill(L,'holes');
    %LClear = bwareaopen(L,500); 
    %L_final = L - (LClear); 
    RGB = label2rgb(L);
    result = RGB;
    figure,imshow(result);
    return;
  
   end
  % Convert from integer labeled image into binary (logical) image.
  binaryImage = biggestBlob > 0;

%result = res - ~(biggest(1));
%figure, imshow(res);
%result = BW - binaryImage;
result = binaryImage;
[L, num] = bwlabel(result);
L = imfill(L,'holes');
LClear = bwareaopen(L,700); 
L_final = L - (LClear); 
RGB = label2rgb(L_final);
result = RGB;
figure,imshow(result);

%se = strel('square', 2);
%result = imclose(result,se);

%figure, imshow(result);

%connComp = bwlabel(L); %find the connected components
%imageStats = regionprops(connComp,'all'); 
%compNumber = size(imageStats);
%largestPosition = 1;
%for i=1:compNumber - 1 % to compare sizes of connected components
%   box1 = imageStats(i).BoundingBox;
%   compareVar1 = box1(3)*box1(4);
%   box2 = imageStats(i+1).BoundingBox;
%   compareVar2 = box2(3)*box2(4);
%   if compareVar1 > compareVar2
%      largestPosition=i;
%   end
%end

%figure,imshow(label2rgb(L));
%ele = find(L == largestPosition);
%im1 = zeros([size(I, 1) size(I, 2)]);
%im1(ele) = 1;
%figure, imshow(im1);

%anss = L - im1;
%figure, imshow(label2rgb(anss));


end






