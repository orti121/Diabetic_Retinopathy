function [TPR,FPR]=tpr_fpr(real,clasificacion)
% Recibe un vector con la clase real de los individuos, y otro con la
% clasificación de los mismos para entregar el punto de operación y poder
% armar la curva ROC.
positive=sum(real); %Cuenta la cantidad de positivos
negative=length(real)-positive; %Le resta los positivos al total para obtener cantidad de negativos.

TP=and(real,clasificacion); %Solo quedan en 1 los que son iguales.
TPR=sum(TP)/positive; %Los cuenta y normaliza para obtener la tasa.

FP=and(not(real),clasificacion); %Solo quedan en 1 los falsos positivos.
FPR=sum(FP)/negative; %Los cuenta y normaliza para obtener la tasa.
end