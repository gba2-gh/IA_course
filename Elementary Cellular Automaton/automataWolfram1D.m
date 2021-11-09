clear all
clc 
close all

%tamaño cel automata celular
caSize=31;
%Total de evoluciones para cada regla
evoTotal=15;

reglas=[30 54 60 62 90 94 102 110 122 126 150 158 182 188 190 220 222 250];

%Iterar sobre todas las reglas propuestas
%for z=1:size(reglas,2)
for z=0:100
    %Iniciar agente con solo un 1
    agente= zeros(evoTotal,caSize);
    agente(1,ceil(caSize/2))=1;
    
    %Nueva regla a binario
    ruled=z;
    rule =dec2bin(ruled);
    
    %%%Iniciar Grid en blanco
    [sy, sx] = size(agente);
    for i=1:sy
        for j=1:sx
            rectangle('Position', [j,evoTotal-i, 1, 1], 'facecolor', 'white' );
        end
    end
    title(['Regla: ', num2str(ruled)])
    axis off;
    
    %Iterar para el total de evoluciones con la nueva regla
    for evo=1:evoTotal-1
        
    %Código para el agente actual
    code=zeros(1,caSize);
    code(1,1)=((2^(2)) * agente(evo,end)) + ((2^(1)) * agente(evo,1)) + agente(evo,2);
    code(1,end)=((2^(2)) * agente(evo,end-1)) + ((2^(1)) * agente(evo,end)) + agente(evo,1);
    for k=2:caSize-1
        % bin a decimal
        dec=0;
        j=2;
        for i=k-1:k+1
            dec = dec + (2^(j)) * agente(evo,i);
            j=j-1;
        end
        code(1,k)=dec;
    end

    %%comparar codigo con regla
    dec=0;
    for i=1:caSize
        for k=size(rule,2):-1:1
            if str2double(rule(k)) ==1
                if code(1,i) == size(rule,2)-k
                    agente(evo+1,i)=1;
                    break
                end
            end
        end
    end
    end

    %%Dibujar resultado
    for i=1:sy
        for j=1:sx
            if agente(i,j) ==1
                rectangle('Position', [j,evoTotal-i, 1, 1], 'facecolor', 'black');
                pause(0.001)
            end

        end
    end
    pause(0.3)

end

