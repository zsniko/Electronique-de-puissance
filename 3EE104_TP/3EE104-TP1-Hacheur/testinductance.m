clear all;clf;

%% parametres hacheur 
U = 30;
R = 10;
L = 8*10^-3;
L2 = 30*10^-3;
T = 1*10^-3;
alpha = 0.5;

%% i0 et ia 
i0 = (U/R)*(exp((R/L)*alpha*T)-1)/(exp(R*T/L)-1);
ia = (U/R)+(i0-U/R)*exp(-R*alpha*T/L);
i02 =(U/R)*(exp((R/L2)*alpha*T)-1)/(exp(R*T/L2)-1);
ia2 =(U/R)+(i02-U/R)*exp(-R*alpha*T/L2);

t = linspace(-T,T,1000);
is=((U/R)+(i0-U/R)*exp(-R*t/L)).*(t>=0 & t<alpha*T) + (ia*exp((-R/L)*(t-alpha*T))).*(t>=alpha*T & t<=T) + ((U/R)+(i0-U/R)*exp(-R*(t+T)/L)).*(t>=-T & t<(-T+alpha*T)) + (ia*exp((-R/L)*(t+T-alpha*T))).*(t>=(-T+alpha*T) & t<0);
is2 = ((U/R)+(i02-U/R)*exp(-R*t/L2)).*(t>=0 & t<alpha*T) + (ia2*exp((-R/L2)*(t-alpha*T))).*(t>=alpha*T & t<=T) + ((U/R)+(i02-U/R)*exp(-R*(t+T)/L2)).*(t>=-T & t<(-T+alpha*T)) + (ia2*exp((-R/L2)*(t+T-alpha*T))).*(t>=(-T+alpha*T) & t<0)
Ondulation(1) = ia-i0;
Ondulation(2) = ia2-i02;
izero(1) = i0;
izero(2) = i02;
ialpha(1) = ia;
ialpha(2) = ia2;
is_moy(1) = mean(is);
is_moy(2) = mean(is2);
%% plot fonction periodique
syms is(t) ;
i = -3;
interval = [i*T -i*T]
pw = [];
while i <= diff(interval/(T))
    is(t) = piecewise(i*T<=t<(alpha*T)+(i*T),((U/R)+(i0-U/R)*exp(-R*(t-T*i)/L)),(alpha*T)+(i*T)<=t<=T+(i*T),(ia*exp((-R/L)*((t-T*i)-alpha*T))));
    i = i + 1;
    pw = [pw is];
end 

syms is2(t) a(t) b(t) ;
is2(t) = piecewise(0<=t<alpha*T,(U/R)+(i02-U/R)*exp(-R*t/L2),alpha*T<=t<=T,ia2*exp((-R/L2)*(t-alpha*T)));
interval = [-3*T 3*T];
pw2 = is2;
for i = 1:diff(interval/T)
   a(t) = piecewise(i*T<=t<alpha*T+(i*T),(U/R)+(i02-U/R)*exp(-R*(t-T*i)/L2),alpha*T+(i*T)<=t<=T+(i*T),ia2*exp((-R/L2)*((t-T*i)-alpha*T)));
   b(t) = piecewise(i*-T<=t<alpha*T+(i*-T),(U/R)+(i02-U/R)*exp(-R*(t+T*i)/L2),alpha*T+(i*-T)<=t<=T+(i*-T),ia2*exp((-R/L2)*((t+T*i)-alpha*T))); 
pw2 = [pw2 a b];
end

figure(1)
fp1=fplot(pw,interval,'b'),grid on,hold all
fp2=fplot(pw2,interval,'r'),grid on
legend([fp1;fp2],'L1=8mH','L2=30mH');


title("Chronogramme de is");
ylabel("Courant[A]");
xlabel("Temps[s]");
ylim([0 U/R])

for i=1:2
fprintf("Courant moyen = %.4f [A]\n",is_moy(i));
fprintf("Ondulation = %.4f [A]\n",Ondulation(i));
fprintf("i_0 = %.4f [A]\n",izero(i));
fprintf("i_alpha = %.4f [A]\n",ialpha(i));
end