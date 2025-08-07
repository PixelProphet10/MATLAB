% Given Data

Vr = 400e3;        % Receiving end line voltage (V)
Pr = 400e6;        % Receiving end power (W)
R = 0.01;          % Resistance per km (Ohm)
X = 0.1;           % Reactance per km (Ohm)
B = 1.1e-6;        % Shunt susceptance per km (S)
pf = 0.9;          % Power factor (lagging)
l = 20;            % Length of line (km)

% Total series impedance
Z = (R + i*X) * l;      

% Receiving end voltage (phase)
Vr_phase = Vr / sqrt(3);

% Receiving end current magnitude and angle
Ir_mag = Pr / (sqrt(3) * Vr * pf);   % Line current
phi = acos(pf);                      % Power factor angle (lagging)
Ir = Ir_mag * exp(-1i * phi);        % Receiving-end current (phasor)

% Sending-end voltage (phase)
Vs_phase = Vr_phase + Z * Ir;

% Total sending-end current
Is = Ir_mag ; 

% Line-to-line sending-end voltage
Vs = abs(Vs_phase) * sqrt(3);
Is_mag = abs(Is);

% Transmission Efficiency (%)
Efficiency = (Vr / Vs) * 100;

% Voltage Regulation (%)
VR = ((abs(Vs_phase) - abs(Vr_phase)) / abs(Vr_phase)) * 100;


% Result
fprintf('Sending-end voltage (line-to-line): %.2f kV\n', Vs / 1e3);
fprintf('Sending-end current magnitude: %.2f A\n', Is_mag);
fprintf('Voltage Regulation: %.2f %%\n', VR);
fprintf('Transmission Efficiency: %.2f %%\n', Efficiency);
