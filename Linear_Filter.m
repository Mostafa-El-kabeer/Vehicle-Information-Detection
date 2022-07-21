function [oi] = Linear_Filter(I,Filter,Postproc)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[H, W, C] = size(I);
newI=im2double(I);
[fr,fc]=size(Filter);
pr=(double(floor((fr/2))))*2;
pc=(double(floor((fc/2))))*2;
ni = uint8(zeros(H+double(pr), W+double(pc), C));
rindx=(double(1+floor((pr/2))));
cindx=(double(1+floor((pc/2))));
for j = 1:H
    for k = 1:W
        ni(j+double(rindx)-1,k+double(cindx)-1,:)=I(j,k,:);
    end
end
%figure,imshow(newI),title('double Image');
%figure,imshow(I),title('Image');
ni=im2double(ni);
%figure,imshow(ni),title('Padded Image');
%I=im2double(I);
%noi = conv2(Filter,I);
noi=uint8((zeros(H, W, C)));
noi=im2double(noi);
[r2,c4,c3] = size(ni);
%noi = ni;
c1=0;
c2=0;

%res = (c4-cindx+1);
for z = 1:C
for x = rindx:(r2-rindx+1)
    for y = cindx:(c4-cindx+1)
        asum=0;
        tmp=double((zeros(fr, fc)));
        dx=double(x);
        dy=double(y);
        %tarr =ni(dx-(floor((pr/2))):dx+(floor((pr/2)))-1,dy-(floor((pc/2))):dy+(floor((pc/2)))-1);
        tmp=Filter.*ni(dx-(floor((pr/2))):dx+(floor((pr/2))),dy-(floor((pc/2))):dy+(floor((pc/2))),z);
        np=sum(sum(tmp));
         
        noi(dx-(floor((pr/2))),dy-(floor((pc/2))),z)=np;
       %noi(x,y) = np;
     %    for j = 1:fr
      %       for k = 1:fc
       %          if((x-k)>0&&(y-j)>0)
                    %asum=asum+(Filter(k,j)*ni(x-k,y-j));
        %         end
         %    end
        % end
      % noi(x,y)=asum; 
      c2 = c2+1;
    end
    
   c1 = c1+1;
end
end
if (strcmp(Postproc, 'none'))
    oi=im2uint8(noi);
elseif (strcmp(Postproc, 'cutoff'))
    oi = im2uint8(noi);
elseif (strcmp(Postproc, 'absolute'))
    oi = abs(noi);
end   
end

