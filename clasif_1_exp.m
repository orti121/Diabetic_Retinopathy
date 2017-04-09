function [clasificacion]=clasif_1_exp(musano,sigmasano,murd,sigmard,theta,muestra)
    
    index_caract=length(muestra)-1;
    ver_sano=mvnpdf(muestra(1:index_caract),musano,sigmasano); 
    ver_rd=mvnpdf(muestra(1:index_caract),murd,sigmard);
    
    proporcion=ver_rd/ver_sano;
    
    if proporcion>theta
        clasificacion=1;
    else
        clasificacion=0;
    end
end
 