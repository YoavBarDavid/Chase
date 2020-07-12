function [shortened_vector] = vector_trim(vector)
%This function gets a vector with relevant data and a lot of non-relevant
%data in the end of it (measurements that were done after the damselfly landed on the target).
%the function will shorten the vector for it to have only relevant
%data.
tolerance = 0.01 ; %values smaller will be cut from the end of the vector
%turns small values to zero
for s = 1:length(vector)
    if ((abs(vector(s))) < tolerance)
        vector(s) = 0 ;
    end
end

last = find(vector,1,'last') ; %finds last nonzero index in the array

for s=1:last
    shortened_vector(s) = vector(s);
end
end



