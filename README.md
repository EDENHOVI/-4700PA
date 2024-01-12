% Load data from the text file
data = load(‘FR408_design.txt');  % Replace 'your_data_file.txt' with your actual file name

% Extract frequency, real, and imaginary parts of S-parameters
frequency = data(:, 1);  % Assuming the frequency is in the first column
real_part = data(:, 2);  % Assuming the real part is in the second column
imaginary_part = data(:, 3);  % Assuming the imaginary part is in the third column

% Create a complex S-parameter vector
s_parameters = complex(real_part, imaginary_part);

% Save data in Touchstone (S1P) format
write_touchstone(‘FR408_design.s1p', frequency, s_parameters, 'dB');  % Replace 'output_file.s1p' with your desired output file name