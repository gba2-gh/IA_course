caSize=31;
evoTotal=15;



for z=1:1:30
    agente= zeros(evoTotal,caSize);
    agente(1,ceil(caSize/2))=1
    ruled=59+z;
    rule =dec2bin(ruled);
    
    %%%Grid
    [sy, sx] = size(agente);
   
    for i=1:sy
        for j=1:sx
            rectangle('Position', [j,evoTotal-i, 1, 1], 'facecolor', 'white' );
        end
    end
    title(['Regla: ', num2str(ruled)])
for evo=1:evoTotal-1
%Código del agente actual
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

%%comparar codigo con rule
dec=0;
for i=1:caSize
    if code(1,i) > 0
        for k=size(rule,2):-1:1   
            %ruleDec= str2double(rule(k)) * 2^(size(rule,2)-k) 
            if str2double(rule(k)) ==1
                if code(1,i) == size(rule,2)-k
                    agente(evo+1,i)=1
                    break
                end
            end
        end
    end
end
end

%%Dibujar
for i=1:sy
    for j=1:sx
        if agente(i,j) ==1
            rectangle('Position', [j,evoTotal-i, 1, 1], 'facecolor', 'black');
            pause(0.1)
        end

    end
end
pause(1)
%clf reset
pause(1)

end

