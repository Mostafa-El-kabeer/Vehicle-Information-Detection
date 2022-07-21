im=imread('3-1.jpg');
gi=rgb2gray(im);
[r1,c1]=size(gi);
obj=grayconnected(gi,r1,c1);
figure,imshow(obj),title('fe l awal');
obj=~obj;
figure,imshow(obj);
[x,y]=size(im);
[l,n]=bwlabel(obj);

for i=1:n
    [r,c]=find(l==i);
    rc=[r,c];
    
    lx=max(r)+3;
    if lx>x
        lx=x;
    end
    sx=min(r)-3;
    if sx<0
        sx=0;
    end
    nx=lx-sx;
    ly=max(c)+3;
    if ly>y
        ly=y;
    end
    sy=min(c)-3;
    if sy<0
        sy=0;
    end
    ny=ly-sy;
    plt=zeros(nx,ny,3);
    for j=1:nx
        for k=1:ny
            plt(j,k,:)=im(j+sx,k+sy,:);
        end
    end
    uplt=uint8(plt);
    figure,imshow(uplt),title('palte ?');
    %%%%%%
    %rotation&rec.dect.
    %%%%%%
    
    gi=rgb2gray(uplt);
    [r1,c1]=size(gi);
    obj2=grayconnected(gi,r1,c1);
    in = ~obj2;
    [l2,num] = bwlabel(in);
    rp= regionprops(l2,'Extent');
    s = size(rp);
    for j=1:s
        %h = rp(j).Extent
        if rp(j).Extent > 0.81
            l2(l2==j)=10;
%        end
%         if rp(j).Extent >= 0.6 && rp(j).Extent <= 0.85
%             l2(l2==j)=20;
%         end
%         if rp(j).Extent >= 0.5 && rp(j).Extent <= 0.6
%             l2(l2==j)=30;
%         end
        else
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %l2(l2==j)=40;
            tmp=in;
            maxl1 = -8;
            mkl1 = 0;
           % co1=0;
            tlml1=l2;
            for k=0:10:180
                 %figure,imshow(tmp), title("a7a");
                tmp = imrotate(tmp,-k);
                [tx,ty]=size(tmp);
                [l3,num22] = bwlabel(tmp);
               rp2= regionprops(l3,'Extent');
                if (rp2(1).Extent > maxl1)&& ty>tx
                    maxl1 = rp2.Extent;
                    mkl1 = k;
                    tlml1=l3;
                   % co1 = co1+1;
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              tmp=in;
            maxl2 = -8;
            mkl2 = 0;
            %co2=0;
            tlml2=l2;
            for k=0:10:180
                 %figure,imshow(tmp), title("a7a");
                tmp = imrotate(tmp,k);
                [tx,ty]=size(tmp);
                [l3,num22] = bwlabel(tmp);
               rp2= regionprops(l3,'Extent');
                if (rp2(1).Extent > maxl2)&& ty>tx
                    maxl2 = rp2.Extent;
                    mkl2 = k;
                    tlml2=l3;
                   % co2 = co2+1;
                end
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
             if (mkl1 < mkl2||mkl2==0)
            plt45 = imrotate(uplt,-mkl1);
            tlmf=tlml1;
            else
                plt45 = imrotate(uplt,mkl2);
                tlmf=tlml2;
             end
             figure,imshow(plt45),title("a7aaaaaaaaaaaaaaaaaaaaaa");
             
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             
             [r4,c4]=find(tlmf==1);
    rc4=[r4,c4];
    
    lx=max(r4)+1;
    if lx>x
        lx=x;
    end
    sx=min(r4)-1;
    if sx<0
        sx=0;
    end
    nx=lx-sx;
    ly=max(c4)+1;
    if ly>y
        ly=y;
    end
    sy=min(c4)-1;
    if sy<0
        sy=0;
    end
    ny=ly-sy;
    ri=zeros(nx,ny,3);
    for o=1:nx
        for p=1:ny
            ri(o,p,:)=plt45(o+sx,p+sy,:);
        end
    end
        uri=uint8(ri);
    figure,imshow(uri),title('ri ????? :))) ?');     
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    end
    im2 = label2rgb(l2);
    figure,imshow(im2);
    
end
