function [outVec] = no_jumping(inVec)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

for i = 1:length(inVec)-1
   if  inVec(i+1) - inVec(i) < -250 %Jumping from around 178 to around -178
       inVec(i+1) = 360 + inVec(i+1) ;
   elseif inVec(i+1) - inVec(i) > 250 %Jumping from around -178 to around 178
       inVec(i+1) =  inVec(i+1) - 360 ;
   else
       inVec(i+1) = inVec(i+1) ;
   end   
    
end

outVec = inVec ;

end

