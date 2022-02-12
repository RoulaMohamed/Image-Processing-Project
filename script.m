[testImgName,path] = uigetfile('*.jpg');
imgPath = strcat(path,'/',testImgName);
%im = imread(imgPath);
%segImg  = im(:,:,2)<150;
%figure, imshow(segImg );
Rimg =imread(imgPath);
thresh = multithresh(Rimg);
%message = sprintf('%i thresh ', thresh);
%uiwait(msgbox(message));
Bimg = removeBg(Rimg); 
flag = 0;
numComp = 0;
pure2Img; segImg;
if (thresh >180 && thresh <= 181) || (thresh > 135 && thresh <= 140) || (thresh >170 && thresh <= 176) || thresh == 178 
   segImg = SegmentImage(Bimg, thresh);
   figure, imshow(segImg);
   pure2Img = extraPurify(segImg);
   %segImg = bwareaopen(segImg,4000); 
   flag = 1;
else
   segImg = segment(Bimg);
   figure, imshow(segImg);
   [pure1Img, numComponents] = purify(segImg);
   numComp = numComponents;
   pure2Img = extraPurify(pure1Img);
end
%Bimg = maskBg(Rimg);
%Ximg = Rimg - Bimg;

if flag == 1
    [outFolderPath, outputNum] = export(imgPath, segImg, 0);
else
    [outFolderPath, outputNum] = export(imgPath, pure2Img, numComp);
end
%[outFolderPath, outputNum] = export(imgPath, segImg, numComp);
ext='.jpg';
letterDetected= {};
len = {};

for i=1: outputNum
   curImgPath=strcat(outFolderPath,num2str(i),ext); 
   img = imread(curImgPath);
   figure, imshow(img);
   %se= strel('square',5);
   %img = imerode(img, se);
   
   %img2 = ~img;
   %img = img2;
   %img = imrotate(img2,-90,'bilinear','crop');
   figure, imshow(img);
   %recognise(img); 
   %se= strel('square',9); % 9
   %img = imdilate(img, se);
   
   letter = ocr_recognise(img);
   
   %letterDetected = [letterDetected, letter];
   %if ( regexp( str(letter), '[^.?"{}]' ) ) == true
    %continue;
   %end;
   
   %lenn = strlen(string(letter));
   %message = sprintf('len is: %c', size);
   %uiwait(msgbox(message));
   
   %for i=1:length(letter)
   % offset = min(10, size(noise,2)-letter(i));
   % M(i,(end-offset):end)=noise(letter(i):letter(i)+offset);
   % letterDetected = [letterDetected, M];
   %end
   
   %if lenn == 1
   

   try
       Characters=['a';'b';'c';'d';'e';'f';'g';'h';'i';'j';'k';'l';'m';'n';'o';'p';'q';'r';'s';'t';'u';'v';'w';'x';'y';'z';
                    'A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z';
                    '0'; '1'; '2'; '3'; '4';'5'; '6';'7';'8';'9'];
       h = find(ismember(Characters, letter(1)));
       %message = sprintf('%is memeber? ', h);
       %uiwait(msgbox(message));
       letterDetected = [letterDetected, letter(1)];
   %if letter(1) >= '0' && letter(1) <= '9'
   %     letterDetected = [letterDetected, letter(1)];
   %elseif letter(1) >= 'a' && letter(1) <= 'z'
   %     letterDetected = [letterDetected, letter(1)];
   %elseif letter(1) >= 'A' && letter(1) <= 'Z'
   %     letterDetected = [letterDetected, letter(1)];
   %end
   catch exception
       % was empty
   end
   %end
   
   
   %letterDetected = [letterDetected, letter];
   % Fix the indx numbers of the templates identifications
   
   % TODO:
   % if recognised == true:
   %    add letter to list
   % else:
   %    for (allowed num of rotations):
   %        rotatedImg = rotate(img);
   %        recognise(rotatedImg)
end




