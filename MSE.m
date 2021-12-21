%orfile = uigetfile('*.bmp');
%comfile=uigetfile('*.png');
original_image=imread('image3.bmp'); %original image
compressed_image=imread('compressed_image.png'); %compressed image
imwrite(original_image,'image1.png','png'); %convert original bmp to png
original_image=rgb2gray(original_image); %convert original image to grayscale

original_image=imresize(original_image,size(compressed_image)); %resize original image

MSEvalue=immse(original_image,compressed_image) %calculate mse

