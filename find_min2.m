function [min,row,col] = find_min2(A)
%gets a matrix, finds the min value and the indices ;

min = 100 ; 
[rownum,colnum] = size(A) ;
for i = 1:rownum
    for j = 1:colnum
        if A(i,j) <= min
            min = A(i,j) ;
            row = i ;
            col = j ;
        end
    end
end
end

