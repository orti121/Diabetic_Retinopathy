function roc_hist(binranges_sano,binranges_rd,probs_sano,probs_rd,prueba,rango,color)
% color debe ser un string con el color codificado de la misma forma que se
% usa en plot
TPR=zeros(size(rango));
FPR=zeros(size(rango));

for i=1:length(rango)
[clasificacion,real]=clasificar_hist_v3(binranges_sano,binranges_rd,probs_sano,probs_rd,rango(i),prueba);
[TPR(i),FPR(i)]=tpr_fpr(real,clasificacion);
end

figure(4)
plot(FPR,TPR,color)
title('Curva ROC')
xlabel('FPR')
ylabel('TPR')
axis([0,1,0,1])
end