clear all
clc 
close all 


delay=1;

pez= zeros(1,100);
pez(1,1)=1;

m=1;
b=0;

%Test
% x = 0:.01:100;
% y = x*m+b;
% figure
% plot(x,y)
% axis([0 100 0 100])



distMin=10
ciclo=0;
cicloMax=5;
px = 0;
py = 0;
px2=0; py2=0;
t=0;
x=0
y=0
m=0
b=0
cambioDir=zeros(1,10000)

% m(1)=-3;  
% b(1)=70;
% m(2:end)= 0.4;
% b(2:end)= random(0,20,5);

[x y m b] = spawnFish(5, x, y, m, b);
[x y m b] = spawnFish(1, x, y, m, b);
[x y m b] = spawnFish(3, x, y, m, b);
[x y m b] = spawnFish(1, x, y, m, b);
[x y m b] = spawnFish(4, x, y, m, b);

for i=1:size(m,2)
    cambioDir(i)= m(i)+ random(-2,2,1);
end
    
for i=1:1000 
    f=figure(100); %This is so it will replot over the previous figure, and not make a new one.
    
    plot(x,y, 'o');
    axis([0 100 0 100])
    pause(0.1);
    
    x = x+0.5;
    t=t+0.5;
   

    
    for k=1:size(y,2)
        y(k)= x(k)*m(k) + b(k);
        
        %%Cambio de dirección
        e= abs(abs(cambioDir(k)) - abs(m(k)));
        if e > 0.1
            if m(k) > cambioDir(k)
                m(k)=m(k)- e*0.1;
            else
                m(k)=m(k) + e*0.1;
            end
        end
        
    end
    
    
        %distancia entre puntos
   
    for k=1:size(y,2)
        mT=0;
        acc=0;
        for j=1:size(y,2)
            dist= sqrt((x(k)-x(j))^2 + (y(k)-y(j))^2);
            
            if dist < distMin
                mT= mT + m(j);
                acc=acc+1     ;      
            end
        end
        cambioDir(k) = mT/acc;
    end
    
    
    ciclo=ciclo+1;
    %Nueva dir cada ciclo
    if ciclo>= cicloMax
        for j=1:size(m,2)
            cambioDir(j)= m(j)+ random(-1,1,1);
        end
        ciclo=0
        %%%Nuevos peces
        cant= ceil(random(1,2,1));
        [x y m b] = spawnFish(cant, x, y, m, b);

        cant= ceil(random(3,8,1));
        [x y m b] = spawnFish(cant, x, y, m, b);
    end
   
     
end


for i=1:100
    
    pez(1,i)=pez(1,i) + i*2;
    
    %plot(x,y)
    imagesc(pez)
    pause(delay)
end