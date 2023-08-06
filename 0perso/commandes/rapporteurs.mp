boolean Simple,Total;
Simple=false;
Total=true;
% Rapporteur 180 graduation simple
vardef myrapporteur(expr centre,segment,rr)=
    save raps;
    picture raps;
    raps=image(
        Simple:=true;
        trace myrapporteurdouble(centre,segment,rr);
        Simple:=false;
    );
    raps
enddef;
% Rapporteur 180 graduation double
vardef myrapporteurdouble(expr centre,segment,rr)=
    save rap,cc,cd,v,w,t,ww,vv;
    picture rap;
    path cc,cd;
    pair a[],b[],v,w,t,ww,vv,rap[],rapp[];
    cc=cercle(centre,0.75*abs(centre-segment));
    t=cc intersectionpoint (centre--segment);
    w=t-2*unitvector(segment-centre);v=symetrie(w,t);
    ww=t-5*unitvector(segment-centre);vv=symetrie(ww,t);
    a0=(ww-centre) shifted centre;
    b0=(vv-centre) shifted centre;
    for i=0 upto 35 :
        for j=1 upto 4 :
            a[5*i+j]=(w-centre) rotated (rr*(5*i+j)) shifted centre;
            b[5*i+j]=(v-centre) rotated (rr*(5*i+j)) shifted centre;
        endfor;
        a[5*(i+1)]=(ww-centre) rotated (rr*(5*(i+1))) shifted centre;
        b[5*(i+1)]=(vv-centre) rotated (rr*(5*(i+1))) shifted centre;
    endfor
    picture nomb[],nombre[];
    if rr=1:
        for j=0 upto 18:
            nombre[10*j]=image(
                label.bot(TEX("\fontsize{4}{4}\selectfont"&decimal(10*j)&""),a[10*j]);
                currentpicture:=currentpicture rotatedabout(a[10*j],angle(a[10*j]-centre)-90);
            );
        endfor
        for j=0 upto 18:
            nombre[10*j+1]=image(
                % affixe.[180-10*j](b[10*j])n;
                label.top(TEX("\fontsize{4}{4}\selectfont"&decimal(180-10*j)&""),b[10*j]);
                currentpicture:=currentpicture rotatedabout(b[10*j],angle(b[10*j]-centre)-90);
            );
        endfor
    else:
        for j=0 upto 18:
            nombre[10*j]=image(
                label.bot(TEX("\fontsize{4}{4}\selectfont"&decimal(180-10*j)&""),a[10*j]);
                currentpicture:=currentpicture rotatedabout(a[10*j],angle(a[10*j]-centre)-90);
            );
        endfor
        for j=18 downto 0:
            nombre[10*j+1]=image(
                % affixe.[10*j](b[10*j])n;
                label.top(TEX("\fontsize{4}{4}\selectfont"&decimal(10*j)&""),b[10*j]);
                currentpicture:=currentpicture rotatedabout(b[10*j],angle(b[10*j]-centre)-90);
            );
        endfor
    fi
    rap=image(
        for i=0 upto 18 :
            draw nombre[10*i+1];
            if Simple=false:
                draw nombre[10*i];
            fi;
        endfor;
        path cerc;
        cerc=subpath((angle(segment-centre)*(length cc))/360,((length cc)/2)+(angle(segment-centre)*(length cc))/360) of cc;
        if rr=-1:
            draw cerc reflectedabout(segment,centre);
        else:
            draw cerc;
        fi
        draw a0--b0 withpen pencircle scaled 1.25bp;
        %%% petites graduations
        if Total=true:
            for i=0 upto 35 :
                for j=1 upto 4 :
                    draw a[5*i+j]--b[5*i+j];
                endfor;
            endfor;
            %% demi-graduations
            for i=1 step 2 until 35:
                draw a[5*i]--b[5*i];
            endfor;
        fi;
        for i=1 upto 18:
            draw a[10*i]--b[10i] withpen pencircle scaled 1.25;
        endfor;
        draw a0--a180;
        path cent;
        cent=cercle(centre,0.05*u);
        fill cent withcolor if unknown fillrap: 0.9white else: fillrap fi;
        draw centre shifted (0,-0.1u)--centre shifted (0,0.1u) withpen pencircle scaled 1.15;
        draw centre shifted (-0.1u,0)--centre shifted (0.1u,0) withpen pencircle scaled 1.15;
    );
    rap
enddef;
%%%%
% Rapporteur 360 graduation simple 10° en 10° ou 1° en 1°      
vardef rapporteuraleph(expr centre,segment,rr)=
    save rap,cc,cd,v,w,t,ww,vv;
    picture rap;
    path cc,cd;
    pair a[],b[],v,w,t,ww,vv,rap[],rapp[];
    cc=cercle(centre,0.75*abs(centre-segment));
    t=cc intersectionpoint (centre--segment);
    w=t-2*unitvector(segment-centre);v=symetrie(w,t);
    ww=t-5*unitvector(segment-centre);vv=symetrie(ww,t);
    a0=(ww-centre) shifted centre;
    b0=(vv-centre) shifted centre;
    for i=0 upto 71 :
        % Graduations 1°
        for j=1 upto 4 :
            a[5*i+j]=(w-centre) rotated (rr*(5*i+j)) shifted centre;
            b[5*i+j]=(v-centre) rotated (rr*(5*i+j)) shifted centre;
        endfor;
        % Graduations 5°
        a[5*(i+1)]=(ww-centre) rotated (rr*(5*(i+1))) shifted centre;
        b[5*(i+1)]=(vv-centre) rotated (rr*(5*(i+1))) shifted centre;
    endfor
    picture nomb[],nombre[];
    % Graduations Nombre 10°
    if rr=1:
        for j=0 upto 36:
            nombre[10*j]=image(
                % label.bot(TEX("\fontsize{4}{4}\selectfont"&decimal(10*j)&""),a[10*j]);
                label.top(TEX("\fontsize{4}{4}\selectfont"&decimal(10*j)&""),b[10*j]);
                % currentpicture:=currentpicture rotatedabout(a[10*j],angle(a[10*j]-centre)-90);
                currentpicture:=currentpicture rotatedabout(b[10*j],angle(b[10*j]-centre)-90);
            );
        endfor
        for j=0 upto 36:
            nombre[10*j+1]=image(
                % affixe.[180-10*j](b[10*j])n;
                label.top(TEX("\fontsize{4}{4}\selectfont"&decimal(180-10*j)&""),b[10*j]);
                currentpicture:=currentpicture rotatedabout(b[10*j],angle(b[10*j]-centre)-90);
            );
        endfor
    else:
        % for j=0 upto 36:
        %   nombre[10*j]=image(
        %     label.bot(TEX("\fontsize{4}{4}\selectfont"&decimal(180-10*j)&""),a[10*j]);
        %     currentpicture:=currentpicture rotatedabout(a[10*j],angle(a[10*j]-centre)-90);
        %   );
        % endfor
        % for j=36 downto 0:
        %   nombre[10*j+1]=image(
        %     % affixe.[10*j](b[10*j])n;
        %     label.top(TEX("\fontsize{4}{4}\selectfont"&decimal(10*j)&""),b[10*j]);
        %     currentpicture:=currentpicture rotatedabout(b[10*j],angle(b[10*j]-centre)-90);
        %   );
        % endfor          
    fi
    % Dessin
    rap=image(
        for i=0 upto 35 :
            % draw nombre[10*i+1];
            draw nombre[10*i];
            if Simple=false:
                draw nombre[10*i];
            fi;
        endfor;
        % Le rapporteur
        path cerc;
        % cerc=subpath((angle(segment-centre)*(length cc))/360,((length cc)/2)+(angle(segment-centre)*(length cc))/360) of cc;
        cerc = cc;
        if rr=-1:
            draw cerc reflectedabout(segment,centre);
        else:
            draw cerc;
        fi
        draw a0--b0 withpen pencircle scaled 1.25bp;
        %%% petites graduations
        if Total=true:
            for i=0 upto 71 :
                for j=1 upto 4 :
                    draw a[5*i+j]--b[5*i+j];
                endfor;
            endfor;
            %% demi-graduations
            for i=1 step 2 until 71:
                draw a[5*i]--b[5*i];
            endfor;
        fi;
        % Graduations 10° 
        for i=1 upto 36:
            draw a[10*i]--b[10i] withpen pencircle scaled 1.25;
        endfor;
        draw a0--a180;
        % Centre du rapporteuraleph
        path cent;
        cent=cercle(centre,0.05*u);
        fill cent withcolor if unknown fillrap: 0.9white else: fillrap fi;
        draw centre shifted (0,-0.1u)--centre shifted (0,0.1u) withpen pencircle scaled 1.15;
        draw centre shifted (-0.1u,0)--centre shifted (0.1u,0) withpen pencircle scaled 1.15;
        % fleches orientées
        path fleche[];
        fleche0=cercle(centre,0.3*abs(centre-segment));
        fleche1=cercle(centre,0.4*abs(centre-segment));
        fleche2=cercle(centre,0.5*abs(centre-segment));
        drawarrow (subpath(0,1) of fleche0);
        drawarrow (subpath(0,1) of fleche1);
        drawarrow (subpath(0,1) of fleche2);
    );
    rap
enddef;
