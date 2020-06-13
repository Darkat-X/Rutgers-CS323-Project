%read data from file
fileID = fopen('Example1.txt','r');
A = fscanf(fileID,'%f\n');
number = A(1);

%use array to store points
Array_points = zeros(number,2);
count = 1;
for i = 2:2:number*2 + 1
    Array_points(count,1) = A(i);
    Array_points(count,2) = A(i+1);
    count = count + 1;
end

%find h0 - hx
Array_h = zeros(number-1,1);
for i = 1:number-1
    Array_h(i) = Array_points(i+1,1) - Array_points(i,1);
end

%initialize Matrix
Matrix = zeros(number,number);
Matrix(1,1) = 1;
Matrix(number,number) = 1;
%input number to Matrix
for i = 1:number
    if i == 1
        Matrix(i+1,i) = Array_h(i);
        continue;
    end
    if i == number
        Matrix(number-1,number) = Array_h(i-1);
    else
        Matrix(i,i) = 2*(Array_h(i)+Array_h(i-1));
        Matrix(i-1,i) = Array_h(i-1);
        Matrix(i+1,i) = Array_h(i);
    end
end

Matrix(1,2) = 0;
Matrix(number,number-1) = 0;

%initialize vector
Array_v = zeros(number,1);
for i = 2:number-1
    Array_v(i) = (3/Array_h(i))*(Array_points(i+1,2)-Array_points(i,2)) - 3/Array_h(i-1)*(Array_points(i,2)-Array_points(i-1,2));
end

%start to compute ci by Matrix and vector
Array_c = linsolve(Matrix,Array_v);

%start to compute bi and di
Array_b = zeros(number-1,1);
Array_d = zeros(number-1,1);

for i = 1:number-1
    Array_d(i) = (Array_c(i+1)-Array_c(i))/(3*Array_h(i));
    Array_b(i) = ((Array_points(i+1,2)-Array_points(i,2))/Array_h(i)) - Array_h(i)*((2*Array_c(i)+Array_c(i+1))/3);
end

%print the result
for i = 1:number-1
    fprintf('%f ',Array_points(i,2));
    fprintf('%f ',Array_b(i));
    fprintf('%f ',Array_c(i));
    fprintf('%f\n',Array_d(i));
end

%start to draw graph
for i = 1:number-1
    x = linspace(Array_points(i,1),Array_points(i+1,1),20);
    y = Array_points(i,2) + Array_b(i)*(x-Array_points(i,1)) + Array_c(i)*(x-Array_points(i,1)).^2 + Array_d(i)*(x-Array_points(i,1)).^3;
    plot(x,y);
    hold on;
end
hold off

%close file
fclose(fileID);