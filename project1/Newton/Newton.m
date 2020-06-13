%read data from txt file
fileID = fopen('Example1.txt','r');
A = fscanf(fileID,'%f\n');
%dimension of matrix
highest_index = A(1);
x_zero = A(highest_index+3);
error_tolerance = A(highest_index+4);
iteration = A(highest_index+5);

%initialize apha and beta in Horner method
apha = A(highest_index+2);
beta = A(highest_index+2);
x_one = x_zero;
%start to compute
for i = 0:iteration
    %using Horner method to calculate P(x) and P'(x)
    %apha is p(x)
    %beta is p'(x)
    apha = A(highest_index+2);
    beta = A(highest_index+2);
    for j = highest_index -1:-1:1
        apha = apha * x_zero + A(j+2);
        beta = beta * x_zero + apha;
    end
    apha = apha * x_zero + A(2);
    %using Newton's methos 
    x_zero = x_zero - (apha/beta);
    %calculate error and compare
    if x_one - x_zero < error_tolerance
        %print answer and stop loop
        fprintf('%f\n',x_one);
        break;
    end
    %update x1 in every iteration
    x_one = x_zero;
end

if(x_one - x_zero>error_tolerance)
    fprintf('%s\n','Cannot find');
end

%close file
fclose(fileID);