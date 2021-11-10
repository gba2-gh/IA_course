%%Ejercicio para la clase de Inteligencia Artificial 
%%Posgrado en Ciencia e Ingenieria de la Computacion - UNAM 2021
%%Gibran Zazueta Cruz
%%%Tare Agentes inteligentes - Simulación Banco de peces

% %%Explicación del ejercicio
% Se construye una simulación de un banco de peces.
% Cada pez representa un agente inteligente que sigue las siguientes reglas:

% 1. Nadar derecho
% 2. Cambiar dirección ligeramente
% 3. Moverse en una dirección promedio de la vecindad de peces

%%
%%Declaración variables
clear all
clc 
close all 

%Dimension cuadro
dim=100;
%delay entre iteraciones
delay=0.08;
%distacia minima para considerar a un pez parte de un grupo
distMin=10;
%frecuencia con que los peces toman direccion aleatoria
ciclo=0;
cicloMax=10;
%%% Frecuencia con que aparecen nuevos peces
groupSpawnRate=15;
singleSpawnRate=6;

%%
x=0;
y=0;
m=0;
b=0;
cDir=0;

%Primeros peces
[x y m b cDir] = spawnFish(5, x, y, m, b, cDir);
[x y m b cDir] = spawnFish(1, x, y, m, b, cDir);
[x y m b cDir] = spawnFish(2, x, y, m, b, cDir);

%%%Hacer a los peces cambiar ligeramente de dirección
for i=1:size(cDir,2)
    cDir(i)= m(i)+ random(-2,2,1);
end

%% Simulación   
i=0;
while(1)
    i=i+1;
    %%%Grafico
    f=figure(100);     
    plot(x,y, 'o','MarkerSize',8,'MarkerEdgeColor','red', 'MarkerFaceColor','y');
    axis([0 dim 0 dim])
    set(gca,'Color',[0, 0.4470, 0.7410])
    title('Simulación Banco de peces')
    pause(delay);
    
    
    %Calcular nueva posicion
    x = x+0.5;
    for k=1:size(y,2)
        y(k)= x(k)*m(k) + b(k);
        
        %%Cambio de dirección
        e= abs(abs(cDir(k)) - abs(m(k)));
        if e > 0.1
            if m(k) > cDir(k)
                m(k)=m(k)- e*0.1;
            else
                m(k)=m(k) + e*0.1;
            end
        end
              
    end
       
    %Dirección promedio para puntos cercanos
    for k=1:size(y,2)
        mT=0;
        acc=0;
        for j=1:size(y,2)
            dist= sqrt((x(k)-x(j))^2 + (y(k)-y(j))^2); %%Distancia entre puntos
            
            if dist < distMin
                mT= mT + m(j);
                acc=acc+1     ;      
            end
        end
        cDir(k) = mT/acc;
             
    end
    
    
    ciclo=ciclo+1;
    %Cada ciclo se cambia ligeramente de dirección
    if ciclo>= cicloMax
        for j=1:size(m,2)
            cDir(j)= m(j)+ random(-1,1,1);
        end
        ciclo=0;
    end
    
        
    %%Eliminar peces fuera del rango de vision
    idx=0;
    for k=1:size(x,2)
       if x(k)>dim+10 || y(k)>dim+10 || y(k)<-10
           idx=[idx k];
       end
    end
    idx(1)=[];
    if size(idx) >0
       x(:,idx)=[];
       y(:,idx)=[];
       m(:,idx)=[];
       b(:,idx)=[];
       cDir(:,idx)=[];
    end
    
    %%%Nuevos peces
    if mod(i,groupSpawnRate) ==0              
        cant= ceil(random(3,8,1));
        [x y m b,cDir] = spawnFish(cant, x, y, m, b, cDir);
    end
    if mod(i, singleSpawnRate) == 0
        cant= ceil(random(1,2,1));
        [x y m b, cDir] = spawnFish(cant, x, y, m, b, cDir);
    end
    
     
end

