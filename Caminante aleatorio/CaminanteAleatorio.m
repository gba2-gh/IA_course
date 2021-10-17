%%Ejercicio para la clase de Inteligencia Artificial 
%%Posgrado en Ciencia e Ingenieria de la Computacion - UNAM 2021
%%Gibran Zazueta Cruz
%%%Caminante aleatorio

format long
clear
clc
close all

%Definir plano de 10x10
plane = zeros(10);
plane(5,5) = 1;
%Inicio en el centro
x0=5; y0=5;
x=5; y=5;
d=zeros(2,10);

%R=Pruebas a promediar, n_max= Numero de desiciones
R=500;
n_max=100;

for i=1:n_max
    aux=0;
    dist=0;
    for j = 1:R
        x=x0;
        y=y0;
        for k=1:i*10
            %plane(y,x)=0;
            %plane(y0,x0)=1;
            p = rand();
            if 0.0 <= p && p < 0.25
                y = y+1;
            elseif 0.25<= p && p < 0.5
                x = x+1 ;
            elseif 0.5<= p && p< 0.75
                y=y-1;
            elseif 0.75<= p && p <1
                x=x-1;
            end
            if x>10
                x=10;
            end
            if x <1
                x=1;
            end
            if y>10
                y=10;
            end
            if y<1
                y=1;
            end
            %plane(y,x) = 1
        end
     dist = abs(y0-y) + abs(x0-x);
     aux= aux+dist  ;
     %plane(y,x)=0;
    end
    aux= aux/R;
    d(1,i)= i*10;
    d(2,i)=aux;
end

%plot
figure
plot(d(1,:),d(2,:))
grid on
title(['Caminante aleatorio (R=)' R] )
xlabel('Número de desiciones (N)')
ylabel('Distancia promedio al origen')