%clear;clc
%A denoising method of B-Scan maps based on improved frequency filter！！！！！！designed by Zeng Huike
data = readtable('317_2.csv');

% Initialize a matrix for storing FFT results
fft_results = zeros(257, 995);
ifft_results = zeros(257, 995);
y_ii = zeros(257, 995);
y_i = zeros(257, 995);
N=512;
% Iterate through each column and perform FFT, saving the results to the matrix
for i = 1:995
    column_data = table2array(data(:, i));
    Y = fft(column_data);
    Y=Y(1:N/2+1); 
    y1=real(Y);
    A=abs(Y);
    
    fft_results(:, i) = A;
    
    y_i=20*log10(A);
    a1=sum(y_i)/20;
    a2=a1/257;
    b1=y_i-a2;
    b2=abs(b1)/a1;
    c1=10.^b2;
    c2=c1.^5;
    y_ii=Y.*c2;
   % The weighted spectrum is inversely Fourier transformed
    y_ii = ifft(y_ii); 
    y_ii = real(y_ii); 
    ifft_results(:, i) = y_ii;
end

% Save the result matrix to a file
csvwrite('fft_results317_2.csv', fft_results);
csvwrite('ifft_results317_2.csv', ifft_results);






