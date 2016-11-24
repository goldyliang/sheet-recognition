function [ output_args ] = notes_detect( imgrgbf, imgrgbfout )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    %[imgbw, projection] = skew (imgrgbf);
    
    %imgbw = ~imgbw;
    %imwrite (imgbw, 'imgbw.bmp');
    %grayImage = 255 * uint8(imgbw);
    %RGB = cat(3, grayImage, grayImage, grayImage);
    %imwrite (RGB, 'imgrgb.bmp');
    
    %height = Reference_Lengths(imgbw);
        
    %[ lines ] = findlines( projection,height );
    %dlmwrite('lines.txt', lines);
    
    lines = dlmread ('lines.txt');
    height = 9;
    
    lw = 3;
    
    imgf_marked = 'imgrgb.bmp';
    
    for i = 1 : size(lines,2)
        line_ys = transpose(lines ( : , i));
        
        line_ys = sort(line_ys);
        
        %formatSpec = string('contout-%d.txt');
        fout = strcat('contout-',int2str(i),'.txt'); %sprintf(formatSpec, i);
        fresult=strcat('notes-',int2str(i),'.txt');
        
        contours = trace_notes ( 'imgbw.bmp', strcat('img-g',int2str(i),'-'), line_ys, fout, lw);
        
        % call java application
        javaMethod('main','musicPR.Main',{fout fresult '0.5' '0.3'});
        
        mark_group_notes( imgf_marked, imgrgbfout, contours, fresult );
        
        imgf_marked = imgrgbfout;
        
        % Derive mask
        %generate_mask (contours,fresult,height);
        
    end
end

