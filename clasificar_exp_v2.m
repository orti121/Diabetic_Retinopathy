function [clasificacion, real]=clasificar_exp_v2(musano,sigmasano,murd,sigmard,umbral,prueba)
% Clasifica cada muestra del conjunto de prueba de acuerdo a gaussiana
% multivariable determinada por las estadísticas en los histogramas.
% Se obtienen las clasificaciones y valores reales para su uso en la
% elaboración de la curva ROC.

cantidad_muestras=length(prueba(:,1));

real=prueba(:,17);
clasificacion=zeros(size(real));


% Ubicar y evaluar cada muestra.
for i=1:cantidad_muestras
   muestra=prueba(i,:);
   [clasificacion(i)]=clasif_1_exp(musano,sigmasano,murd,sigmard,umbral,muestra);
end
    
end