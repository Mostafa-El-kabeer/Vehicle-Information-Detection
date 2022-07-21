close all;
img=imread('3-1.jpg');
figure,imshow(img),title('original');
gi=rgb2gray(img);
[x,y]=size(gi);
obj=grayconnected(gi,x,y);
figure,imshow(obj),title('1');
obj=~obj;
figure,imshow(obj);
[l,n]=bwlabel(obj);
%plate detection
for i=1:n
    [r,c]=find(l==i);
    rc=[r,c];
    
    lx=max(r)+3;
    if lx>x
        lx=x;
    end
    sx=min(r)-3;
    if sx<1
        sx=1;
    end
    onx=lx-sx;
    ly=max(c)+3;
    if ly>y
        ly=y;
    end
    sy=min(c)-3;
    if sy<1
        sy=1;
    end
    ony=ly-sy;
    plt=zeros(onx,ony,3);
    for j=1:onx
        for k=1:ony
            plt(j,k,:)=img(j+sx,k+sy,:);
        end
    end
    uplt=uint8(plt);
    figure,imshow(uplt),title('Plate');
    %end of plate detection
    n_co=0; %numbers count
    l_co=0; %letters count
    gobj=rgb2gray(uplt);
    [gox,goy]=size(gobj);
    %rotated plate detection
    gobj=~grayconnected(gobj,gox,goy);
    
    figure,imshow(uint8(gobj)),title('wierd');
    
    ori=regionprops(gobj,'Orientation','Image');
    %    figure,imshow(gobj),title('gray obj');
    [l4,num22] = bwlabel(gobj);
    rp4= regionprops(l4,'Extent');
    %     ex3=rp4(1).Extent
    ex4=ori(1).Orientation
    nsimg=plt;
    flg=0;
    if rp4(1).Extent < 0.81 %if it's rotated
        nsimg=imrotate(plt,-(ori(1).Orientation));
        gobj=imrotate(gobj,-(ori(1).Orientation));
        [l4,num22] = bwlabel(gobj); %bwlabel to get new rotated plate cordinates
        %figure,imshow(gobj),title('gray obj2');
        %figure,imshow(uint8(nsimg)),title('plt2');
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %readjusting rotated palate
        [r4,c4]=find(l4==1);
        rc4=[r4,c4];
        
        lx=max(r4)+1;
        if lx>x
            lx=x;
        end
        sx=min(r4)-1;
        if sx<1
            sx=1;
        end
        nx=lx-sx;
        ly=max(c4)+1;
        if ly>y
            ly=y;
        end
        sy=min(c4)-1;
        if sy<1
            sy=1;
        end
        ny=ly-sy;
        ri=zeros(nx,ny,3);
        for o=1:nx
            for p=1:ny
                ri(o,p,:)=nsimg(o+sx,p+sy,:);
            end
        end
        nsimg=ri;
        %         lf=LaplacianFilter();
        %         nsimg=Linear_Filter(nsimg,lf,'cutoff');
        flg=1;
        %         nsimg=imsharpen(nsimg);
        unsimg=uint8(nsimg);
        figure,imshow(unsimg),title('Readjusted Plate');
    end
    %end of readjusting rotated palate
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %resizing to standard size
    nsimg=imresize(nsimg,[66 131]);
    [onx,ony,dc]=size(nsimg);
    %clr=impixel(uint8(segimg));
    %    usim=uint8(segimg);
    %     figure,imshow(usim),title('abl l 5art2a');
    %     flg=0;
    %     [rs,cs,ch]=size(segimg);
    %     for rw=1:rs
    %         for cl=1:cs
    %             if (segimg(rw,cl,1)>171) && (segimg(rw,cl,1)<227)&&(segimg(rw,cl,2)>179) && (segimg(rw,cl,2)<238)&&(segimg(rw,cl,3)>181) && (segimg(rw,cl,3)<254)
    %                 segimg(rw,cl,:)=0;
    %                 flg=flg+1;
    %             end
    %         end
    %     end
    %    if flg==1
    %sharpening edges to enhance detection
    lf=LaplacianFilter();
    rf=Linear_Filter(nsimg,lf,'cutoff');
    unsimg=uint8(nsimg);
    figure,imshow(unsimg),title('1');
    gui=rgb2gray(rf);
    %     else
    %         unsimg=uint8(nsimg);
    %         figure,imshow(unsimg),title('ba3d l 5art2a');
    %         gui=rgb2gray(unsimg);
    %     end
    %numbers/letters rectangles detection
    gui = imbinarize(gui);
    gui = imerode(gui, ones(3,3));
    %    figure,imshow(gui),title('2');
    %gui=medfilt2(gui,[2 3]);
    figure,imshow(gui),title('3');
    %     end
    [l2,n2]=bwlabel(gui);
    cou=1;
    for i2=1:n2
        [r2,c2]=find(l2==i2);
        rc2=[r2,c2];
        lx=max(r2);
        sx=min(r2);
        nx=lx-sx;
        ly=max(c2);
        sy=min(c2);
        ny=ly-sy;
        num=zeros(nx,ny,3);
        num2=zeros(nx,ny,3);
        for j=1:nx
            for k=1:ny
                num(j,k,:)=nsimg(j+sx,k+sy,1);
            end
        end
        unum=uint8(num);
        num2=~imbinarize(rgb2gray(unum));
        %        figure,imshow(num2),title('num2');
        [numx,numy]=size(num2);
       % figure,imshow(unum),title('rakam ?');
        if ~(numx<42&&numx>25&&numy<72&&numy>45)
            continue;
        end
        %end of numbers/letters rectangles detection
        %        figure,imshow(unum),title('rakam ?');
        %        gnum=rgb2gray(num2);
        %letters/numbers detection
        gnum=num2;
        [l3,n3]=bwlabel(gnum);
        for i3=1:n3
            [r3,c3]=find(l3==i3);
            rc3=[r3,c3];
            
            lx=max(r3)+3;
            if lx>numx
                lx=numx;
            end
            sx=min(r3)-3;
            if sx<1
                sx=1;
            end
            nx=lx-sx;
            ly=max(c3)+3;
            if ly>numy
                ly=numy;
            end
            sy=min(c3)-3;
            if sy<1
                sy=1;
            end
            ny=ly-sy;
            if nx>5 && ny>3&&cou==1
                n_co=n_co+1;
                dig=zeros(nx,ny,3);
                for j=1:nx
                    for k=1:ny
                        dig(j,k,:)=num(j+sx,k+sy,:);
                    end
                end
                udig=uint8(dig);
                figure,imshow(udig),title('Number');
            end
            
            if nx>9&&ny>9&&cou==2
                l_co=l_co+1;
                dig=zeros(nx,ny,3);
                for j=1:nx
                    for k=1:ny
                        dig(j,k,:)=num(j+sx,k+sy,:);
                    end
                end
                udig=uint8(dig);
                figure,imshow(udig),title('Letter');
            end
            
        end
        cou=cou+1;
    end
    %end of letters/numbers detection
    Number_of_characters=l_co
    numbers_count =n_co
    
    if(numbers_count+Number_of_characters==6&&numbers_count==3)
        Governorate="Cairo"
    end
    if(numbers_count+Number_of_characters==6&&numbers_count==4)
        Governorate="Giza"
    end
    if(numbers_count+Number_of_characters==7&&numbers_count==4)
        Governorate="Other governorate"
    end
    %color detection
    gry=0;
    blu=0;
    red=0;
    orng=0;
    
    for rw=1:onx
        for cl=1:ony/3
            if (nsimg(rw,cl,1)>171) && (nsimg(rw,cl,1)<227)&&(nsimg(rw,cl,2)>179) && (nsimg(rw,cl,2)<238)&&(nsimg(rw,cl,3)>181) && (nsimg(rw,cl,3)<254)
                gry=gry+1;
            end
        end
    end
    
    for rw=1:onx
        for cl=1:ony/3
            if (nsimg(rw,cl,1)>-1) && (nsimg(rw,cl,1)<141)&&(nsimg(rw,cl,2)>40) && (nsimg(rw,cl,2)<187)&&(nsimg(rw,cl,3)>73) && (nsimg(rw,cl,3)<256)
                blu=blu+1;
            end
        end
    end
    
    for rw=1:onx
        for cl=1:ony/3
            if (nsimg(rw,cl,1)>131) && (nsimg(rw,cl,1)<256)&&(nsimg(rw,cl,2)>12) && (nsimg(rw,cl,2)<89)&&(nsimg(rw,cl,3)>-1) && (nsimg(rw,cl,3)<105)
                red=red+1;
            end
        end
    end
    for rw=1:onx
        for cl=1:ony/3
            if (nsimg(rw,cl,1)>156) && (nsimg(rw,cl,1)<194)&&(nsimg(rw,cl,2)>50) && (nsimg(rw,cl,2)<75)&&(nsimg(rw,cl,3)>0) && (nsimg(rw,cl,3)<36)
                orng=orng+1;
            end
        end
    end
    %     gray_color=gry
    %     orange_color=orng
    %     red_color=red
    %     blue_color=blu
    if(max(orng,(max(gry,max(blu,red))))==gry)
        vehicle_type="Government  cars"
    end
    if(max(orng,(max(gry,max(blu,red))))==blu)
        vehicle_type="Owners cars"
    end
    if(max(orng,(max(gry,max(blu,red))))==red)
        vehicle_type="Transport"
    end
    if(max(orng,(max(gry,max(blu,red))))==orng)
        vehicle_type="Taxi"
    end
    
end

