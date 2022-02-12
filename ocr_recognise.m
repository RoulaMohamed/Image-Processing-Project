function [ letter ] = ocr_recognise( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%im_solo = imread('1.1.jpg');
im_solo = img;
results = ocr(im_solo,'TextLayout','Block'); 
letter = results.Text; 
%letter = deblank(letter);
%sz = size(results);
end

