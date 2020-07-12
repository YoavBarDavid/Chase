function lg=velocity(a, freq)
%  Calculate the time derevative for X Y Z position data assuming
%  equally spaced abssisa of frequency(freq in Hz)

z=length(a);

   lg(2,:)=(-11.*a(1,:)+3.*a(2,:)+7.*a(3,:)+a(4,:))./(20./freq);
   lg(1,:)=(-21.*a(1,:)+13.*a(2,:)+17.*a(3,:)-9.*a(4,:))./(20./freq);
   lg(z-1,:)=-(-21.*a(z,:)+13.*a(z-1,:)+17.*a(z-2,:)-9.*a(z-3,:))./(20./freq);
   lg(z,:)=-(-11.*a(z,:)+3.*a(z-1,:)+7.*a(z-2,:)+a(z-3,:))./(20./freq);

for k=3:(z-2)
      lg(k,1)=(-2.*a(k-2,1)-a(k-1,1)+a(k+1,1)+2.*a(k+2,1))./(10./freq);
      %lg(i,2)=(-2.*a(i-2,2)-a(i-1,2)+a(i+1,2)+2.*a(i+2,2))./(10./freq);
      %lg(i,3)=(-2.*a(i-2,3)-a(i-1,3)+a(i+1,3)+2.*a(i+2,3))./(10./freq);
end

end