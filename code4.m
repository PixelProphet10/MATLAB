clc;
clear;

% Given data
Vr_line = 400e3;        % Receiving end line voltage (V)
Pr = 400e6;             % Receiving end power (W)
R = 0.01;               % Ohm/km
X = 0.1;                % Ohm/km
B = 1.1e-6;             % S/km
pf = 0.9;               % lagging
l = 300;                % km

% Derived quantities
Z = (R + 1i*X);         % per km series impedance
Y = (1i*B);             % per km shunt admittance

Z_total = Z * l;        % total line impedance
Y_total = Y * l;        % total line admittance

gamma = sqrt(Z*Y);      % Propagation constant
Zc = sqrt(Z/Y);         % Characteristic impedance

% ABCD parameters
A = cosh(gamma*l);
B = Zc * sinh(gamma*l);
C = (1/Zc) * sinh(gamma*l);
D = A; 

% Receiving end calculations
Vr_ph = Vr_line / sqrt(3);                    % Phase voltage at receiving end
Ir_mag = Pr / (sqrt(3)*Vr_line*pf);           % Line current magnitude
phi = acos(pf);                               % Power factor angle
Ir_ph = Ir_mag * (cos(phi) - 1i*sin(phi));    % Complex current

% Sending end voltage and current
Vs_ph = A * Vr_ph + B * Ir_ph;
Is_ph = C * Vr_ph + D * Ir_ph;

% Sending end power
Ps = 3 * real(Vs_ph * conj(Is_ph)); 

% Voltage regulation
VR = (abs(Vs_ph) - abs(Vr_ph)) / abs(Vr_ph) * 100;

% Efficiency
efficiency = (Pr / Ps) * 100;

% Result
fprintf('Sending End Voltage (line): %.2f kV\n', abs(Vs_ph)*sqrt(3)/1e3);
fprintf('Sending End Current: %.2f A\n', abs(Is_ph));
fprintf('Voltage Regulation: %.2f %%\n', VR);
fprintf('Efficiency: %.2f %%\n', efficiency);
