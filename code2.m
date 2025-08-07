clc;
clear;

% Given data
Vr = 400e3;          % Receiving end line voltage (V)
Pr = 400e6;          % Receiving end power (W)
R = 0.01;            % Resistance per km (Ohm/km)
X = 0.1;             % Reactance per km (Ohm/km)
B = 1.1e-6;          % Shunt susceptance per km (S/km)
pf = 0.9;            % Power factor
l = 100;             % Line length (km)

% Derived values
Z = (R + 1i*X) * l;          % Total series impedance
Y = 1i * B * l;              % Total shunt admittance
Vr_ph = Vr / sqrt(3);        % Receiving end phase voltage
Ir_mag = Pr / (sqrt(3) * Vr * pf);   % Receiving end line current (magnitude)
phi = acos(pf);                      % Power factor angle (lagging)
Ir_ph = Ir_mag * exp(-1i*phi) ;      % Receiving-end current (phasor)  

% For Pi-model
A = 1 + (Y * Z)/2;
B = Z;
C = Y*(1+((Y*Z)/4));
D = A;

% Sending end voltage and current
Vs = A * Vr_ph + B * Ir_ph;
Is = C * Vr_ph + D * Ir_ph;

% Sending power
Ps = 3 * real(Vs * conj(Is)); 

% Voltage Regulation and Efficiency 
VR = (abs(Vs) - abs(Vr_ph)) / abs(Vr_ph) * 100;
efficiency = (Pr / Ps) * 100;

% Result
fprintf('Sending End Voltage (line): %.2f kV\n', abs(Vs)*sqrt(3)/1e3);
fprintf('Sending End Current: %.2f A\n', abs(Is));
fprintf('Voltage Regulation: %.2f %%\n', VR);
fprintf('Efficiency: %.2f %%\n', efficiency);

