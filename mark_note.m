function [ imgrgb ] = mark_note( imgrgb, contours )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    for i = 1:size(contours.pts,2)
        imgrgb(contours.pts(2,i), contours.pts(1,i), 1) = 255;
        imgrgb(contours.pts(2,i), contours.pts(1,i), 2) = 0;
        imgrgb(contours.pts(2,i), contours.pts(1,i), 3) = 0;
    end
end

