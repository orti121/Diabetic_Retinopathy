function [binranges_sano,binranges_rd,probs_sano,probs_rd]=generar_histogramas_v3(entrenamiento,bins_quantity,graficar)
% Calcula los histogramas de todas las características.
% graficar=0 para no graficar nada, 1 para graficar.

% Entrega los bins para cada característica y las probabilidades asociadas
% de acuerdo a los histogramas en matrices de last_featxbins_quantity.
index_class=length(entrenamiento(1,:));
last_feat=index_class-1;
cant_muestras=length(entrenamiento(:,index_class));

bin=0:1;
[cantidades] = histc(entrenamiento(:,index_class),bin) %Cantidades de cada tipo
sano_feats=zeros(cantidades(1),last_feat);
rd_feats=zeros(cantidades(2),last_feat);

% Separar en rd y sano para hacer los histogramas
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
end

% Vectores de minimos y maximos
mins_sano=zeros(1,last_feat);
mins_rd=zeros(1,last_feat);

maxs_sano=zeros(1,last_feat);
maxs_rd=zeros(1,last_feat);

% %Asignar limites para los bins. 
% for i=1:1:last_feat
%     mins_sano(i)=min(sano_feats(:,i));
%     mins_rd(i)=min(rd_feats(:,i));
% 
%     maxs_sano(i)=max(sano_feats(:,i));
%     maxs_rd(i)=max(rd_feats(:,i));     
% end

%Asignar limites para los bins. Se usaran percentiles para eliminar 
%outliers. Se pone un piso de 0.0001 para eliminar los ceros erróneos.
for i=1:1:last_feat
    mins_sano(i)=max([0.0001 min(sano_feats(:,i))]);
    mins_rd(i)=max([0.0001 min(rd_feats(:,i))]);

    maxs_sano(i)=prctile(sano_feats(:,i),99.5);
    maxs_rd(i)=prctile(rd_feats(:,i),99.5);     
end

% Diferencias, para generar bins variables
d_sano=maxs_sano-mins_sano;
d_rd=maxs_rd-mins_rd;

denominador=bins_quantity-1;

% Inicialización de variables de salida
binranges_sano=zeros(last_feat,bins_quantity);
binranges_rd=zeros(last_feat,bins_quantity);
probs_sano=zeros(last_feat,bins_quantity);
probs_rd=zeros(last_feat,bins_quantity);

% Histogramas!
nombres=char('MA Detection, alpha=0.5','MA Detection, alpha=0.6','MA Detection, alpha=0.7','MA Detection, alpha=0.8','MA Detection, alpha=0.9','MA Detection, alpha=1','Exudates(1)','Exudates(2)','Exudates(3)','Exudates(4)','Exudates(5)','Exudates(6)','Exudates(7)','Exudates(8)','Optic disc center to Macula center distance','Optic disc diameter');
close all %por si hay otras figuras abiertas


    for i=1:1:last_feat
        %rd
        minimo=mins_rd(i);
        maximo=maxs_rd(i);
        paso=d_rd(i)/denominador;
        binranges = minimo:paso:maximo;
        [bins] = histc(rd_feats(:,i),binranges);
        bins_norm=bins/sum(bins);
        
        binranges_rd(i,:)=binranges;
        probs_rd(i,:)=transpose(bins_norm);
        
        %sano
        minimo_s=mins_sano(i);
        maximo_s=maxs_sano(i);
        paso_s=d_sano(i)/denominador;
        binranges_s = minimo_s:paso_s:maximo_s;
        [bins_s] = histc(sano_feats(:,i),binranges_s);
        bins_norm_s=bins_s/sum(bins_s);
        
        binranges_sano(i,:)=binranges_s;
        probs_sano(i,:)=transpose(bins_norm_s);
        
        % MA 
        if graficar && i<=6
        figure(1)
        subplot(2,3,i)
        hold on
        stairs(binranges,bins_norm,'r')
        stairs(binranges_s,bins_norm_s,'k')
        title(nombres(i,:))
        xlabel('Valores')
        ylabel('Frecuencia Relativa')
        
        % Exudates
        elseif graficar && i<=14
        figure(2)
        subplot(2,4,i-6)
        hold on
        stairs(binranges,bins_norm,'r')
        stairs(binranges_s,bins_norm_s,'k')
        title(nombres(i,:))
        xlabel('Valores')
        ylabel('Frecuencia Relativa')
        
        % Disc Macula & Optic Disc
        elseif graficar && i>14
        figure(3)
        subplot(2,1,i-14)
        hold on
        stairs(binranges,bins_norm,'r')
        stairs(binranges_s,bins_norm_s,'k')
        title(nombres(i,:))
        xlabel('Valores')
        ylabel('Frecuencia Relativa')
        
        end
    end
end
