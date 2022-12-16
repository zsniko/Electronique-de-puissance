clear all;clf;

%% parametres hacheur 
U = 30;
R = 10;
L = 8*10^-3;
T = 1*10^-3;
T2 = 0.2*10^-3;
alpha = 0.5;

%% i0 et ia 
i0 = (U/R)*(exp((R/L)*alpha*T)-1)/(exp(R*T/L)-1);
ia = (U/R)+(i0-U/R)*exp(-R*alpha*T/L);
i02 =(U/R)*(exp((R/L)*alpha*T2)-1)/(exp(R*T2/L)-1);
ia2 =(U/R)+(i02-U/R)*exp(-R*alpha*T2/L);

t = linspace(-T,T,1000);
is=((U/R)+(i0-U/R)*exp(-R*t/L)).*(t>=0 & t<alpha*T) + (ia*exp((-R/L)*(t-alpha*T))).*(t>=alpha*T & t<=T) + ((U/R)+(i0-U/R)*exp(-R*(t+T)/L)).*(t>=-T & t<(-T+alpha*T)) + (ia*exp((-R/L)*(t+T-alpha*T))).*(t>=(-T+alpha*T) & t<0);
Ondulation(1) = ia-i0;
Ondulation(2) = ia2-i02;
izero(1) = i0;
izero(2) = i02;
ialpha(1) = ia;
ialpha(2) = ia2;
is_moy(1) = mean(is);
t = linspace(-T2,T2,1000);
is2 = ((U/R)+(i02-U/R)*exp(-R*t/L)).*(t>=0 & t<alpha*T2) + (ia2*exp((-R/L)*(t-alpha*T2))).*(t>=alpha*T2 & t<=T2) + ((U/R)+(i02-U/R)*exp(-R*(t+T2)/L)).*(t>=-T2 & t<(-T2+alpha*T2)) + (ia2*exp((-R/L)*(t+T2-alpha*T2))).*(t>=(-T2+alpha*T2) & t<0)
is_moy(2) = mean(is2);
%% plot fonction periodique
syms is(t) ;
i = -1;
interval = [i*T -i*T]
pw = [];
while i <= diff(interval/(2*T))
    is(t) = piecewise(i*T<=t<(alpha*T)+(i*T),((U/R)+(i0-U/R)*exp(-R*(t-T*i)/L)),(alpha*T)+(i*T)<=t<=T+(i*T),(ia*exp((-R/L)*((t-T*i)-alpha*T))));
    i = i + 1;
    pw = [pw is];
end 

syms is2(t) a(t) b(t) ;
is2(t) = piecewise(0<=t<alpha*T2,(U/R)+(i02-U/R)*exp(-R*t/L),alpha*T2<=t<=T2,ia2*exp((-R/L)*(t-alpha*T2)));
interval = [-5*T2 5*T2];
pw2 = is2;
for i = 1:diff(interval/T2)
   a(t) = piecewise(i*T2<=t<alpha*T2+(i*T2),(U/R)+(i02-U/R)*exp(-R*(t-T2*i)/L),alpha*T2+(i*T2)<=t<=T2+(i*T2),ia2*exp((-R/L)*((t-T2*i)-alpha*T2)));
   b(t) = piecewise(i*-T2<=t<alpha*T2+(i*-T2),(U/R)+(i02-U/R)*exp(-R*(t+T2*i)/L),alpha*T2+(i*-T2)<=t<=T2+(i*-T2),ia2*exp((-R/L)*((t+T2*i)-alpha*T2))); 
pw2 = [pw2 a b];
end

figure(1)
fp1=fplot(pw,interval,'b'),grid on,hold all
fp2=fplot(pw2,interval,'r'),grid on
legend([fp1;fp2],'f=1kHz','f=5kHz');




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