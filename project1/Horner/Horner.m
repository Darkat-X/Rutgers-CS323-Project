%read data from txt file
fileID = fopen('Example1.txt','r');
A = fscanf(fileID,'%f\n');
run_times = A(1);
x_zero = A(run_times+3);

%initialize array
count = 1;
for i = run_times:-1:0
    B(count) = A(i+2);
    count = count + 1;
end

% B is an array that is used to store a0 a1 a2 ...... an
%start to calculate
apha = B(1);
count = 0;
number = 2;
for j = run_times:-1:1
    count = count + 1;
    for i = 2:j+1
      apha = x_zero * apha + B(i);
      %change B in order to calculate next derivative
      B(i) = apha;
    end
    if count <= 2
        %This part is about p(x0) and p'(x0) 
        fprintf('%f\n',apha);
        apha = B(1);
    else
        %This part is about from p''(x0) to pn(x0)
        fprintf('%f\n',apha*factorial(number))
        apha = B(1);
        number = number + 1;
    end
end
  
%print pn(x)
fprintf('%f\n',B(1)*factorial(number));

%close file
fclose(fileID);