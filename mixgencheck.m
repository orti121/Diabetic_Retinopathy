function [mix,entrenamiento,prueba,priori_sano,priori_rd]=mixgencheck(database,razon_entrenamiento)
mix=mix_database(database);
[entrenamiento , prueba]=generar_conjuntos(mix,razon_entrenamiento);
[priori_sano,priori_rd]=check_dist(mix,entrenamiento,prueba,1);
end