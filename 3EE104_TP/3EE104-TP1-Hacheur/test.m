clear all;clf;


U = 30;
R = 10;
L = 8*10^-3;
T1 = 1*10^-3;
T2 = 0.3*10^-3;
alpha = 0.7;
i0 = @(T)(U/R)*(exp((R/L)*alpha*T)-1)/(exp(R*T/L)-1)
ia = @(T) (U/R)+(i0(T)-U/R)*exp(-R*alpha*T/L)

i01 = i0(T1);
i02 = i0(T2);
ia1 = ia(T1);
ia2 = ia(T2);


t = linspace(-T1,T1,1000);
%%k = 0:1:999;
is = zeros(size(t));
%%is = @(T,i0,ia,t) ((U/R)+(i0-U/R)*exp(-R*t/L)).*(t>=0 & t<alpha*T) + (ia*exp((-R/L)*(t-alpha*T))).*(t>=alpha*T & t<=T) + ((U/R)+(i0-U/R)*exp(-R*(t+T)/L)).*(t>=-T & t<(-T+alpha*T)) + (ia*exp((-R/L)*(t+T-alpha*T))).*(t>=(-T+alpha*T) & t<0)
%%is = @(T,i0,ia) ((U/R)+(i0-U/R)*exp(-R*t/L)).*(t>=k.*T & t<k.*T+alpha*T) + (ia*exp((-R/L)*(t))).*(t>=alpha*T & t<=T) + ((U/R)+(i0-U/R)*exp(-R*(t)/L)).*(t>=-k.*T & t<(-k.*T+alpha*T)) + (ia*exp((-R/L)*(t))).*(t>=(-k.*T+alpha*T) & t<-k.*T)

is1 = is(T1,i01,ia1,t);
is2 = is(T2,i02,ia2,t);

plot(t,is1,'b'),grid on,hold on;
plot(t,is2,'r');
legend("alpha = 0.7");
title("Chronogramme de is");
ylabel("Courant[A]");
xlabel("Temps[s]");
%%ylim([0.5 3])
