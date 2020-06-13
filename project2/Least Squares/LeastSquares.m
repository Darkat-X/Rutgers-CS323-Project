%read data from file
fileID = fopen('Example1.txt','r');
A = fscanf(fileID,'%f\n');
number = A(1);
degree = A(2);

%use array to store points
Array_x = zeros(number,1);
Array_y = zeros(number,1);
count = 1;
for i = 3:2:number*2 + 1
    Array_x(count,1) = A(i);
    Array_y(count,1) = A(i+1);
    count = count + 1;
end

%initialize Matrix A
Matrix = zeros(degree+1,degree+1);
for i = 1:degree+1
    count = i-1;
    for j = 1:degree+1
            Matrix(i,j) = sum(Array_x.^count);
            count = count + 1;
    end
end
Matrix(1,1) = number;

%initialize Array b
Array_b = zeros(degree+1,1);
count = 1;
for i = 2:degree + 1
    Array_b(i) = sum(Array_y.*(Array_x.^count));
    count = count + 1;
end
Array_b(1) = sum(Array_y);

%get answer
Answer = linsolve(Matrix,Array_b);
for i = 1:degree+1
    if i == degree+1
        fprintf('%f\n',Answer(i));
    else
        fprintf('%f ',Answer(i));
    end
end

%draw graph
xx = (Array_x(1):0.1:Array_x(number));
x_size = size(xx);
yy = zeros(1,x_size(2));
count = 0;
for i = 1:degree+1
    yy = yy + Answer(i)*xx.^count;
    count = count + 1;
end

plot(xx,yy,Array_x,Array_y,'*');
%close file
fclose(fileID);