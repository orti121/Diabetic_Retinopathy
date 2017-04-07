function [clasificacion]=clasif_1_exp(musano,sigmasano,murd,sigmard,theta,muestra)

    ver_sano=mvnpdf(muestra(1:16),musano,sigmasano); 
    ver_rd=mvnpdf(muestra(1:16),murd,sigmard);
    
    proporcion=ver_rd/ver_sano;
    
    if proporcion>theta
        clasificacion=1;
    else
        clasificacion=0;
    end
end
 