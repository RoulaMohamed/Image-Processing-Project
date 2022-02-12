function [ pure1Img, numComp ] = purify( segImg )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    %Rimg = imread('1.2.jpg');
    %Rimg = imrotate(Rimg,-35);
    %img = rgb2gray(Rimg);
    %img = ~im2bw(img);
    img = segImg;
    %img = im2bw(img);
    %figure,imshow(img)
    %Dilation and erode part
    se = [0 1 0; 1 1 1; 0 1 0];
    img = imerode(img,se);
    img = imdilate(img,ones(3,3));
    %figure,imshow(img);
    
    
    
    [L , num] = bwlabel((img));
    numComp = num;
    
    figure,imshow(label2rgb(L))
    RP = regionprops(L,'all');
    [Sx Sy] = size(RP);
    error = zeros(Sx,4);
    error(:,1:2)=100000000;
    AnsList = [];
    for i = 1:num
        Ar = RP(i).Area;
        Box = RP(i).BoundingBox;
        if Ar<25 || abs(Box(3)-Box(4)) < 0.5 || (Ar /((Box(3)-2)*(Box(4)-2))) > 0.99 || ((Box(3)-2)*(Box(4)-2))<4
            L(L==i)=0;
            continue;
        end
        %figure,imshow(label2rgb(L));
        %figure,imshow((L==i).*i);
        
        if i==0 || error(i,3)==0|| error(i,4)==0
            continue;
        end
        %AnsList = [AnsList; [error(i,1)+error(i,2) i error(i,3) error(i,4)]];
        %temp = uint32((i + error(i,3) + error(i,4))/3);
        %%L(L==i)=temp;
        %L(L==error(i,3))=i;
        %L(L==error(i,4))=i;
    end
    
    %figure, imshow(label2rgb(L));
    pure1Img = label2rgb(L);
    

end

