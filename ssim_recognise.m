function [ ssim_dis ] = ssim_recognise( img )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ref = imread('let_a.jpg');
ref = rgb2gray(ref);
ref = imresize(ref, [200 200]);
H = fspecial('Gaussian',[11 11],1.5);
%A = imfilter(ref,H,'replicate');
A= imread('1.jpg');
%A = rgb2gray(A);
A = imresize(A, [200 200]);
%img = imsharpen(A,'Radius',10,'Amount',1); % 10    
%A = ~im2bw(img,0.7);
%imshow(A);

%montage({ref,A})
%title('Reference Image (Left) vs. Blurred Image (Right)')

[ssimval,ssimmap] = ssim(A,ref);

imshow(ssimmap,[])
title(['Local SSIM Map with Global SSIM Value: ',num2str(ssimval)])
ssim_dis = ssimval;
end

