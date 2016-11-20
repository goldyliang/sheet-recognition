function [ output_args ] = mark_note( imgrgb, contours )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    for i = 1:size(contours.pts,2)
        imgrgb(contours.pts(2,i), contours.pts(1,i), 0) = 255;
        imgrgb(contours.pts(2,i), contours.pts(1,i), 0) = 0;
        imgrgb(contours.pts(2,i), contours.pts(1,i), 0) = 0;
    end
end

