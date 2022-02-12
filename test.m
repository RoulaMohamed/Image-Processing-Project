function [ output_args ] = untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

clear
clc

%set of patterns
BW1 = imread('1.1.jpg');
BW1 = rgb2gray(BW1);
patterns = bwlabel(~BW1);
patternStats = regionprops(patterns,'all');

patternNumber = size(patternStats);
imagePatternArray = cell(patternNumber);

%make cell array of pattern Matrices
for i = 1:1:patternNumber
  imageMatrix = patternStats(i).Image;
  imageMatrix = imresize(imageMatrix, [25 20]);
  imagePatternArray{i} = imageMatrix;
end  

%set of chars
BW2 = imread('1.1.jpg');
BW2Gray = rgb2gray(BW2); %convert text to grayscale bmp - 0 OR 1
text = bwlabel(~BW2Gray);
textStats = regionprops(text,'all'); 

letterNumber = size(textStats);
imageLetterArray = cell(letterNumber);

%make cell array of text Matrices
for i = 1:1:letterNumber
  imageMatrix = textStats(i).Image;
  imageMatrix = imresize(imageMatrix, [25 20]);
  imageLetterArray{i} = imageMatrix;
end

%white spaces
whiteSpacesIndexes = [];

for i = 1:letterNumber - 1
  firstLetterBox = textStats(i).BoundingBox;
  positionFirstVector = [firstLetterBox(1), firstLetterBox(2)];  

  secondLetterBox = textStats(i+1).BoundingBox;
  positionSecondVector = [secondLetterBox(1), secondLetterBox(2)];

  distanceVector = positionSecondVector - positionFirstVector;
  distance = norm(distanceVector)
  % if the distance between is bigger that letter width plus 1/3 of width, it is a whitespace
  bothLettersSize = firstLetterBox(3)  + secondLetterBox(3);
  noSpaceDistance =  bothLettersSize - bothLettersSize * 0.25; % - 25 per cent (heuristic value)

  if (distance > noSpaceDistance) %&& (abs(distanceVector(2)) > 1.0)
      whiteSpacesIndexes = [whiteSpacesIndexes, i + 1];
  end 
end

compareVector = size(patternNumber);
indexArray = size(letterNumber);

for i = 1:1:letterNumber
    for j = 1:1:patternNumber        
           correlationMatrix = normxcorr2(imagePatternArray{j},imageLetterArray{i});           
          compareVector(j) = max(abs(correlationMatrix(:)));
    end    
        [correlationMax,correlationIndex] = max(compareVector);
       indexArray(i) = correlationIndex;
end

%lookup table
charSet = ['A','B','C','D','E','F','G','H','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];

%outPut stream
outPut = size(letterNumber);
for i = 1:1:letterNumber
   outPut(i) = charSet(indexArray(i));
end

whiteSpaceNumber = size(whiteSpacesIndexes,2);

whiteSpacesIndexes = whiteSpacesIndexes + (0:numel(whiteSpacesIndexes)-1)
nFinal = numel(outPut)+numel(whiteSpacesIndexes );      %# New length of result with blanks
newstr = blanks(nFinal);                                %# Initialize the result as blanks
newstr(setdiff(1:nFinal,whiteSpacesIndexes )) = outPut
end

