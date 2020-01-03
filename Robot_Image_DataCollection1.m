% Program for collecting data using camera iamge
imaqreset;
clear all;
close all;

academic_init('COM62')

obj = videoinput('winvideo',2,'YUY2_640x480');
set(obj,'TriggerRepeat',inf);
set(obj,'ReturnedColorSpace','rgb');
start(obj);

step = 1;
while 1
    % for k=1:1
    a=jst;
    %speed=round(a(1)*(-40));
    %steer=round(a(3)*(-45));
    
    speed=round(a(1)*(-40));
    steer=round(a(3)*(-40));
    
    frame = getdata(obj,1);
    subplot(1,2,1), imshow(frame)
    subplot(2,2,2), imshow(frame(241:480,1:640))
    
    binaryImage = im2bw(frame); % convert to binary image
    % cut the main image to half in raw and full in column
    halfImage = binaryImage(241:480,1:640);
    %figure, imshow(halfImage);
    subplot(2,2,4), imshow( halfImage)
    
    [rows columns noOfColorBand] = size(halfImage);
    
    % Divide the image into blocks using mat2cell()
    blockSizeR = 80;
    blockSizeC = 80;
    
    % Figure out the size of each block in rows.
    % Most will be blockSizeR but there may be a remainder amount of less than that.
    wholeBlockRows = floor(rows / blockSizeR);
    %blockVectorR = [blockSizeR * ones(1, wholeBlockRows), rem(rows, blockSizeR)];
    blockVectorR = [blockSizeR * ones(1, wholeBlockRows)];
    % Figure out the size of each block in columns.
    wholeBlockCols = floor(columns / blockSizeC);
    %blockVectorC = [blockSizeC * ones(1, wholeBlockCols), rem(columns, blockSizeC)];
    blockVectorC = [blockSizeC * ones(1, wholeBlockCols)];
    
    
    % create the cell array, ca.
    % Each cell in the array contains a blockSizeR by blockSizeC by 3 color array.
    if noOfColorBand>1
        ca = mat2cell(frame, blockVectorR, blockVectorC, noOfColorBand); % incase of color image
    else
        ca = mat2cell (halfImage, blockVectorR, blockVectorC);
    end
    
    % Summarize and normalize the value of each block within [0,1]
    k=1;
    for i =1:wholeBlockRows
        for j=1:wholeBlockCols
            sumOfBlockImage = sum(sum(ca{i,j}));
            normalizeImage(k) = sumOfBlockImage/(blockSizeR * blockSizeC);
            k=k+1;
        end
    end
    
    % imput image
    % imput image
    input(step,:) = normalizeImage;
    output(step,1) = speed;
    output(step,2) = steer;
    step = step+1;
    
    academic_ctrl(speed,steer)
    
    flushdata(obj);
    imshow(halfImage)
    pause(0.01)
    
    speed
    steer
    
end
%save('input1.mat','input');
%save('output1.mat','output');
stop(obj)