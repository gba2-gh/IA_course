function [x y m b]=spawnFish(n, x, y, m, b);

xn= zeros(1,n);
yn= zeros(1,n);
mn= zeros(1,n) + random(-3,3,1);
bn= zeros(1,n) + random(0,100,1);

x= [x xn]
y= [y yn]
m= [m mn]
b= [b bn]

end