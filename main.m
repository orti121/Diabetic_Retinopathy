% Carga los conjuntos de entrenamiento y prueba escogidos, adem�s de las
% probabilidades a priori, basado en la proporci�n de muestras en el
% conjunto de entrenamiento.
%clear
%load('workspace_definitivo.mat') 

[bins_sano,bins_rd,probs_sano,probs_rd,musano,sigmasano,murd,sigmard]=entrenar(train,25,1);
roc_hist(bins_sano,bins_rd,probs_sano,probs_rd,test,0:0.01:10,'b')