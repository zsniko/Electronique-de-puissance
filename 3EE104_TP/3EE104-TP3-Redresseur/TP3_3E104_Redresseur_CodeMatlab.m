clear all; clf; 
%% CODE MATLAB - SIMULATION REDRESSEMENT COMMANDÉ SIMPLE ALTERNANCE

% donnees: valeurs de composants
V = 15;
R = 10;
f = 50;
omega = 2*pi*f;
L = 0.03;
alpha = 45;

% Chronogramme de Ve 
thetha = linspace(0,360,1000);
Ve = V * sqrt(2) * sind(thetha);
figure(1)
subplot(2,2,1);
p1 = plot(thetha,Ve,'LineWidth',2.0);
set(p1,'Color',[0 0.6 0.3]),grid on
legend('Ve');
xlabel('Thetha [°]');
ylabel('Tension [V]');
xticks([0 90 180 270 360]) % spicify axis tick values
xlim([-20 370])
ylim([-V*sqrt(2)*1.5 V*sqrt(2)*1.5])


% Chronogramme de Is 
K = sqrt(2)*V*exp(R*alpha/(L*omega))*((L*omega/(R^2+(L*omega)^2))...
    *cosd(alpha) - (R/(R^2+(L*omega)^2))*sind(alpha));
Is = max((R/(R^2+(L*omega)^2))*V*sqrt(2)*sind(thetha) - ...
    (L*omega/(R^2+(L*omega)^2))*V*sqrt(2)...
    *cosd(thetha) + K*exp(-R*thetha/(L*omega)),0);
% Is = 0.*(thetha<alpha & thetha>180+alpha)+((R/(R^2+(L*omega)^2))*V*sqrt(2)*sind(thetha) - ...
%     (L*omega/(R^2+(L*omega)^2))*V*sqrt(2)...
%     *cosd(thetha) + K*exp(-R*thetha/(L*omega))) .* (thetha>=alpha&thetha<=180+alpha);
subplot(2,2,4);
p2 = plot(thetha,Is,'LineWidth',2.0);
set(p2,'Color',[0 0.2 1]),grid on
legend('Is,Ith');
xlabel('Thetha [°]');
ylabel('Tension [V]');
xticks([0 90 180 270 360]) % spicify axis tick values
xlim([-20 370])

% Chronogramme de Vs 
ix = Is>0; % variable logique - detection Is > 0
Vs = ix.*Ve; % Vs = Ve quand Is > 0 et 0 sinon
subplot(2,2,2);
p3 = plot(thetha,Vs,'LineWidth',2.0);
set(p3,'Color',[1 0.2 0.2]),grid on
legend('Vs');
xlabel('Thetha [°]');
ylabel('Tension [V]');
xticks([0 90 180 270 360]) % spicify axis tick values
xlim([-20 370])

% Chronogramme de Vth
Vth = Ve - Vs;
subplot(2,2,3);
p4 = plot(thetha,Vth,'LineWidth',2.0);
set(p4,'Color',[1 0.5 0]),grid on;
legend('Vth');
xlabel('Thetha [°]');
ylabel('Tension [V]');
xticks([0 90 180 270 360]) % spicify axis tick values
xlim([-20 370])


txt = ['Chronogramme pour α = ',num2str(alpha),'°'];
sgtitle(txt); % Titre de la figure des 4 subplots avec alpha variable




