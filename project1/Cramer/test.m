%This file only is uesed to test Gaussian Elimination
%This algoithm is used in Cramer.m
% n is the dimension of matrix
Matrix = [1,1,2;2,2,2;4,1,0];
n = 3;

Array_tem = zeros(1,n);
sign = 1;
for i = 1:n
    if Matrix(i,i) == 0
        for j = i+1:n
            if Matrix(j,i) ~= 0
                for a = 1:n
                    Array_tem(a) = Matrix(j,a);
                end
                for a = 1:n
                    Matrix(j,a) = Matrix(i,a);
                end
                for a = 1:n
                    Matrix(i,a) = Array_tem(a);
                end
                sign = -sign;
                break;
            end
        end
    end
        for j = i + 1:n
            constant = Matrix(j,i)/Matrix(i,i);
            for x = 1:n
                Matrix(j,x) = Matrix(j,x) - constant*Matrix(i,x);
            end
        end
end
det = sign;
for i = 1:n
    det = det*Matrix(i,i);
end