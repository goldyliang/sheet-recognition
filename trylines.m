
lw = 3;
H=10;
thn=4;
imgf='decisive_battle_1.bmp';

imgrgb=imread(imgf);
img=im2bw(rgb2gray(imgrgb));
img_orig=img;
imwrite(img,'bw.bmp');

%lines=[ 25 173 980 168; 24 182 980 177; 24 191 980 187; 24 200 980 196; 25 210 981 206];
lines=[ 25 173 980 0; 24 182 980 0; 24 191 980 0; 24 200 980 0; 25 210 980 0];
%lines=[24 274 980 0; 24 283 980 0; 24 292 980 0 ; 24 301 980 0; 24 310 980 0];
midlines=zeros(4,4);

for i = 1:4
    x1=round((lines(i,1) + lines(i+1,1))/2);
    y1=round((lines(i,2) + lines(i+1,2))/2);
    x2=round((lines(i,3) + lines(i+1,3))/2);
    y2=round((lines(i,4) + lines(i+1,4))/2);
    midlines(i,:) = [x1 y1 x2 y2];
end

%create rgb image from the bw
imgrgb(:,:,1) = img(:,:) * 255;
imgrgb(:,:,2) = img(:,:) * 255;
imgrgb(:,:,3) = img(:,:) * 255;
imgrgb_orig = imgrgb;

fname='test.txt';
f=fopen(fname,'w');
fclose(f);

height=10;
mid=cell(9);
[contours,img,imgrgb,mid{1}] = contoursline2(img, imgrgb ,lines(1,1:2), lines(1,3:4), H, lw, thn, 0);
imwrite(imgrgb,'bw-1.bmp');imgrgb=imgrgb_orig;
save_contours(1,1,height,contours,fname);

[contours,img,imgrgb,mid{3}] = contoursline2(img, imgrgb ,lines(2,1:2), lines(2,3:4), H, lw, thn, 0);
imwrite(imgrgb,'bw-3.bmp');imgrgb=imgrgb_orig;
save_contours(1,3,height,contours,fname);

[contours,img,imgrgb,mid{5}] = contoursline2(img, imgrgb ,lines(3,1:2), lines(3,3:4), H, lw, thn, 0);
imwrite(imgrgb,'bw-5.bmp');imgrgb=imgrgb_orig;
save_contours(1,5,height,contours,fname);

[contours,img,imgrgb,mid{7}] = contoursline2(img, imgrgb ,lines(4,1:2), lines(4,3:4), H, lw, thn, 0);
imwrite(imgrgb,'bw-7.bmp');imgrgb=imgrgb_orig;
save_contours(1,7,height,contours,fname);

[contours,img,imgrgb,mid{9}] = contoursline2(img, imgrgb ,lines(5,1:2), lines(5,3:4), H, lw, thn, 0);
imwrite(imgrgb,'bw-9.bmp');imgrgb=imgrgb_orig;
save_contours(1,9,height,contours,fname);

W=size(img,2);

for i=1:2:7
    mid{i+1} = zeros(W);
    for x=1:W
        mid{i+1}(x)=round((mid{i}(x)+mid{i+2}(x))/2);
        if (mid{i+1}(x)>0)
            img(mid{i+1}(x),x)=0;
        end
    end
end
    
[contours,img,imgrgb] = contoursline2(img, imgrgb ,midlines(1,1:2), midlines(1,3:4), H, lw, thn, 1);
imwrite(imgrgb,'bw-2.bmp');imgrgb=imgrgb_orig;
save_contours(1,2,height,contours,fname);

[contours,img,imgrgb] = contoursline2(img, imgrgb ,midlines(2,1:2), midlines(2,3:4), H, lw, thn, 1);
imwrite(imgrgb,'bw-4.bmp');imgrgb=imgrgb_orig;
save_contours(1,4,height,contours,fname);

[contours,img,imgrgb] = contoursline2(img, imgrgb ,midlines(3,1:2), midlines(3,3:4), H, lw, thn, 1);
imwrite(imgrgb,'bw-6.bmp');imgrgb=imgrgb_orig;
save_contours(1,6,height,contours,fname);

[contours,img,imgrgb] = contoursline2(img, imgrgb ,midlines(4,1:2), midlines(4,3:4), H, lw, thn, 1);
imwrite(imgrgb,'bw-8.bmp');imgrgb=imgrgb_orig;
save_contours(1,8,height,contours,fname);

imwrite(img,'bw-line-removed.bmp');

   
%img=imread('line1.png');

%[cont imgmarked]=trace_cont(img,12,6,6,2);

%cont
%imshow(imgmarked)

%contoursline2('line1.png',[10 7], [965 7], lw, 4)
%contoursline2('line2-addedline.png',[2,7],[970,7], lw,fn,6,1);

%contoursline2('line3.png',[10,7],[970,7],lw,fn,4,0)
%contoursline2('line4.png',[11,7],[970,7],lw,fn,4,0)
%contoursline2('line5.png',[1,7],[970,7],lw,fn,4,0)
