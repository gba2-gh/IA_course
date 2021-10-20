function plane = crearAmbiente(total_marcas);

%Definir plano de 10x10
%0. Vacía
%1. Marcada
%2. Pared
%3. Agente

%%Ambiente
plane = zeros(12);
plane(1,:)=2;
plane(end,:)=2;
plane(:,1)=2;
plane(:,end)=2;

%marcas
%total_marcas=50;
a=2;
b=11;
marcas(1,:)= round(a + (b-a).*rand(1,total_marcas));%x
marcas(2,:)= round(a + (b-a).*rand(1,total_marcas));%y

for i=1:total_marcas
    x=marcas(1,i);
    y=marcas(2,i);
    %Duplicados
    while plane(y,x) == 1
        marcas(1,i)= round(a + (b-a).*rand());%x
        marcas(2,i)= round(a + (b-a).*rand());%y
        x=marcas(1,i);
        y=marcas(2,i);
    end
    plane(y,x)=1;
end

end