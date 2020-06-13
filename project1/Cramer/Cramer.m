% test.m is a sample of doing Gaussian Elimination
%read data from txt file
fileID = fopen('Example1.txt','r');
A = fscanf(fileID,'%f\n');

%initialize matrix and vector
Matrix(1,1) = 0;
count = 2;
%row and n is dimension of matrix
row = A(1);
n = row;
for i = 1:row
    for j = 1:row
        Matrix(i,j) = A(count);
        count = count + 1;
    end
end
%Matrix_tem will be used to calculate determinant of matrix
Matrix_tem = Matrix;

vector = zeros(row,1);
for i = 1:row
    vector(i) = A(count);
    count = count + 1;
end

%start to compute
%The code between two lines is using Gaussian Elimination to get
%determinant
%-----------------------------
Array_tem = zeros(1,n);
%to distinguish positive or negative
sign = 1;
for i = 1:n
    if Matrix_tem(i,i) == 0
        for j = i+1:n
            if Matrix_tem(j,i) ~= 0
                for a = 1:n
                    Array_tem(a) = Matrix_tem(j,a);
                end
                for a = 1:n
                    Matrix_tem(j,a) = Matrix_tem(i,a);
                end
                for a = 1:n
                    Matrix_tem(i,a) = Array_tem(a);
                end
                sign = -sign;
                break;
            end
        end
    end
        for j = i + 1:n
            constant = Matrix_tem(j,i)/Matrix_tem(i,i);
            for x = 1:n
                Matrix_tem(j,x) = Matrix_tem(j,x) - constant*Matrix_tem(i,x);
            end
        end
end
det_A = sign;
for i = 1:n
    det_A = det_A*Matrix_tem(i,i);
end
%-----------------------------
fprintf('%s','determinant A = ');
fprintf('%f\n',det_A);

new_Matrix = Matrix;
%This is an array that is used to store answer
ans_Array = zeros(row,1);
for p = 1:row
    %initialize A1,A2,A3,....... Matrix <-- new_Matrix
    for q = 1:row
        new_Matrix(q,p) = vector(q);
    end
    %Gaussian Elimination
    %-----------------------------------
    Array_tem = zeros(1,n);
    sign = 1;
    for i = 1:n
       if new_Matrix(i,i) == 0
          for j = i+1:n
             if new_Matrix(j,i) ~= 0
               for a = 1:n
                   Array_tem(a) = new_Matrix(j,a);
               end
               for a = 1:n
                   new_Matrix(j,a) = new_Matrix(i,a);
               end
               for a = 1:n
                   new_Matrix(i,a) = Array_tem(a);
               end
               sign = -sign;
               break;
             end
          end
        end
        for j = i + 1:n
            constant = new_Matrix(j,i)/new_Matrix(i,i);
            for x = 1:n
                new_Matrix(j,x) = new_Matrix(j,x) - constant*new_Matrix(i,x);
            end
        end
    end
    det_A_n = sign;
    for i = 1:n
       det_A_n = det_A_n*new_Matrix(i,i);
    end
    %-----------------------------------
    fprintf('%s','determinant A');
    fprintf('%d',p);
    fprintf('%s',' = ');
    fprintf('%f\n',det_A_n);
    %get answer by Cramer's method
    ans_Array(p) = det_A_n/det_A;
    new_Matrix = Matrix;
end

%print answer form ans_Array
for i = 1:row
    fprintf('%s','x');
    fprintf('%d',i);
    fprintf('%s',' = ');
    fprintf('%f\n',ans_Array(i));
end
%close file
fclose(fileID);
