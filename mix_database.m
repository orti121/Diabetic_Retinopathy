function mix=mix_database(database)
%Entrega la base de datos con sus filas reordenadas aleatoriamente.
random_list=randperm(length(database(:,1))); %Lista con valores de 1 a la cantidad de muestras, ordenadas aleatoriamente.
revuelta=zeros(size(database)); %Inicialización de la matriz de llegada.
for i=1:1:length(random_list)
    indice=random_list(i); %Fila de la base original que será guardada en el lugar i.
    revuelta(i,:)=database(indice,:);
end
mix=revuelta;