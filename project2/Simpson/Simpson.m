%read data from file
fileID = fopen('Example1.txt','r');
function_x = fscanf(fileID,'%s\n',1);
interval = fscanf(fileID,'%f\n',2);
subintervals = fscanf(fileID,'%d\n',1);

%transfer string to function
f = inline(function_x); %#ok<DINLN>

%create a n*3 array to store the value of i, xi and f(xi)
A = zeros(subintervals+1,3);
subintervals_value = (interval(2) - interval(1))/subintervals;
xi = interval(1);

for i = 1:subintervals+1
    A(i,1) = i;
    A(i,2) = xi;
    A(i,3) = feval(f,xi);
    xi = xi + subintervals_value;
end

%get the sum of odd number iterations and even number iterations
odd = 0;
even = 0;
for i = 2:2:subintervals
    odd = odd + A(i,3);
end

for i = 3:2:subintervals
    even = even + A(i,3);
end

%use Simpson rule
answer = (subintervals_value/3)*(A(1,3)+A(subintervals+1,3)+2*even+4*odd);
fprintf('%s','The approximate value is ');
fprintf('%f\n',answer);
%close file
fclose(fileID);