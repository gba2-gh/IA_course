%%Ejercicio para la clase de Inteligencia Artificial
%%Gibran Zazueta Cruz
%%%BACKPROPAGATION. SEGUIMIENTO DE FUNCION SENO
format long
clear
clc
close all


%Intervalo den entrada
p = -6:0.1:6;
%%Vector de entrada y target
for i=1:length(p)
    t(i) = 1+sin((pi/4) * p(i));
end

%Graficar entrada
figure
plot(p,t); title('Entrada');

%Pesos 1ra capa, 3 neuronas, 1 entrada
w1 =[-0.27; -0.41; 0.1];
b1 = [-.48 ;-0.13; 0.1];

%Peso segunda capa, 1 neurona de 3 entradas
w2 = [0.09 -0.17 0.1];
b2 = 0.48;

%%%Funciones y derivadas
syms ft1(x) ft2(y);
ft1(x) = sigmoid(x); 
ft1p = diff(ft1,x);
% der2 = derivada(w1*p(4)+b1)
ft2(x) = x;
ft2p = diff(ft2,x);


alfa=0.01;
e= 1;
epocas=5000;
ecm=zeros(1,epocas);


for k=1:epocas
    for i=1:size(p,2) 
        a1=sigmoid(w1 * p(i) + b1);   %%%FUNCION 1RA CAPA 
        a2=purelin(w2 * a1 + b2);       %%%FUNCION 2DA CAPA
        %%error
        e = t(i)-a2;
        
       %%%Derivada General
     %%sensibilidad en la salida
%         jac2 = diag(double(ft2p(w2*a1 +b2)));
%         s2= -2*jac2*(e);
%     %%sensibilidad en capa
%         jac1 = diag(double(ft1p(w1*p(i)+b1)));
%         s1 = jac1 * w2'*s2;

        %%%Derivada rapida
        jac1= diag([(1-a1(1))*(a1(1)), (1-a1(2))*(a1(2)), (1-a1(3))*(a1(3))]);
        %jac1 = diag(double(ft1p(w1*p(i)+b1)));
        s2= -2*(1)*(e);
        s1 = jac1 * w2'*s2;
        
        %%nuevos pesos
        w2o=w2; w1o=w1; b2o=b2; b1o=b1;
        w2 = w2o - alfa*s2*a1';
        b2 = b2o - alfa*s2;
        w1 = w1o - alfa*s1*p(i)';
        b1 = b1o - alfa*s1;
        a(i)=a2;
    end
    %ecm
    for i=1:size(p,2) 
        ecm(k)= ecm(k) + (t(i)-a(i))^2;
    end
    ecm(k) = ecm(k)/size(p,2) ;
    ep(k) = k;
end
figure
plot(ep,ecm); title('Error RMS');


w1
w2
% 
% %%Prueba

for i=1:size(p,2)
    test=p(i);
    a_out(i,:)=sigmoid(w1*test' +b1)';
    output(:,i)=purelin(w2*a_out(i,:)' +b2)';
end

figure
plot(p,output);title('Validacion');


