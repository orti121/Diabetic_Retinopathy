function [binranges_sano,binranges_rd,probs_sano,probs_rd]=generar_histogramas_v3(entrenamiento,bins_quantity,graficar)
% Calcula los histogramas de todas las características.
% graficar=0 para no graficar nada, 1 para graficar.

% Entrega los bins para cada característica y las probabilidades asociadas
% de acuerdo a los histogramas en matrices de 16xbins_quantity.



bin=0:1;
[cantidades] = histc(entrenamiento(:,17),bin); %Cantidades de cada tipo
sano=zeros(cantidades(1),17);
rd=zeros(cantidades(2),17);

% Separar en rd y sano para hacer los histogramas
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
end

% Vectores de minimos y maximos
mins_sano=zeros(1,16);
mins_rd=zeros(1,16);

maxs_sano=zeros(1,16);
maxs_rd=zeros(1,16);

%Asignar limites para los bins. 
for i=1:1:16
    mins_sano(i)=min(sano(:,i));
    mins_rd(i)=min(rd(:,i));

    maxs_sano(i)=max(sano(:,i));
    maxs_rd(i)=max(rd(:,i));     
end

% Diferencias, para generar bins variables
d_sano=maxs_sano-mins_sano;
d_rd=maxs_rd-mins_rd;

denominador=bins_quantity-1;

% Inicialización de variables de salida
binranges_sano=zeros(16,bins_quantity);
binranges_rd=zeros(16,bins_quantity);
probs_sano=zeros(16,bins_quantity);
probs_rd=zeros(16,bins_quantity);

% Histogramas!
nombres=char('MA Detection, alpha=0.5','MA Detection, alpha=0.6','MA Detection, alpha=0.7','MA Detection, alpha=0.8','MA Detection, alpha=0.9','MA Detection, alpha=1','Exudates(1)','Exudates(2)','Exudates(3)','Exudates(4)','Exudates(5)','Exudates(6)','Exudates(7)','Exudates(8)','Optic disc center to Macula center distance','Optic disc diameter');
close all %por si hay otras figuras abiertas


    for i=1:1:16
        %rd
        minimo=mins_rd(i);
        maximo=maxs_rd(i);
        paso=d_rd(i)/denominador;
        binranges = minimo:paso:maximo;
        [bins] = histc(rd(:,i),binranges);
        bins_norm=bins/sum(bins);
        
        binranges_rd(i,:)=binranges;
        probs_rd(i,:)=transpose(bins_norm);
        
        %sano
        minimo_s=mins_sano(i);
        maximo_s=maxs_sano(i);
        paso_s=d_sano(i)/denominador;
        binranges_s = minimo_s:paso_s:maximo_s;
        [bins_s] = histc(sano(:,i),binranges_s);
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
