%%%% Inicialización de variables importantes %%%%%
load('workspace_definitivo.mat')
[bins_sano,bins_rd,probs_sano,probs_rd]=generar_histogramas_v3(train,30,1);
[musano,sigmasano,murd,sigmard]=est_exp(train);