clear all;clf;


U = 30;
R = 15;
L = 10*10^-3;
T = 2*10^-3;
alpha = 0.5;
alpha1 = 0.7;
alpha2 = 0.3;

i0 = (U/R)*(exp((R/L)*alpha*T)-1)/(exp(R*T/L)-1)
ia = (U/R)+(i0-U/R)*exp(-R*alpha*T/L)

i0_1 = (U/R)*(exp((R/L)*alpha1*T)-1)/(exp(R*T/L)-1)
ia_1 = (U/R)+(i0_1-U/R)*exp(-R*alpha1*T/L)

i0_2 = (U/R)*(exp((R/L)*alpha2*T)-1)/(exp(R*T/L)-1)
ia_2 = (U/R)+(i0_2-U/R)*exp(-R*alpha2*T/L)


t = linspace(-T,T,1000);

is = zeros(size(t));
is =((U/R)+(i0-U/R)*exp(-R*t/L)).*(t>=0 & t<alpha*T) + (ia*exp((-R/L)*(t-alpha*T))).*(t>=alpha*T & t<=T) + ((U/R)+(i0-U/R)*exp(-R*(t+T)/L)).*(t>=-T & t<(-T+alpha*T)) + (ia*exp((-R/L)*(t+T-alpha*T))).*(t>=(-T+alpha*T) & t<0)
is_1 = ((U/R)+(i0_1-U/R)*exp(-R*t/L)).*(t>=0 & t<alpha1*T) + (ia_1*exp((-R/L)*(t-alpha1*T))).*(t>=alpha1*T & t<=T) + ((U/R)+(i0_1-U/R)*exp(-R*(t+T)/L)).*(t>=-T & t<(-T+alpha1*T)) + (ia_1*exp((-R/L)*(t+T-alpha1*T))).*(t>=(-T+alpha1*T) & t<0)
is_2 = ((U/R)+(i0_2-U/R)*exp(-R*t/L)).*(t>=0 & t<alpha2*T) + (ia_2*exp((-R/L)*(t-alpha2*T))).*(t>=alpha2*T & t<=T) + ((U/R)+(i0_2-U/R)*exp(-R*(t+T)/L)).*(t>=-T & t<(-T+alpha2*T)) + (ia_2*exp((-R/L)*(t+T-alpha2*T))).*(t>=(-T+alpha2*T) & t<0)

is_moy(1) = mean(is);
is_moy(2) = mean(is_1);
is_moy(3) = mean(is_2);
Ondulation(1) = ia-i0;
Ondulation(2) = ia_1-i0_1;
Ondulation(3) = ia_2-i0_2;
izero(1) = i0;
izero(2) = i0_1;
izero(3) = i0_2;
ialpha(1) = ia;
ialpha(2) = ia_1;
ialpha(3) = ia_2;

plot(t,is,'b'),grid on,hold on;
plot(t,is_1,'r')
plot(t,is_2,'m')

legend("alpha = 0.5","alpha = 0.7","alpha = 0.3");
title("Chronogramme de is");
ylabel("Courant[A]");
xlabel("Temps[s]");
ylim([0 U/R]);

for i = 1:3
fprintf("Courant moyen = %.4f [A]\n",is_moy(i));
fprintf("Ondulation = %.4f [A]\n",Ondulation(i));
fprintf("i_0 = %.4f [A]\n",izero(i));
fprintf("i_alpha = %.4f [A]\n",ialpha(i));
end 