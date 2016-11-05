
lw = 3;
H=10;
thn=4;
imgf='decisive_battle_1.bmp';

imgrgb=imread(imgf);
img=im2bw(rgb2gray(imgrgb));

lines=[ 25 173 980 168; 24 182 980 177; 24 191 980 187; 24 200 980 196; 25 210 981 206];
midlines=zeros(4,4);

for i = 1:4
    x1=round((lines(i,1) + lines(i+1,1))/2);
    y1=round((lines(i,2) + lines(i+1,2))/2);
    x2=round((lines(i,3) + lines(i+1,3))/2);
    y2=round((lines(i,4) + lines(i+1,4))/2);
    midlines(i,:) = [x1 y1 x2 y2];
end

[img,imgrgb] = contoursline2(img, imgrgb ,lines(1,1:2), lines(1,3:4), H, lw, thn, 0);
[img,imgrgb] = contoursline2(img, imgrgb ,lines(2,1:2), lines(2,3:4), H, lw, thn, 0);
[img,imgrgb] = contoursline2(img, imgrgb ,lines(3,1:2), lines(3,3:4), H, lw, thn, 0);
[img,imgrgb] = contoursline2(img, imgrgb ,lines(4,1:2), lines(4,3:4), H, lw, thn, 0);
[img,imgrgb] = contoursline2(img, imgrgb ,lines(5,1:2), lines(5,3:4), H, lw, thn, 0);

[img,imgrgb] = contoursline2(img, imgrgb ,midlines(1,1:2), midlines(1,3:4), H, lw, thn, 1);
[img,imgrgb] = contoursline2(img, imgrgb ,midlines(2,1:2), midlines(2,3:4), H, lw, thn, 1);
[img,imgrgb] = contoursline2(img, imgrgb ,midlines(3,1:2), midlines(3,3:4), H, lw, thn, 1);
[img,imgrgb] = contoursline2(img, imgrgb ,midlines(4,1:2), midlines(4,3:4), H, lw, thn, 1);

figure;imshow(img);
figure;imshow(imgrgb);
    
%img=imread('line1.png');

%[cont imgmarked]=trace_cont(img,12,6,6,2);

%cont
%imshow(imgmarked)

%contoursline2('line1.png',[10 7], [965 7], lw, 4)
%contoursline2('line2-addedline.png',[2,7],[970,7], lw,fn,6,1);

%contoursline2('line3.png',[10,7],[970,7],lw,fn,4,0)
%contoursline2('line4.png',[11,7],[970,7],lw,fn,4,0)
%contoursline2('line5.png',[1,7],[970,7],lw,fn,4,0)
