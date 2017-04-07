function [priori_sano, priori_rd]=check_dist(original,entrenamiento,prueba,graficar)
%Muestra distribuciones del conjunto de entrenamiento y prueba para
%verificar que se dirstibuyan parecido a la base de datos completa.
%Entrega la probabilidad a priori de cada diagnóstico según el conjunto de
%entrenamiento.
clases = 0:1;
index_class = length(original(1,:)); %Índice para extraer la clase

[cuentas_completa] = histc(original(:,index_class),clases);
cuentas_completa_norm=cuentas_completa/sum(cuentas_completa); %Cuentas normalizadas

[cuentas_entrenamiento] = histc(entrenamiento(:,index_class),clases);
cuentas_entrenamiento_norm=cuentas_entrenamiento/sum(cuentas_entrenamiento);
priori_sano=cuentas_entrenamiento_norm(1);
priori_rd=cuentas_entrenamiento_norm(2);

[cuentas_prueba] = histc(prueba(:,index_class),clases);
cuentas_prueba_norm=cuentas_prueba/sum(cuentas_prueba);

if graficar
    
    figure(1)
    bar(clases,cuentas_completa_norm,'histc')
    title('Base de datos completa')
    xlabel('Caso')
    ylabel('Frecuencia Relativa')

    figure(2)
    bar(clases,cuentas_entrenamiento_norm,'histc')
    title('Base de datos de entrenamiento')
    xlabel('Caso')
    ylabel('Frecuencia Relativa')

    figure(3)
    bar(clases,cuentas_prueba_norm,'histc')
    title('Base de datos de prueba')
    xlabel('Caso')
    ylabel('Frecuencia Relativa')
    
end

end