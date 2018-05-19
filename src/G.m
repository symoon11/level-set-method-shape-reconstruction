function y=G(i,j,phi,h)

a=(phi(i,j)-phi(i-1,j))/h;
b=(phi(i+1,j)-phi(i,j))/h;
c=(phi(i,j)-phi(i,j-1))/h;
d=(phi(i,j+1)-phi(i,j))/h;

ap=max(a,0);
am=min(a,0);
bp=max(b,0);
bm=min(b,0);
cp=max(c,0);
cm=min(c,0);
dp=max(d,0);
dm=min(d,0);
if(phi(i,j)>0)
    y=sqrt(max(ap^2,bm^2)+max(cp^2,dm^2))-1;
elseif(phi(i,j)<0)
    y=sqrt(max(am^2,bp^2)+max(cm^2,dp^2))-1;
else
    y=0;
end

end