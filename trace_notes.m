function [contours] = trace_notes (imgf, fprefix, line_ys, outf, lw, tmpf)

%thn=4;

%imgrgb=imread(imgf);
img=uint8(imread(imgf));
imgrgb=zeros(size(img,1),size(img,2),3);
imgrgb(:,:,1) = img;
imgrgb(:,:,2) = img;
imgrgb(:,:,3) = img;

%uint8(im2bw(rgb2gray(imgrgb)));
%img=imread('bw-smoothed.bmp');

%lines=[ 25 173 980 168; 24 182 980 177; 24 191 980 187; 24 200 980 196; 25 210 981 206];

%theta = atan ( ( lines(1,4) - lines(1,2) ) / ( lines(1,3) - lines(1,1)) );
%img = imrotate(img, theta);
%imgrgb = imrotate(imgrgb, theta);
%img_orig=img;

%imwrite(img,'bw.bmp');

% load smoothed image directly
%img=im2bw(imread('bw-smoothed.bmp'));
W = size(img, 2);

lines=[ 1 line_ys(1) W line_ys(1); 
        1 line_ys(2) W line_ys(2); 
        1 line_ys(3) W line_ys(3); 
        1 line_ys(4) W line_ys(4); 
        1 line_ys(5) W line_ys(5)];
    
H = round(mean ( line_ys(2:5) - line_ys(1:4)));
    
%lines=[ 1 273 980 273; 1 282 980 282; 1 291 980 291; 1 301 980 301; 1 310 980 310];

%lines=[ 25 173 980 0; 24 182 980 0; 24 191 980 0; 24 200 980 0; 25 210 980 0];
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

fname=outf;
f=fopen(fname,'w');
fclose(f);

height=H;
mid=cell(9);
contours={};

[contours{1},img,imgrgb,mid{1}] = contoursline2(img, imgrgb ,lines(1,1:2), lines(1,3:4), H, lw, 0);
if tmpf>0
    imwrite(imgrgb,strcat(fprefix,'1.bmp'));
end
imgrgb=imgrgb_orig;
save_contours(1,1,height,contours{1},fname);

[contours{3},img,imgrgb,mid{3}] = contoursline2(img, imgrgb ,lines(2,1:2), lines(2,3:4), H, lw, 0);
if tmpf>0
    imwrite(imgrgb,strcat(fprefix,'3.bmp'));
end
imgrgb=imgrgb_orig;
save_contours(1,3,height,contours{3},fname);

[contours{5},img,imgrgb,mid{5}] = contoursline2(img, imgrgb ,lines(3,1:2), lines(3,3:4), H, lw, 0);
if tmpf>0
    imwrite(imgrgb,strcat(fprefix,'5.bmp'));
end
imgrgb=imgrgb_orig;
save_contours(1,5,height,contours{5},fname);

[contours{7},img,imgrgb,mid{7}] = contoursline2(img, imgrgb ,lines(4,1:2), lines(4,3:4), H, lw, 0);
if tmpf>0
    imwrite(imgrgb,strcat(fprefix,'7.bmp'));
end
imgrgb=imgrgb_orig;
save_contours(1,7,height,contours{7},fname);

[contours{9},img,imgrgb,mid{9}] = contoursline2(img, imgrgb ,lines(5,1:2), lines(5,3:4), H, lw, 0);
if tmpf>0
    imwrite(imgrgb,strcat(fprefix,'9.bmp'));
end
imgrgb=imgrgb_orig;
save_contours(1,9,height,contours{9},fname);

%imwrite(imgrgb,strcat(fprefix,'13579.bmp'));

imgrgb=imgrgb_orig;


W=size(img,2);

for i=1:2:7
    mid{i+1} = zeros(W);
    for x=1:W
        mid{i+1}(x)=(mid{i}(x)+mid{i+2}(x))/2;
        %if (mid{i+1}(x)>0)
        %    img(mid{i+1}(x),x)=0;
        %end
    end
end
    
[contours{2},img,imgrgb] = contoursline2(img, imgrgb ,midlines(1,1:2), midlines(1,3:4), H, lw, 1, mid{2});
if tmpf>0
    imwrite(imgrgb,strcat(fprefix,'2.bmp'));
end
imgrgb=imgrgb_orig;
save_contours(1,2,height,contours{2},fname);

[contours{4},img,imgrgb] = contoursline2(img, imgrgb ,midlines(2,1:2), midlines(2,3:4), H, lw, 1, mid{4});
if tmpf>0
    imwrite(imgrgb,strcat(fprefix,'4.bmp'));
end
imgrgb=imgrgb_orig;
save_contours(1,4,height,contours{4},fname);

[contours{6},img,imgrgb] = contoursline2(img, imgrgb ,midlines(3,1:2), midlines(3,3:4), H, lw, 1, mid{6});
if tmpf>0
    imwrite(imgrgb,strcat(fprefix,'6.bmp'));
end
imgrgb=imgrgb_orig;
save_contours(1,6,height,contours{6},fname);

[contours{8},img,imgrgb] = contoursline2(img, imgrgb ,midlines(4,1:2), midlines(4,3:4), H, lw, 1, mid{8});
if tmpf>0
    imwrite(imgrgb,strcat(fprefix,'8.bmp'));
end
imgrgb=imgrgb_orig;
save_contours(1,8,height,contours{8},fname);

if tmpf>0
    imwrite(logical(img),strcat(fprefix,'line-removed.bmp'));
end

   
%imfill(img,[1 1],8)

%img=imread('line1.png');

%[cont imgmarked]=trace_cont(img,12,6,6,2);

%cont
%imshow(imgmarked)

%contoursline2('line1.png',[10 7], [965 7], lw, 4)
%contoursline2('line2-addedline.png',[2,7],[970,7], lw,fn,6,1);

%contoursline2('line3.png',[10,7],[970,7],lw,fn,4,0)
%contoursline2('line4.png',[11,7],[970,7],lw,fn,4,0)
%contoursline2('line5.png',[1,7],[970,7],lw,fn,4,0)

end
