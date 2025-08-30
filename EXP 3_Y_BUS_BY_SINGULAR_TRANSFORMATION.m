clc;
clear;

% Given Data
z = [1 2 0.01 0.15;
    1 3 0.02 0.25;
    1 4 0.03 0.35;
    2 3 0.03 0.35;
    3 4 0.01 0.15;
    4 5 0.04 0.50];

%To Find Order Of The Matrix
busFrom =z(:,1);
busTo =z(:,2);
nbus = max(max(z(:,1:2)));
Rows = length(z);
A = zeros(Rows,nbus);

%Logical Operation For Construction Of Matrix
for i = 1:Rows
     A(i,busFrom(i))= 1;
     A(i,busTo(i)) = -1;   
end

%Result
disp (A);

%Impendance Calculation
Imp = z(: , end-1) + 1i* z(: , end);

%Admittance Calculation
Y1 = 1./Imp;

%Calculate Y-Primitive
Y_prim = diag(Y1);

%Calculate 'A' Transpose
A_trans = transpose(A)

% Calculate the bus admittance matrix Using Singular Transformation Method
Y_bus = A_trans*Y_prim*A 

