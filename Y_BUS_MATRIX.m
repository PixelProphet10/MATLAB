number_of_elements = [1;2;3;4;5;6];
bus_from = [1;1;5;4;3;5];
bus_to = [2;5;4;3;2;6];
r=[0.01;0.02;0.01;0.01;0.02;0.01];
x=[0.1;0.2;0.1;0.1;0.2;0.1];
B=[1;1;1;1;1;1];
L=[50;20;30;25;50;20];


data= [number_of_elements,bus_from,bus_to,r,x,B,L];


disp('given data :');
disp(data);

max_bus_from = max(data(:, 2));
max_bus_to = max(data(:, 3));
number_of_buses=max(max_bus_to,max_bus_from);
disp('number of buses :');
disp(number_of_buses);

Ybus=zeros(number_of_buses,number_of_buses);

Z= r.*L + 1i.*x.*L;
% disp('Z matrix :');
% disp(Z);

Y = 1./Z;
disp('Admittance matrix :')
disp(Y);


for i = 1:size(data, 1)
    element = data(i, 1);
    b_from=data(i,2);
    b_to=data(i,3);
    Ybus(b_from,b_to) = -(Y(i,1));   
    Ybus(b_to, b_from) = -(Y(i,1));

    Ybus(b_from,b_from)=Ybus(b_from,b_from)+Y(i,1);
    Ybus(b_to,b_to)=Ybus(b_to,b_to)+Y(i,1);

end
disp('Y Bus matrix');
disp(Ybus);
