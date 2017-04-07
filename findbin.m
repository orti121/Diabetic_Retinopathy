function [index]=findbin(muestra,binset)
% Encuentra el bin al cual pertenece un número.
if muestra<min(binset)
    index=1;
elseif muestra>max(binset)
    index=length(binset);
else
    index=1;
    while muestra>binset(index)
        if muestra<binset(index+1)
            break
        end
        index=index+1;
    end
end
end