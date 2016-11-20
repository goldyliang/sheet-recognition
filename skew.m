function [ bw,projection ] = skew( path )
%read image
image = imread(path);
width = size(image,2);
%conver to grayscale image
gray = rgb2gray(image);

%use otsu method to binarize the image
[counts,~] = imhist(gray,16);
T = otsuthresh(counts);
bw = 1-imbinarize(gray,T);

%create a matrix with all 1 to calculate the projection
one = ones(width,1);

% initialize the maximum standard deviation
max_std = 0;

% skew detection, default angle from -5 to 5
% with precision of 0.01
for angle = -30:0.1:30
to_test_img = imrotate(bw,angle,'crop');

% calculate the projection by line
projection = to_test_img*one;

% calculate the Standard Deviation
std = std2(projection);

if std>max_std
max_std = std;
fix_angle = angle;
end
end

fix_angle
% create fixed image in RGB
temp = imcomplement(image);
temp2 = imrotate(temp,fix_angle,'bilinear','crop');
fixed_img = imcomplement(temp2);
smoothed_img = imgaussfilt(fixed_img);

% create binary image for the fixed image
gray = rgb2gray(smoothed_img);

%use otsu method to binarize the image
[counts,~] = imhist(gray,16);
T = otsuthresh(counts);
bw = 1-imbinarize(gray,T);
projection = bw*ones(width,1);
%imshow(bw);
% write fixed image to file
%imwrite(fixed_img,'fixed.bmp');

end