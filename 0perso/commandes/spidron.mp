    vardef spidron(expr long,pas)=
    save $;
    picture $;
    pair M[];
    M1=u*(long,1);
    M2-M1=u*(-(long-1),0);
    for k=1 upto pas:
        if (k mod 2)=1:
        M[2+k]=demidroite(M[k],rotation(M[k+1],M[k],-30))%
        intersectionpoint demidroite(M[k+1],rotation(M[k],M[k+1],30));
        else:
        M[k+2]=rotation(M[k+1],M[k],60);
        fi;
    endfor;
    $=image(
        for k=1 upto pas:
        trace polygone(M[k],M[k+1],M[k+2]);
        endfor;
        );
    $
    enddef;