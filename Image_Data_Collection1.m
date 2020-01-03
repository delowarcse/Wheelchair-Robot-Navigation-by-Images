% Program for collecting data using camera iamge

clear all;
close all;

obj = videoinput('winvideo',2,'YUY2_640x480');
set(obj,'TriggerRepeat',inf);
set(obj,'ReturnedColorSpace','rgb');
start(obj);
% fa = figure(1);
% fb = figure(2);
% fc = figure(3);
% set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% drawnow;
m=1;
while 1
    % for k=1:1

    frame = getdata(obj,1);
    %imshow(frame)
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
    input(m,:) = normalizeImage;
    m=m+1;
    
    flushdata(obj);
    %imshow(halfImage)
    %set(himg1, 'Cdata',halfImage(:,:,:))
    %preview(frame,halfImage)
       % subplot(1,3,3);    imshow(input)
    pause(0.01)
    drawnow
    
end

stop(obj)