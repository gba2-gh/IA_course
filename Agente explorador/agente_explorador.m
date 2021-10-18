%%Ejercicio para la clase de Inteligencia Artificial 
%%Posgrado en Ciencia e Ingenieria de la Computacion - UNAM 2021
%%Gibran Zazueta Cruz
%%%Agente explorador

format long
clear
clc
close all

total_des = 1000; %Decisines totales por ambiente
total_agentes = 20; %total de Agentes
%punt =zeros(1,total_agentes); %Puntuacion para total de agentes
%Decisiones aleatorias para el total de agentes agentes
%acciones=zeros(total_agentes,244);
acciones= round(0 + (6-0).*rand(total_agentes,244));
%cantidad de mutaciones
mut_amount =5;
% acciones=zeros(20,244);
% acciones = acciones + 4;

for etapa=1:1000
punt =zeros(1,total_agentes); 

%%Para los k agentes
for k=1: total_agentes 
%%Iterar en 10 ambientes distintos    
for v=1:10 
    plane=crearAmbiente();
    
    %%Iniciar Agente en posici�n aleatoria
    a=2;
    b=11;
    agente_x  = round(a + (b-a).*rand());%x
    agente_y = round(a + (b-a).*rand());%y
for d=1: total_des %%1000 decisiones
    %%Genotipo
    %N S E O C
    genotipo = zeros(1,5);
    %N
    genotipo(1) = plane(agente_y - 1, agente_x);
    %plane(agente_y - 1, agente_x) = 33;
    %S
    genotipo(2) = plane(agente_y + 1, agente_x);
    %plane(agente_y+1, agente_x) = 34;
    %E
    genotipo(3) = plane(agente_y, agente_x +1);
    %plane(agente_y, agente_x +1) = 35;
    %0
    genotipo(4) = plane(agente_y, agente_x-1);
    %plane(agente_y, agente_x -1) = 36;
    %C
    genotipo(5) = plane(agente_y, agente_x);
    plane(agente_y, agente_x) = 555;

    %%Fenotipo
    % Ternario a decimal
    dec=0;
    j=4;
    for i=1:5
        dec = dec + (3^(j)) * genotipo(i);
        j=j-1;
    end

    %Decisi�n
    
    
    %%%%IMPRESION
    %fprintf('#############AGENTE %d ##############', k)
    %fprintf('#############ITERACION %d ##############', d)
    %plane

    %agente_x
    %agente_y
    %genotipo
    %dec
    accion = acciones(k,dec+1);
    %punt

    
    
    %%Ejecutar accion
    plane(agente_y, agente_x) = genotipo(5);
    
    %caso aleatorio
    if accion == 6
        p = rand();
        if 0.0 <= p && p < 0.25
            accion = 0;
         elseif 0.25<= p && p < 0.5
             accion = 1;
        elseif 0.5<= p && p< 0.75
            accion = 2;
        elseif 0.75<= p && p <1
            accion = 3;
        end
    end
    
    switch accion
        case 0 %Mover arriba
            if genotipo(1) ~= 2 %%%Distinto de
                agente_y = agente_y-1;
            else
                punt(k) = punt(k) -1;
            end
        case 1 %Mover abajo
            if genotipo(2) ~= 2
                agente_y = agente_y+1;
            else
                punt(k) = punt(k) -1;
            end
        case 2 %Mover derecha
            if genotipo(3) ~= 2
                agente_x = agente_x +1;
             else
                punt(k) = punt(k) -1;
            end
        case 3 %Mover izquierda
            if genotipo(4) ~= 2
                agente_x = agente_x -1;
            else
                punt(k) = punt(k) -1;
            end
        case 4 %Levantar marca
            if genotipo(5) == 1
                punt(k) = punt(k) + 10;
                plane(agente_y, agente_x) = 0;   
            else
                punt(k) = punt(k) -3;
            end
        case 5
            %nada
    end
    %punt
    %plane(agente_y, agente_x) = 3     
end
end
end
%punt;
%%TODO
%%%%SLECCION CON PUNT Y ACCIONES

%Fitness value
%Normalizar cada valor entre 0 y 1
max=10000;
min=-30000;
punt_norm = (punt - min) .* (1/(max-min));

%Normalizar rango 0 a 1
punt_norm2 = punt_norm .* (1/sum(punt_norm));

punt_norm2Sum = movsum(punt_norm2,[20 0]);

%%TODO aleatorio comparar con punt_norm2Sum
for k=1:size(punt,2)
    p = rand();
    %%Seleccionar el intervalo del n�mero aleatorio
    temp=[0 punt_norm2Sum];
    i=1;
    j=size(temp, 2);
    m= ceil(j/2);
    while size(temp,2) >2
        if p > temp(1,m)
            i=m;
            j=size(temp, 2);
        else 
            i=1;
            j=m;
        end
        temp = temp(1,[i:j]);
        j=size(temp, 2);
        m=ceil(j/2);
    end
    %%%Indice del elemento seleccionado
    idx(k)=find(punt_norm2Sum==temp(1,2));
    acciones_new(k,:)= acciones(idx(k),:)  ;
end
idx;
%% Cruzamiento
%1 punto


for k=1:size(acciones_new,1)-1
    a=1;
    b=243;
    cross_point= round(a + (b-a).*rand());%x

    padre1= acciones_new(k,:);
    padre2= acciones_new(k+1,:);

    hijo1 = padre1(1,[1:cross_point-1]) ;
    hijo1 = cat(2, hijo1, padre2(1,[cross_point:end]));    
    hijo2 = padre2(1,[1:cross_point-1]) ;
    hijo2 = cat(2, hijo2, padre1(1,[cross_point:end]));
    
    %%%Mutacion
    mut_points1= round(a + (b-a).*rand(1,mut_amount));%
    mut_points2= round(a + (b-a).*rand(1,mut_amount));
    for i=1:size(mut_points1,2)
        alelo_new=round(0 + (6-0).*rand());
        hijo1(mut_points1(1,i))= alelo_new;
        alelo_new=round(0 + (6-0).*rand());
        hijo2(mut_points2(1,i))= alelo_new;
    end
    
    hijos(k,:) = hijo1;
    hijos(k+1,:) =hijo2;
end
    
acciones = hijos;
end
