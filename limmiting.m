function [out] = limmiting(a)
%This function gets a vector of angles (in degrees!!!) that can be more
%then 180 or less then -180. It returns a vector between 180 and -180.

for i = 1:length(a)
   if a(i)>180
       
       % divide the angle by 180 and round down to know how many times 180 must be reduced
       % from it
       temp = floor(a(i)/180) ;
       if mod(temp,2) == 0 %if temp is even
           out(i) = a(i) - 180*temp ;
           clear temp
       else %if temp is odd
           out(i) = a(i) - 180*(temp+1) ;
           clear temp
       end
   elseif a(i)<-180
       
       % divide the angle by 180 and round down to know how many times 180 must be reduced
       % from it
       temp = ceil(a(i)/180) ;
       if mod(temp,2) == 0
           out(i) = a(i) - temp*180 ;
           clear temp
       else
           out(i) = a(i) + 180*(1-temp) ;
           clear temp
       end
   else %if the angle is already between -180 and 180
       out(i) = a(i) ;
   end

end