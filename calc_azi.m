function [angle] = calc_azi(x1,y1,x2,y2,x3,y3)
% this function calculates the line of sight (LoS) angle with respect to
% the body of the damselfly. returns radians.

damselfly = [x1-x2 , y1-y2] ; %damselfly body vector
h2t =       [x3-x1 , y3-y1] ; %head to target
    for i = 1:length(y1)
        MONEH(i) = dot(damselfly(i,:),h2t(i,:)) ;
        MECHANE(i) = norm(damselfly(i,:))*norm(h2t(i,:)) ;
        angle(i) = acos(MONEH(i)/MECHANE(i)) ;
    end

end
