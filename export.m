function [ outFolderPath, outputNum ] = export( imgPath, pure2Img, numComp )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
%[L num] = bwlabel(pure2Img);
%figure, imshow(pure2Img);
targetFolder='./exported letters2/';
[filepath,name,~] = fileparts(imgPath);
subFolder=name;
subFolderPath=strcat(targetFolder,subFolder,'/');
mkdir(subFolderPath);
ext='.jpg';

%RP = regionprops(biggest, 'all');

% -------------- save once the coloured img
currentSegment = pure2Img;
outputPath=strcat(subFolderPath,num2str(1),ext);
imwrite(currentSegment,outputPath);

% -------------- read it back
img = imread(outputPath);
figure, imshow(img);
%img = imsharpen(img,'Radius',10,'Amount',50); 
%%img = ~img(:, :, 1); 
%%figure, imshow(img);
%img = ~im2bw(img);
%figure, imshow(img);
%se = [0 1 0; 1 1 1; 0 1 0];
%img = imdilate(img,se);
%img = bwareaopen(img,700); 
%%figure, imshow(img);
%[L , num] = bwlabel(img);

% -------------------------------------------
if numComp == 0
    try
    img = rgb2gray(img);
    end
end
%sharppining the image
img = imsharpen(img,'Radius',10,'Amount',1); % 10    
img = ~im2bw(img,0.9);
imgg = bwareaopen(img,10); 
img = imgg;
%figure,imshow( img );
[row col] = size(img);
[L num] = bwlabel(img);
figure, imshow(label2rgb(L));

    %----------

for i=1:num
    %figure, imshow(label2rgb(L(i)));
    currentSegment= ismember(L, i);
    %figure, imshow(label2rgb(currentSegment));
    %currentSegment = L(i);
    
    %figure, imshow(currentSegment);
    %currentSegment= ismember(RP, i);
    %currentSegment=label2rgb(L(i));
    outputPath=strcat(subFolderPath,num2str(i),ext);
    imwrite(currentSegment,outputPath);    
end

outFolderPath = subFolderPath;
outputNum = num;

end

