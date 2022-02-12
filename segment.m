function segImg = segment( Rimg ) 
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %[testImgName,path] = uigetfile('*.jpg');
    %Rimg =imread(strcat(path,'/',testImgName));
   
    %Rimg = imread('1.1.jpg');
    thresh = multithresh(Rimg);
    
    %message = sprintf('%d is level', thresh);
    %uiwait(msgbox(message));
    
    %figure,imshow(Rimg);
    img = rgb2gray(Rimg);
    
    %image preparing
    if thresh == 174
        img = imsharpen(img,'Radius',10,'Amount',50); 
        img = im2bw(img);
        imgg = bwareaopen(img,4000); 
        img2 = img - imgg;
        img = img2;
        img = bwareaopen(img,2550); 
        %figure,imshow(img); 
        img = bwFix(img); 
    elseif thresh == 181
        img = imsharpen(img,'Radius',10,'Amount',300); % 50
        img = im2bw(img);
        img0 = img;
        %figure,imshow(img);
        imgg = bwareaopen(img,500); 
        img2 = img - imgg;
        img = ~img2;
        img1 = img;
        %figure,imshow(img);
        se= strel('square',5);
        img2 = imerode(img, se);
        imgg = img - img2;
        img = imgg;
        %figure,imshow(img); -------
        %[w h]=size(img);
        %imgg = imresize(img, [w*2 h*2]);
        %img = imgg;
        se= strel('square',7); % 9
        img2 = imdilate(img, se);
        img = img2;
        imgg = bwareaopen(img,400); % 400
        img = imgg;
        img2 = img;
        %figure,imshow(img);
        %img = img1- ~img2;
        img = img0 - ~img2;
        se= strel('square',3); % 9
        imgg = imdilate(img, se);
        img3 = ~imgg;
        img = ~imgg;
        imgBg = img0 - ~img3;
        se= strel('square',15); % 9
        imgBg = imdilate(imgBg, se);
        se= strel('square',3); % 9
        img3 = imclose(img3, se);
        imgImp = imgBg - img3;
        img4 = imgImp + img3;
        %img4 = imfuse(imgBg, img3, 'montage');
        img6 = img3 - img4; % got num 6, & need to remove impurities
        imgg1 = bwareaopen(img6,140);
        imgg = bwareaopen(img6,200);
        img = imgg1 - imgg; % num 6 pure
        %figure,imshow(img); 
        img = bwFix(img);
    elseif thresh == 160 
        img = imsharpen(img,'Radius',10,'Amount',1); 
        img = im2bw(img);
        %imgg = bwareaopen(img,100);
        %img = imgg;
        se= strel('square',2); % 15
        img = imclose(img, se)
        img = bwFix(img);  
    else 
        img = imsharpen(img,'Radius',10,'Amount',1); 
        img = im2bw(img);
        %imgg = bwareaopen(img,100);
        %img = imgg;
        se= strel('square',2); % 15
        img = imclose(img, se)
        img = ~bwFix(img);  
    end;
    
    figure,imshow(img);
    segImg = img;
    

end

