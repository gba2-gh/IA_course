function [p,t,vali] = GetIrisData(per, a, b);

M= IrisDataSet('IrisDataSet.csv');

%Normalizar
%Obtener maximos de cada columna
maximos = max(M,[],1);
minimos = min(M,[],1);
%a= 0;
%b=1;
for i=1:size(M,2)
    for j=1:size(M,1)
    M_norm(j,i) = a + ((( M(j,i) - minimos(i))*(b-a)) / (maximos(i) - minimos(i))) ;  
    end
end

%%TOMAR 10 DATOS DE CADA TIPO PARA PRUEBAS
%Validacion

%%TODO: METER EN UN CICLO

%per = 0.70 ;

idx = 1:50;%randperm(50)  ; %%Permutacion aleatoria de todas las filas
train1 = M_norm(idx(1:round(per*50)),:);  %De la fila 1 a la P*m        
test1 = M_norm(idx(round(per*50)+1:50),:);  %De la fila p*m +1 hasta el final

idx = 51:100;
train2 = M_norm(idx(1:round(per*50)),:);         
test2 = M_norm(idx(round(per*50)+1:50),:);

idx = 101:150;
train3 = M_norm(idx(1:round(per*50)),:);     
test3 = M_norm(idx(round(per*50)+1:50),:);
%%%%%%%%%%%


vali=[test1;test2;test3]; %%%SALIDA
p2=[train1;train2;train3];


%%tomar t

for i=1:size(p2,1)
    p(i,:)= p2(i,[1:4]);
    t(i,:) = p2(i,[5:7]);

end

p=p';




end