%[Image_Block_ke_k,js,je,is,ie]=bs(image,k,W)
%bs=block selector
%this function can be used to find or create k-th block with size W x W
%from an image

%=======INPUT OF THIS FUNCTION=============================
%image = original image that want to be divided by  W x W block
%k = number of block. this function can be used for iteration by k
%W = size of the block (pixel)
%W must be:
%rem(M,W)=0 && rem(N,W)
%where M and N are rows and column length of image respectively

% image = imread('tester.tif');
% imshow(image);
clear all;
obj = videoinput('winvideo',1,'YUY2_640x480');
set(obj,'TriggerRepeat',inf);
set(obj,'ReturnedColorSpace','rgb');
start(obj);
image = getdata(obj,1);
image = im2bw(image);
stop(obj)
imshow(image)

k = 24;
W = 12
[M,N] = size(image)


%=======OUTPUT OF THIS FUNCTION=============================
%Image_Block_ke_k = k-th Image size W x W
%if image is:
%img = [ 1 1 2 2 1 1 4 3 2 5;
%        5 6 4 5 6 4 5 5 3 3;
%        1 1 2 2 1 1 4 3 2 5;
%        5 6 4 5 6 4 5 5 3 3];

%and block size is W = 2
%then, 1st block = [1 1;
%                   5 6];
%      2nd block = [2 2;
%                   4 5];
%      5th block = [2 5;
%                   3 3];
%      6th block = [1 1;
%                   5 6];
% ... etc

%js is matrix address from original image as start row for block
%je is matrix address from original image as end row for block
%is is matrix address from original image as start column for block
%ie is matrix address from original image as end column for block

%so if k is 6, js=3 , je= 4, is=1, and ie=2
%Image_Block_ke_k = image(js:je,is:ie)
%Image_Block_ke_k = image(3:4,1:2)
%==============================================================

% function [Image_Block_ke_k,js,je,is,ie]=bs(image,k,W)
[M,N]=size(image);
if rem(M,W)~=0 && rem(N,W)~=0
    error('remain of columns length of image divided by W and remain of rows length of image divided by W must be zero');
end
b=floor((k/(N/W))-0.01)+1;

if k<=N/W
    kx=k;
else
    kx=(N/W)-abs(((N/W)*b-k));
end

is=1+(kx-1)*W;
ie=W+(kx-1)*W;

js=1+(b-1)*W;
je=W+(b-1)*W;

Image_Block_ke_k=image(js:je,is:ie);
figure, imshow(Image_Block_ke_k);