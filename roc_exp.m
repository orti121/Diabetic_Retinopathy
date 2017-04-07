function roc_exp(musano,sigmasano,murd,sigmard,rango,prueba,color)
% color debe ser un string con el color codificado de la misma forma que se
% usa en plot
TPR=zeros(size(rango));
FPR=zeros(size(rango));

for i=1:length(rango)
[clasificacion, real]=clasificar_exp_v2(musano,sigmasano,murd,sigmard,rango(i),prueba);
[TPR(i),FPR(i)]=tpr_fpr(real,clasificacion);
end

plot(FPR,TPR,color)
title('Curva ROC')
xlabel('FPR')
ylabel('TPR')
axis([0,1,0,1])
end