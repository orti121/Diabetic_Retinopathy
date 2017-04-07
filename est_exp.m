function [musano,sigmasano,murd,sigmard]=est_exp(entrenamiento)
% Devuelve las estadísticas de la matriz de entrenamiento para no tener que
% estarla calculando cada vez que se quiera clasificar.
bin=0:1;
[cantidades] = histc(entrenamiento(:,17),bin); %Cantidades de cada tipo
sano=zeros(cantidades(1),17); %inicialización de las matrices
rd=zeros(cantidades(2),17);

% Separar en rd y sano
index_sano=1;
index_rd=1;

for i=1:length(entrenamiento(:,17))
    indicador=entrenamiento(i,17);
    fila=entrenamiento(i,:);
    if indicador==0
        sano(index_sano,:)=fila;
        index_sano=index_sano+1;
    else
        rd(index_rd,:)=fila;
        index_rd=index_rd+1;
    end
    sano_no17=sano(:,1:16);
    rd_no17=rd(:,1:16);
    musano=mean(sano_no17);
    sigmasano=cov(sano_no17)+1e-20; %Para evitar ceros en la diagonal
    
    murd=mean(rd_no17);
    sigmard=cov(rd_no17);
end
