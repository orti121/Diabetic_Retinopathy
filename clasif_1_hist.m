function [clasificacion]=clasif_1_hist(bins_sano,bins_rd,prob_sano,prob_rd,theta,muestra)
% Clasifica una muestra
% bins_sano y bins_rd: Matrices de index_caractxN que contienen los bins de los
% histogramas para cada característica, con N=cantidad de bins.

% prob_sano y prob_rd: Matrices de index_caractxN que contienen la probabilidad
% asociada a cada bin y característica.

% Entrega clasificación y valor real para su posterior uso en la curva ROC.
    index_caract=length(muestra)-1;

    probs_sano=zeros(1,index_caract); %Inicializar la probabilidad asociada a cada característica.
    probs_rd=zeros(1,index_caract);
    

    for i=1:index_caract
        % sano
        index_sano=findbin(muestra(i),bins_sano(i,:));
        probs_sano(i)=prob_sano(i,index_sano);
        
        % rd
        index_rd=findbin(muestra(i),bins_rd(i,:));
        probs_rd(i)=prob_rd(i,index_rd);
    end
    
    % Agregamos un pequeño epsilon para que no se haga cero ninguna
    % probabilidad.
    probs_sano=probs_sano+1e-20;
    probs_rd=probs_rd+1e-20;
    
    ver_sano=prod(probs_sano); %verosimilitudes
    ver_rd=prod(probs_rd);
    
    proporcion=ver_rd/ver_sano;
    
    if proporcion>theta
        clasificacion=1;
    else
        clasificacion=0;
    end
 
end