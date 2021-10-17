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
punt =zeros(1,total_agentes); %Puntuacion para total de agentes
%Decisiones aleatorias para el total de agentes agentes
%acciones=zeros(total_agentes,244);
acciones= round(0 + (6-0).*rand(total_agentes,244));

%%Para los k agentes
for k=1: total_agentes 
%%Iterar en 10 ambientes distintos    
for v=0:10 
    plane=crearAmbiente();
    %%Iniciar Agente en posición aleatoria
    a=2;
    b=11;
    agente_x  = round(a + (b-a).*rand());%x
    agente_y = round(a + (b-a).*rand());%y
for d=0: total_des %%1000 decisiones
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

    %Decisión
    
    
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
                plane(agente_x, agente_y) = 0;   
            else
                punt(k) = punt(k) -3;
            end
        case 5
            %nada
    end
    punt
    %plane(agente_y, agente_x) = 3     
end
end
end

%%TODO
%%%%SLECCION CON PUNT Y ACCIONES

