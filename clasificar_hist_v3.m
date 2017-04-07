function [clasificacion, real]=clasificar_hist_v3(bins_sano,bins_rd,prob_sano,prob_rd,umbral,prueba)
% Clasifica cada muestra del conjunto de prueba de acuerdo a las
% distribuciones encontradas con los histogramas. 

% bins_sano y bins_rd: Matrices de 16xN que contienen los bins de los
% histogramas para cada característica, con N=cantidad de bins.

% prob_sano y prob_rd: Matrices de 16xN que contienen la probabilidad
% asociada a cada bin y característica.

% Se obtienen las clasificaciones y valores reales para su uso en la
% elaboración de la curva ROC.

cantidad_muestras=length(prueba(:,1));

real=prueba(:,17);
clasificacion=zeros(size(real));


% Ubicar y evaluar cada muestra.
for i=1:cantidad_muestras
   muestra=prueba(i,:);
   [clasificacion(i)]=clasif_1_hist(bins_sano,bins_rd,prob_sano,prob_rd,umbral,muestra);
end
    
end
