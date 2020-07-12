function [standard_deviation,average] = calc_std_mean(vector,index_vector)
% This function gets a vector filled with zeroes and relavent numbers and an
% index vector (containing the index of  successful experiments).
% returns the standard deviation and the average of the non-zero values.

for hh = 1:length(index_vector)
   newvec(hh) = vector(index_vector(hh)) ; %% calc new vector from the indices of the index vector.
end

standard_deviation = std(newvec) ;
average = mean(newvec) ;

end

