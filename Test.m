
%im=imread('0-0.PNG');
im=imread('4-1.jpg');
[onx,ony,z]=size(im);
%clr=impixel(im);

gry=0;
blu=0;
red=0;
orng=0;

for rw=1:onx
    for cl=1:126
        if (im(rw,cl,1)>171) && (im(rw,cl,1)<227)&&(im(rw,cl,2)>179) && (im(rw,cl,2)<238)&&(im(rw,cl,3)>181) && (im(rw,cl,3)<254)
            gry=gry+1;
        end
    end
end

for rw=1:onx
    for cl=1:126
        if (im(rw,cl,1)>-1) && (im(rw,cl,1)<141)&&(im(rw,cl,2)>40) && (im(rw,cl,2)<187)&&(im(rw,cl,3)>73) && (im(rw,cl,3)<256)
            blu=blu+1;
        end
    end
end

for rw=1:onx
    for cl=1:126
        if (im(rw,cl,1)>131) && (im(rw,cl,1)<256)&&(im(rw,cl,2)>13) && (im(rw,cl,2)<32)&&(im(rw,cl,3)>-1) && (im(rw,cl,3)<21)
            red=red+1;
        end
    end
end
for rw=1:onx
    for cl=1:126
        if (im(rw,cl,1)>156) && (im(rw,cl,1)<194)&&(im(rw,cl,2)>50) && (im(rw,cl,2)<75)&&(im(rw,cl,3)>0) && (im(rw,cl,3)<36)
            orng=orng+1;
        end
    end
end

true_color=(max(orng,(max(gry,max(blu,red)))))
gray_color=gry
orange_color=orng
red_color=red
blue_color=blu
if(max(orng,(max(gry,max(blu,red))))==gry)
    car_type="Government  cars"
end
if(max(orng,(max(gry,max(blu,red))))==blu)
    car_type="Owners cars"
end
if(max(orng,(max(gry,max(blu,red))))==red)
    car_type="Transport"
end
if(max(orng,(max(gry,max(blu,red))))==orng)
    car_type="Taxi"
end

% gi=rgb2gray(im);
% [r1,c1]=size(gi);
% obj=grayconnected(gi,r1,c1);
% figure,imshow(obj),title('fe l awal');
% obj=~obj;
% figure,imshow(obj);
% [x,y]=size(im);
% [l,n]=bwlabel(obj);
%
% for i=1:n
%             [r,c]=find(l==i);
%             rc3=[r,c];
%
%             lx=max(r);
%             if lx>x
%                 lx=x;
%             end
%             sx=min(r);
%             if sx<0
%                 sx=0;
%             end
%             nx=lx-sx;
%             ly=max(c);
%             if ly>y
%                 ly=y;
%             end
%             sy=min(c);
%             if sy<0
%                 sy=0;
%             end
%             ny=ly-sy;
%                 plt=zeros(nx,ny,3);
%                 for j=1:nx
%                     for k=1:ny
%                         plt(j,k,:)=im(j+sx,k+sy,:);
%                     end
%                 end
%                 uplt=uint8(plt);
%                % figure,imshow(uplt),title('palte ?')
%
%                 clr=impixel(uint8(uplt));
%
% end


%clr=impixel(uint8(segimg));
%im = imresize(im,[200 200]);
% im = imresize(im, [80 135]);
% imgray = rgb2gray(im);
% imbin = imbinarize(imgray);
%  se = strel(30);
% figure; imshow(imbin);
%  BW2 = imdilate(imbin,se);
%  imshow(BW2), title('Original11')
% Iprops=regionprops(imbin,'BoundingBox','Area', 'Image');
% area = Iprops.Area;
% count = numel(Iprops);
% maxa= area;
% boundingBox = Iprops.BoundingBox;
% for i=1:count
%    if maxa<Iprops(i).Area
%        maxa=Iprops(i).Area;
%        boundingBox=Iprops(i).BoundingBox;
%    end
% end
%
%  figure; imshow(im);
%  for i=1:count
%     figure; imshow(Iprops(i).Image);
%  end

% im = edge(imgray, 'canny');
%  figure; imshow(im);
%  se = strel('square',2);
%   BW2 = imdilate(im,se);
% %   imshow(BW2), title('Original11')
%   BW23 = imfill(BW2,'holes');
% %   imshow(BW23), title('Original71')
%
%  [h, w] = size(im);

%  imshow(im);

% imgray = rgb2gray(im);
% imbin = imbinarize(imgray);
% Iprops=regionprops(imbin,'BoundingBox','Area', 'Image');
% count = numel(Iprops);
% for i=1:count
%     m = imresize(Iprops(i).Image,[80 125]);
%   Iprops2=regionprops(m,'BoundingBox','Area', 'Image');
%   count2 = numel(Iprops2);
% %   for j=1:count2
% %
% %        figure; imshow(Iprops2(j).Image);
% %   end
%
%   figure; imshow(~Iprops(i).Image);
% end