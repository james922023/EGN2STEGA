% Load the image
image = imread('SpiderManMeme.png');

% Show size of image
filelocation = 'SpiderManMeme.png';
mytemp = filelocation;
fileInfo = dir(mytemp);
disp("number of bytes in the host image: " + fileInfo.bytes);
numBytes = fileInfo.bytes;

% Calculate what size color image and black and white can fit inside this image
largestBlackAndWhiteImage = sqrt(numBytes / 8);
largestColorImage = sqrt((numBytes / 8) / 3);
disp("largest Black and White Image that can fit in host: " + largestBlackAndWhiteImage + "x" + largestBlackAndWhiteImage);
disp("Largest Color Image that can fit in host: " + largestColorImage + "x" + largestColorImage);

% Get height and width for traversing through the image
[row, col, depth]=size(image);

% Display the image
figure;
imshow(image);
title('original image');

% Prepare output
input=image;
output = input;

% Read in image to hide inside other image
image2 = imread('loosesprites.png');

% Get rows and columns for smaller image
[rows, cols, depths]=size(image2);

% Index for bitArray
bitArrayIndex = 1;

% Show size of image
numBitsInImage2 = rows * cols * 3 * 8;
disp("num bits in smaller image: " + numBitsInImage2);
disp("num bytes in smaller image "+numBitsInImage2/8 );

%DEBUGGING

disp("rows in hidden image: " + rows);
disp("cols in hidden image: " + cols);
disp("depth"+depths);
%disp(image2grey(1:3));


% Initialize bit arrays for each color channel
bitArrayR = [];
bitArrayG = [];
bitArrayB = [];

% Index for bitArray
bitIndex = 1;

% Extract bits from the secret image
for i = 1:rows
    for j = 1:cols
        % Extract bits from Red channel
        pixelValueR = image2(i, j, 1);
        for b = 1:8
            bit = bitget(pixelValueR, 9 - b);
            bitArrayR = [bitArrayR; bit];
        end
        
        % Extract bits from Green channel
        pixelValueG = image2(i, j, 2);
        for b = 1:8
            bit = bitget(pixelValueG, 9 - b);
            bitArrayG = [bitArrayG; bit];
        end
        
        % Extract bits from Blue channel
        pixelValueB = image2(i, j, 3);
        for b = 1:8
            bit = bitget(pixelValueB, 9 - b);
            bitArrayB = [bitArrayB; bit];
        end
    end
end

%Display total number of bits in 3 arrays
allTheBitsIn3Arrays=length(bitArrayR)+length(bitArrayG)+length(bitArrayB);
disp("number of bits in all 3 arrays summed "+allTheBitsIn3Arrays);

% Debugging: Display the first 32 pixel values before embedding

%disp('First 24 bit values before embedding:');
%disp(bitArray(1:32));


% Set counters
counterR = 1;
counterG = 1;
counterB = 1;

for i = 1 : col
    for j = 1 : row
         % Embed bits into Red channel
        if counterR <= length(bitArrayR)
            LSB = mod(double(input(i, j, 1)), 2);
            if LSB ~= bitArrayR(counterR)
                if bitArrayR(counterR) == 1
                    output(i, j, 1) = input(i, j, 1) + 1;
                else
                    output(i, j, 1) = input(i, j, 1) - 1;
                end
            end
            counterR = counterR + 1;
        end
        
        % Embed bits into Green channel
        if counterG <= length(bitArrayG)
            LSB = mod(double(input(i, j, 2)), 2);
            if LSB ~= bitArrayG(counterG)
                if bitArrayG(counterG) == 1
                    output(i, j, 2) = input(i, j, 2) + 1;
                else
                    output(i, j, 2) = input(i, j, 2) - 1;
                end
            end
            counterG = counterG + 1;
        end
        
        % Embed bits into Blue channel
        if counterB <= length(bitArrayB)
            LSB = mod(double(input(i, j, 3)), 2);
            if LSB ~= bitArrayB(counterB)
                if bitArrayB(counterB) == 1
                    output(i, j, 3) = input(i, j, 3) + 1;
                else
                    output(i, j, 3) = input(i, j, 3) - 1;
                end
            end
            counterB = counterB + 1;
        end
    end
end

imwrite(output, "StegoImageC.png");

% Create new figure for second image
figure;
imshow("StegoImageC.png");
title('stego image');
