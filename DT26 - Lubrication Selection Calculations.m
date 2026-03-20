% hmin initialization
gearTorque = 52; %N*m
gearPressureAngle = 20; % angle in degrees

%SAE 30 - abs visc for worst case
absolute_Viscosity = 0.0141 * 10^-6; %abs viscosity u_0 
equation_Constant = 1360; %equation constant for respective SAE rating (farenheit)
highest_temperature = 100; %celsius - for worst case scenario


sun_Gear_PD = 18.90;%mm (Pitch Diameter)
large_Planet_PD = 46.80; %mm (Pitch Diameter)

pressure_Viscosity_Coefficient = 2.3*10^-8; %pressure viscosity coef for mineral oil


%----------------------------------------------------------------------------------------------------------------------------------------------------
%Variable Viscosity Calcs
% Sierag - Dandage values

c = [40, 60, 80, 100, 120]; %temp (degrees Celsius)

%SAE 30

u_0 = 0.0141 * 10^-6; %abs viscosity u_0 
b = 1360; %equation constant for respective SAE rating (farenheit)

%Sierag-Dandage Equation - viscosity as temp changes (Shigley's)
b_Celsius = (b - 32) * (5 / 9); %farenheit to celsius conversion
var_Visc = 6.89*(10^6).*u_0 .* exp(b_Celsius./(1.8*c + 127));

%plot
plot(c,var_Visc, "g");
grid on;
title('Viscosity vs. Temperature (Sierag-Dandage)');
xlabel('Temperature (^{\circ}C)');
ylabel('Viscosity (\mu)');

%----------------------------------------------------------------------------------------------------------------------------------------------------

%absolute viscosity calcs
equation_Constant_Conv = (equation_Constant - 32) * (5 / 9); %farenheit to celsius conversion
abs_Visc = 6.89*(10^6).*absolute_Viscosity .* exp(equation_Constant_Conv./(1.8*highest_temperature + 127));

%PLV calculations
surface_Velocity = (pi*(sun_Gear_PD*0.001)*large_Planet_PD)/60; % m/s (Pitch Line Velocity)

%Effective Radius Calcs
radii_Curvature_Sun = 0.5*sun_Gear_PD*sin(gearPressureAngle);
radii_Curvature_Large = 0.5*large_Planet_PD*sin(gearPressureAngle);
effective_Radius = (radii_Curvature_Sun*radii_Curvature_Large)/(radii_Curvature_Sun+radii_Curvature_Large); %meters

%normal Load calcs
load = cos(gearPressureAngle)*gearTorque; % Newtons

% hmin calc
hmin = 1.806 * ((load)^-0.128 * (abs_Visc * surface_Velocity)^0.694 * (pressure_Viscosity_Coefficient)^0.568 * (effective_Radius)^0.434);


%----------------------------------------------------------------------------------------------------------------------------------------------------
%output
disp(var_Visc);
fprintf("h_min: %d",hmin);
