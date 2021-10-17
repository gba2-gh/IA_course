
%%Ejercicio para la clase de Inteligencia Artificial
%%Gibran Zazueta Cruz
%%AND - ENTRENAMIENTO DE PERCEPTRÓN

clc

p = [0 0 1 1;0 1 0 1]; %%vector de entradas
t=[0, 0, 0, 1]; %%target

e= 1;
wn = [0 0];
bn= 0.1;

epocas=10;

for i=0:epocas
    for j=1:size(p',1)
        
        n= wn*p(:,j)+bn;
        a=hardlim(n)
        e=t(j)-a;
        wo=wn; bo=bn;
        wn=wo + e*p(:,j)';
        bn= bo +e;
       
    end
end

test=[1 1];
output=hardlim(wn*test' +bn)






