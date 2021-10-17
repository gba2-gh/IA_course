%%Ejercicio para la clase de Inteligencia Artificial 
%%Posgrado en Ciencia e Ingenieria de la Computacion - UNAM 2021
%%Gibran Zazueta Cruz
%%%Backpropagation  IRIS
format long
clear
clc
close all

[p,t,vali] = GetIrisData(0.7, 0, 1); %%%porcentaje de datos para entrenamiento // rango de normalización [a,b] //

R= size(p,1) ;%%numero de entradas = filas de p
S= size(t,2) ;%%numero de salidas = columnas de t
neuron_hl=3  ;%%Cantidad de neuronas en capa oculta

%%Crear matriz de pesos y bias
%Pesos 1ra capa
for i=1:neuron_hl
    for j=1:R
        w1(i,j)=0.1;
    end
    b1(i,1)=0.1;
end

%Peso segunda capa,
for i=1:neuron_hl
    for j=1:neuron_hl
        w2(i,j)=0.1;
    end
    b2(i,1)=0.1;
end

%Peso tercera capa
for i=1:S
    for j=1:neuron_hl
        w3(i,j)=0.1;
    end
    b3(i,1)=0.1;
end


alfa=0.01;
e= 1;
epocas=2000;
ecm=zeros(1,epocas);


for k=1:epocas
    for i=1:size(p,2) 
        a1=sigmoid(w1 * p(:,i) + b1);   %%%FUNCION 1RA CAPA 
        a2=sigmoid(w2 * a1 + b2);   %%%FUNCION 1RA CAPA 
        a3=purelin(w3 * a2 + b3);       %%%FUNCION 2DA CAPA
        %%error
        e = t(i,:)'-a3;
        

        %%%Derivada rapida
        for n=1:neuron_hl
            vec1(n) = [(1-a1(n))*(a1(n))];
        end
        for n=1:neuron_hl
            vec2(n) = [(1-a2(n))*(a2(n))];
        end
        jac1= diag(vec1);
        jac2=diag(vec2);
        s3= -2*(1)*(e);%%capa de salida
        s2 = jac2 * w3'*s3;
        s1 = jac1 * w2'*s2;
        
        %%nuevos pesos
        w2o=w2; w1o=w1; b2o=b2; b1o=b1; w3o=w3; b3o=b3;
        w3= w3o - alfa*s3*a2';
        b3 =b3o - alfa*s3;
        
        w2 = w2o - alfa*s2*a1';
        b2 = b2o - alfa*s2;
        w1 = w1o - alfa*s1*p(:,i)';
        b1 = b1o - alfa*s1;
        a(i,:)=a3';
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
w3
%
% %%Prueba

for i=1:size(vali,1)
    test=vali(i,[1:4]);
    a_out1(i,:)=sigmoid(w1*test' +b1)';
    a_out2(i,:)=sigmoid(w2*a_out1(i,:)' +b2)';
    output(:,i)=purelin(w3*a_out2(i,:)' +b3)';
end

output'
compet(output)'

