% hmin initialization
load = 1; %transmitted load?
abs_Visc = 1; 
surface_Velocity = 46.80; % PLV
pressure_Viscosity_Coefficient = 2.3*10^-8; %pressure viscosity coef for mineral oil
involute_Radius = 1;

% Sierag - Dandage values

c = [40, 60, 80, 100, 120]; %temp (degrees Celsius)

%SAE 30

u_0 = 0.0141 * 10^-6; %viscosity u_0 
b = 1360; %equation constant for respective SAE rating (farenheit)

%



%Sierag-Dandage Equation - viscosity as temp changes
b_Celsius = (b - 32) * (5 / 9); %celsius conversion
var_Visc = 6.89*(10^6).*u_0 .* exp(b_Celsius./(1.8*c + 127));


plot(c,var_Visc, "g");
grid on;
title('Viscosity vs. Temperature (Sierag-Dandage)');
xlabel('Temperature (^{\circ}C)');
ylabel('Viscosity (\mu)');


%calcs

hmin = 1.806 * ((load)^-0.128 * (abs_Visc * surface_Velocity)^0.694 * (pressure_Viscosity_Coefficient)^0.568 * (involute_Radius)^0.434);


%output
disp(var_Visc);
fprintf("Hmin: %d",hmin);