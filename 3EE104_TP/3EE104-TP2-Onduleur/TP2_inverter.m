clear all  clf;

%% Chronogramme de Vs 
d = pi/4;
E = 24;
x=-2*pi:0.01:2*pi;
y=0*(x>=-2*pi&x<-2*pi+d)+E*(x>=-2*pi+d&x<-pi)+0*(x>=-pi&x<-pi+d)...
-E*(x>=-pi+d&x<0)+0*(x>=0&x<d)+E*(x>=d&x<pi)...
+0*(x>=pi&x<pi+d)-E*(x>=pi+d&x<2*pi);
figure(1)
plot(x,y,'r','linewidth',2),grid on 
xlim([-2*pi 2*pi])
ylim([-E*1.5 E*1.5])

xL = xlim;
yL = ylim;
line([0 0], yL);  %x-axis
line(xL, [0 0]);  %y-axis

title (['Chronogramme de Vs sur l,intervalle ' ...
    '[-2π,2π] pour E=24V et d=45°'],'')
xlabel('θ = 2πft (rad)') 
ylabel('La tension de sortie Vs (V)') 

%% Analyse spectrale: V

d1 = 0; d2 = pi/6; d3 = pi/3; d4 = pi/2; 
for n = 1:10
    if mod(n,2)==0 Vn1(n) = 0;
    else Vn1(n) = (2*sqrt(2)*E./(n*pi)) .* cos(n*d1/2);
    end
end 
for n = 1:10
    if mod(n,2)==0 Vn2(n) = 0;
    else Vn2(n) = (2*sqrt(2)*E./(n*pi)) .* cos(n*d2/2);
    end
end 
for n = 1:10
    if mod(n,2)==0 Vn3(n) = 0;
    else Vn3(n) = (2*sqrt(2)*E./(n*pi)) .* cos(n*d3/2);
    end
end 
for n = 1:10
    if mod(n,2)==0 Vn4(n) = 0;
    else Vn4(n) = (2*sqrt(2)*E./(n*pi)) .* cos(n*d4/2);
    end
end 
 
nt = [100 200 300 400 500 600 700 800 900 1000];
figure(2)
subplot(2,2,1);
b1 = bar(Vn1) % Vn quand d = 0
set(gca,'xticklabel',nt) % changement d'echelle
set(b1,'FaceColor',[0 0.2 1]),grid on % blue
title('Spectre de Vs: d = 0°');
xlabel('Frequence [Hz]'); 
ylabel('Tension [V]');
subplot(2,2,2);
b2 = bar(Vn2) % Vn quand d = pi/6
set(gca,'xticklabel',nt) % changement d'echelle
set(b2,'FaceColor',[1 0.2 0.2]),grid on % red
title('Spectre de Vs: d = 30°');
xlabel('Frequence [Hz]'); 
ylabel('Tension [V]')
subplot(2,2,3);
b3 = bar(Vn3) % Vn quand d = pi/3
set(gca,'xticklabel',nt) % changement d'echelle
set(b3,'FaceColor',[0 0.6 0.3]),grid on % green
title('Spectre de Vs: d = 60°');
xlabel('Frequence [Hz]'); 
ylabel('Tension [V]')
subplot(2,2,4);
b4 = bar(Vn4) % Vn quand d = pi/2
set(gca,'xticklabel',nt) % changement d'echelle
set(b4,'FaceColor',[1 0.5 0]),grid on % orange
title('Spectre de Vs: d = 90°');
xlabel('Frequence [Hz]'); 
ylabel('Tension [V]')

%% Analyse Spectrale: I
R = 12;
L = 0.01;
f = 100;
for n = 1:10
    Zn(n) = sqrt(R^2 + (n*L*2*pi*f).^2);
end
In1 = Vn1 ./ Zn;
In2 = Vn2 ./ Zn;
In3 = Vn3 ./ Zn;
In4 = Vn4 ./ Zn;

figure(3)
subplot(2,2,1);
b1 = bar(In1) % Vn quand d = 0
set(gca,'xticklabel',nt) % changement d'echelle
set(b1,'FaceColor',[0 0.2 1]),grid on % blue
title('Spectre de Is: d = 0°');
xlabel('Frequence [Hz]'); 
ylabel('Courant [A]');
subplot(2,2,2);
b2 = bar(In2) % Vn quand d = pi/6
set(gca,'xticklabel',nt) % changement d'echelle
set(b2,'FaceColor',[1 0.2 0.2]),grid on % red
title('Spectre de Is: d = 30°');
xlabel('Frequence [Hz]'); 
ylabel('Courant [A]')
subplot(2,2,3);
b3 = bar(In3) % Vn quand d = pi/3
set(gca,'xticklabel',nt) % changement d'echelle
set(b3,'FaceColor',[0 0.6 0.3]),grid on % green
title('Spectre de Is: d = 60°');
xlabel('Frequence [Hz]'); 
ylabel('Courant [A]')
subplot(2,2,4);
b4 = bar(In4) % Vn quand d = pi/2
set(gca,'xticklabel',nt) % changement d'echelle
set(b4,'FaceColor',[1 0.5 0]),grid on % orange
title('Spectre de Is: d = 90°');
xlabel('Frequence [Hz]'); 
ylabel('Courant [A]')

