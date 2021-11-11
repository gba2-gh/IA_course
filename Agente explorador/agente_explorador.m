%%Ejercicio para la clase de Inteligencia Artificial 
%%Posgrado en Ciencia e Ingenieria de la Computacion - UNAM 2021
%%Gibran Zazueta Cruz
%%%Agente explorador

format long
clear
clc
close all

%ambiente
total_marcas=5;
print_plane=false;

%Iteraciones
total_etapas = 500; %%Total de generaciones
total_des = 1000; %Decisines totales por ambiente
total_ambientes= 10; %Ambientes aleatorios a explorar
total_agentes = 20; %total de Agentes

%cantidad de mutacion
mut_per=0.04;
mut_amount = floor(mut_per * 243);

%Puntuación
score_marcaT= 10;
score_marcaF= -3;
score_salir = -1;
scores=[score_marcaT score_marcaF score_salir];
%NORM
%maxV=500;
maxV= total_marcas * score_marcaT ;
minV= min(score_marcaF * total_des, score_salir * total_des) ;


punt_best=0;
accion_best=zeros(1,243);
%Decisiones aleatorias para el total de agentes
acciones= round(0 + (6-0).*rand(total_agentes,243));
%acciones=zeros(total_agentes,243);
% acciones = acciones + 4;


for etapa=1:total_etapas
punt =zeros(1,total_agentes); 

%%Para los k agentes
for k=1: total_agentes 
%%Iterar en 10 ambientes distintos    
for v=1:total_ambientes
    %%%Crear nurvo ambiente
    plane=crearAmbiente(total_marcas);
    
    %%Iniciar Agente en posición aleatoria
    a=2;
    b=11;
    agente_x  = round(a + (b-a).*rand());%x
    agente_y = round(a + (b-a).*rand());%y
    
    for d=1: total_des %%1000 decisiones
        %%Genotipo
        %%%El genotipo se forma con los valores de las casillas vecinas
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
        plane(agente_y, agente_x) = 3; %%valor para ver donde está parado
        
        
        %%Fenotipo
        % Ternario a decimal
        dec=0;
        j=4;
        for i=1:5
            dec = dec + (3^(j)) * genotipo(i);
            j=j-1;
        end

        %Se decide la acción con el código obtenido
        accion = acciones(k,dec+1);
        
        if d<50
            delay=0;
        else
            delay=0;
        end
        
        imagesc(plane); caxis([0 3]);
        colormap default; 
        axis off; axis equal; drawnow
        title(sprintf(['Agente explorador']))
        text(3,0.9,sprintf(['Agente actual=',num2str(k), ', Iteracion=',num2str(d),', Ambiente=',num2str(v),'\n            Score=',...
            num2str(punt(k)), ' Sig accion=',num2str(accion)]),'FontSize',13)
        pause(delay)
        
        %%%Mostrar matriz
        if print_plane == true
            %%%%IMPRESION
            fprintf('#############AGENTE %d ##############', k)
            fprintf('#############ITERACION %d ##############', d)
            plane
            %agente_x
            %agente_y
            %genotipo
            %dec
            accion
            punt
        end
        plane(agente_y, agente_x) = genotipo(5);


        

        %%Ejecutar accion
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
                if genotipo(1) ~= 2 %%%Distinto de 2
                    agente_y = agente_y-1;
                else%%intenta salir
                    punt(k) = punt(k) + score_salir;
                end
            case 1 %Mover abajo
                if genotipo(2) ~= 2
                    agente_y = agente_y+1;
                else
                    punt(k) = punt(k) + score_salir;
                end
            case 2 %Mover derecha
                if genotipo(3) ~= 2
                    agente_x = agente_x +1;
                 else
                    punt(k) = punt(k) + score_salir;
                end
            case 3 %Mover izquierda
                if genotipo(4) ~= 2
                    agente_x = agente_x -1;
                else
                    punt(k) = punt(k) + score_salir;
                end
            case 4 %Levantar marca
                if genotipo(5) == 1
                    punt(k) = punt(k) + score_marcaT;
                    plane(agente_y, agente_x) = 0;   
                else
                    punt(k) = punt(k) + score_marcaF;
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

%%%%SELECCION 
%Fitness value
%Normalizar cada valor entre 0 y 1
punt_prom = punt .* (1/total_ambientes);


if max(punt_prom) >= punt_best
    punt_best=max(punt_prom);
    idMax=find(punt_prom==punt_best);
    accion_best(1,:)=acciones(idMax(1),:);
end

%%%Normalizar entre 0-1 cada valor
punt_norm =(punt - minV*10) .* (1/(maxV*10-minV*10));
punt_normP = (punt_prom -minV) .* (1/(maxV-minV));

%Normalizar rango 0 a 1
punt_norm2 = punt_norm .* (1/sum(punt_norm));
punt_norm2P = punt_normP .* (1/sum(punt_normP));

punt_norm2Sum2 = movsum(punt_norm2,[total_agentes 0]); %%%TODO
punt_norm2Sum = movsum(punt_norm2P,[total_agentes 0]);  %%%Cambio

%%%Ruleta. Elegir elementos
for k=1:size(punt,2)
    p = rand();
    %%Seleccionar el intervalo del número aleatorio
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
    id= find(punt_norm2Sum==temp(1,2));
    idx(k)=id(1);
    acciones_new(k,:)= acciones(idx(k),:)  ;
end
idx;

%% Cruzamiento
%1 punto
k=1;
temp=acciones_new;
while size(temp,1) > 0
%for k=1:size(acciones_new,1)-1

    %Seleccionar padres al azar
    padre_idx=round(1 + (size(temp,1)-1).*rand());
    padre1= temp(padre_idx,:);
    temp(padre_idx,:) = [];
    
    padre_idx=round(1 + (size(temp,1)-1).*rand());
    padre2= temp(padre_idx,:);      
    temp(padre_idx,:) = [];
    
    
    cross_point= round(1 + (243-1).*rand());%x
    
    hijo1 = padre1(1,[1:cross_point-1]) ;
    hijo1 = cat(2, hijo1, padre2(1,[cross_point:end]));    
    hijo2 = padre2(1,[1:cross_point-1]) ;
    hijo2 = cat(2, hijo2, padre1(1,[cross_point:end]));
    
  
    %%%Mutacion
    mut_points1= round(1 + (243-1).*rand(1,mut_amount));%
    mut_points2= round(1 + (243-1).*rand(1,mut_amount));
    for i=1:size(mut_points1,2)
        alelo_new=round(0 + (6-0).*rand());
        hijo1(mut_points1(1,i))= alelo_new;
        alelo_new=round(0 + (6-0).*rand());
        hijo2(mut_points2(1,i))= alelo_new;
    end
    

    %temp = temp([1:padre_idx(2)-1, padre_idx(2)+1:end])
    
    hijos(k,:) = hijo1;
    hijos(k+1,:) =hijo2;
    k=k+2;
end
 
acciones = hijos;
punt_max(etapa)= max(punt);
punt_maxP(etapa)= max(punt_prom);
end
punt

% figure
% plot(punt_max)
% grid on
% title('punt max' )

figure
plot(punt_maxP)
grid on
%title(['Punt Max (', num2str(punt_best),')'])
title(sprintf(['Punt max (',num2str(punt_best), ')\n(Ambientes=', num2str(total_ambientes),'),  (desiciones= ',...
    num2str(total_des),'), (Agentes= ', num2str(total_agentes), '), (Score[mT, mF, S] = [',...
    num2str(scores),']), (Mutation percent= ',num2str(mut_per),'), (Marcas= ', num2str(total_marcas),')']))


return;



%% Evaluate

acciones = [5,4,2,1,5,1,2,3,3,5,4,6,5,2,3,4,2,3,3,6,2,5,3,5,5,3,2,6,0,3,1,4,3,2,0,0,1,6,1,2,2,3,3,0,3,6,1,1,3,6,3,6,5,3,2,5,4,1,4,3,2,3,2,5,4,6,5,2,1,3,2,3,0,5,1,2,6,6,6,3,2,5,4,4,2,2,5,0,1,5,3,4,6,3,5,2,1,0,5,5,3,0,0,3,5,1,1,2,0,2,3,5,5,1,4,2,4,1,2,3,2,6,5,2,4,0,1,4,5,4,4,1,4,3,3,2,6,3,1,3,1,3,4,1,5,2,4,4,3,3,6,5,2,0,4,1,3,1,1,2,2,4,6,2,2,2,3,2,4,6,5,1,4,3,2,5,5,2,5,2,1,1,4,2,3,5,5,2,2,6,5,4,5,5,1,5,0,5,5,1,6,6,5,0,2,3,3,2,5,4,0,3,2,3,2,5,1,6,4,2,2,2,2,4,4,4,1,0,1,1,4,4,6,2,2,3,5,3,0,3,2,4,6,1];
total_des = 1000; 
punt =0;

for v=1:10 
    plane=crearAmbiente();
    
    %%Iniciar Agente en posición aleatoria
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

    %Decisión
    
    
    %%%%IMPRESION
    %fprintf('#############AGENTE %d ##############', k)
    %fprintf('#############ITERACION %d ##############', d)
    plane

    %agente_x
    %agente_y
    genotipo
    %dec
    accion = acciones(1,dec+1)
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
                punt = punt -1;
            end
        case 1 %Mover abajo
            if genotipo(2) ~= 2
                agente_y = agente_y+1;
            else
                punt = punt -1;
            end
        case 2 %Mover derecha
            if genotipo(3) ~= 2
                agente_x = agente_x +1;
             else
                punt = punt -1;
            end
        case 3 %Mover izquierda
            if genotipo(4) ~= 2
                agente_x = agente_x -1;
            else
                punt = punt -1;
            end
        case 4 %Levantar marca
            if genotipo(5) == 1
                punt = punt + 10;
                plane(agente_y, agente_x) = 0;   
            else
                punt = punt -3;
            end
        case 5
            %nada
    end
    punt
    %plane(agente_y, agente_x) = 3     
end
end
fprintf('fin')

