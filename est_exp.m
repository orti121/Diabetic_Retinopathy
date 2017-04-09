function [musano,sigmasano,murd,sigmard]=est_exp(entrenamiento)
% Devuelve las estadísticas de la matriz de entrenamiento para no tener que
% estarla calculando cada vez que se quiera clasificar.
index_class=length(entrenamiento(1,:));
last_feat=index_class-1;

cant_muestras=length(entrenamiento(:,index_class));

bin=0:1;
[cantidades] = histc(entrenamiento(:,index_class),bin) %Cantidades de cada tipo
sano_feats=zeros(cantidades(1),last_feat); %inicialización de las matrices
rd_feats=zeros(cantidades(2),last_feat);

% Separar en rd y sano
index_sano=1;
index_rd=1;

for i=1:cant_muestras
    indicador=entrenamiento(i,index_class);
    fila=entrenamiento(i,1:last_feat);
    if indicador==0
        sano_feats(index_sano,:)=fila;
        index_sano=index_sano+1;
    else
        rd_feats(index_rd,:)=fila;
        index_rd=index_rd+1;
    end
    
    musano=mean(sano_feats);
    sigmasano=cov(sano_feats)+1e-20; %Para evitar ceros en la diagonal
    
    murd=mean(rd_feats);
    sigmard=cov(rd_feats)+1e-20;
end
