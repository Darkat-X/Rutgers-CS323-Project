%read data from txt file
fileID = fopen('Example1.txt','r');
A = fscanf(fileID,'%f\n');
n = A(1);

count = 2;
Array_points(1,1) = 0;
for i = 1:n+1
    Array_points(i,1) = A(count);
    count = count + 1;
    Array_points(i,2) = A(count);
    count = count + 1;
end

x = A(count);

%input data to matrix
Matrix(1,1) = 0;
count = 1;
for i = 1:n+1
    Matrix(i,i) = Array_points(i,2);
end

%start to compute based on lecture note
for d = 2:n+2
    for i = 1:n+2-d
        j=i+d-1;
        Matrix(i,j) = ((x-Array_points(i,1))*Matrix(i+1,j)-(x-Array_points(j,1))*Matrix(i,j-1))/(Array_points(j,1)-Array_points(i,1));
    end
end

fprintf('%f\n',Matrix(1,n+1))
    

%close file
fclose(fileID);