function [bins_sano,bins_rd,probs_sano,probs_rd,musano,sigmasano,murd,sigmard]=entrenar(train,bins,graficar)
% Entrenamiento del clasificador, tanto no paramétrico como aproximando una
% gaussiana multidimensional. Se debe ingresar el conjunto de entrenamiento y la cantidad de bins.
[bins_sano,bins_rd,probs_sano,probs_rd]=generar_histogramas_v3(train,bins,graficar);
[musano,sigmasano,murd,sigmard]=est_exp(train);
end
