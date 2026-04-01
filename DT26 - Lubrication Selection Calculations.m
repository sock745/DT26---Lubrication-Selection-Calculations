%Mercon V, SAE 5W-30, SAE 75W-90, Redline Superlight shockproof

% hmin initialization
gearTorque = 52; %N*m
gearPressureAngle = 20; % angle in degrees

%lube values
lubeNames = ["Mercon 5", "Redline Superlight Shockproof", "SAE 5W-30", "SAE 75W-90"];
absolute_Viscosity = [7.5, 12, 10.5, 15.7]; %abs viscosity u_0  cST (centistokes), lowest ranges taken to be conservative
highest_temperature = 100; %celsius - conservative value
hmin = zeros(1,length(absolute_Viscosity));
RPM = 20000; %rotations per min

sun_Gear_PD = 18.90;%mm (Pitch Diameter)
sun_Gear_PD_m = (sun_Gear_PD/2)/1000; %m
large_Planet_PD = 46.80; %mm (Pitch Diameter)

pressure_Viscosity_Coefficient = 2.3*10^-8; %pressure viscosity coef for mineral oil

%----------------------------------------------------------------------------------------------------------------------------------------------------

%PLV calculations
surface_Velocity = (pi*(sun_Gear_PD*0.001)*RPM)/60; % m/s (Pitch Line Velocity)

%Effective Radius Calcs
radii_Curvature_Sun = 0.5*sun_Gear_PD*sind(gearPressureAngle);
radii_Curvature_Large = 0.5*large_Planet_PD*sind(gearPressureAngle);
effective_Radius = 0.001*((radii_Curvature_Sun*radii_Curvature_Large)/(radii_Curvature_Sun+radii_Curvature_Large)); %meters

%normal Load calcs
load = (gearTorque/sun_Gear_PD_m)/cosd(gearPressureAngle); % Newtons

% hmin calc
for i=1:length(lubeNames)
    %SI conversion cST to PaS (centistokes to pascal seconds)
    absolute_Viscosity_SI = absolute_Viscosity(i)* 850 * 10^-6;
    hmin(i) = 10^6*(1.806 * ((load)^-0.128 .* (absolute_Viscosity_SI .* surface_Velocity).^0.694 .* (pressure_Viscosity_Coefficient)^0.568 * (effective_Radius)^0.434));
end


%----------------------------------------------------------------------------------------------------------------------------------------------------
%output
results = table(lubeNames', hmin','VariableNames', {'Lubricant','h_min(microns)'});
disp (results);
