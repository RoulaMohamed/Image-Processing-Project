function [ segImg ] = segment2( Rimg )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
    img = rgb2gray(Rimg);
    
    %sharppining the image
    img = imsharpen(img,'Radius',10,'Amount',1); % 10    
    img = ~im2bw(img,0.7);
     
    
    %figure,imshow( img );
    [row col] = size(img);
    [L num] = bwlabel(img);
    RP = regionprops(L,'all');
    temp = [];
    
    for i = 1:row
        freq = [];
        co = [1 1 img(i,1)]; % [center counter color]
        for j = 2:col
            if co(3) ~= img(i,j)
                co(1) = co(1)+ uint32(j-co(1)-1)/2;
                freq = [freq ; co];
                co = [j 1 img(i,j)];
            else
                co(2) = co(2) + 1;
            end
        end
        co(1) = co(1)+ uint32(col-co(1))/2;
        freq = [freq;co];
        [num x] = size(freq);
        for j = 3:num-2
            if freq(j,3)==0
                continue;
            elseif abs((freq(j,2)/3)-freq(j-2,2)) > (freq(j,2)/6) || ...
                   abs((freq(j,2)/3)-freq(j-1,2)) > (freq(j,2)/6) || ...
                   abs((freq(j,2)/3)-freq(j+1,2)) > (freq(j,2)/6) || ...
                   abs((freq(j,2)/3)-freq(j+2,2)) > (freq(j,2)/6)
               continue;
            end
            %x = freq(j,1) , y = i
            % cheack before adding the same width
            Box = RP( L(i,freq(j,1)) ).BoundingBox;
            Ar = RP( L(i,freq(j,1)) ).Area;
            if abs(Box(3)-Box(4))<15 && (Ar >15) && ...
                    (Ar /min(1,(Box(3)-2)*(Box(4)-2))) > 0.99
                temp = [temp; L(i,freq(j,1))];
                j = j+2;
            end
        end
    end
    
    
    temp = [unique(temp) histc(temp,unique(temp))]
    figure,imshow((L));
    
    
    segImg = (L);

end

