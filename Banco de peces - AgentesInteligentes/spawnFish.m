function [x y m b cDir]=spawnFish(n, x, y, m, b, cDir);

xn= zeros(1,n);
yn= zeros(1,n);
mn= zeros(1,n) + random(-3,3,1);
a=random(0,100,1);
bn= random(a-10,a+10,n);
cDirn= zeros(1,n);

x= [x xn];
y= [y yn];
m= [m mn];
b= [b bn];
cDir = [cDir cDirn];
end