%Package mp-geographie
%Auteur:Christophe Poulain
%Version 0.62
%16/02/2010

input marith;
input sarith;
%input LATEX;

pi:=3.141592654;
c:=57.29578; % conversion d'un radian en degrés

color _T[],rouge,vert,bleu,jaune,noir,blanc,orange,rose,violet,ciel,cielfonce,orangevif,gris,tan,payscolor;

rouge=(1,0,0);
bleu=(0,0,1);
noir=(0,0,0);
blanc=(1,1,1);
orange=(1,0.5,0);
violet=(1,0,1);
rose=(1,0.7,0.7);
cielfonce=(0.25,0.75,1);
ciel=(0,1,1);
orangevif=(1,0.25,0.1);
vert=(0,1,0);
jaune=(1,1,0);
gris=0.8*white;

tan=(0.824,0.705,0.55);
payscolor=tan;

vardef flamme=reverse(2mm*(0.5,1){dir90}..2mm*(0.75,1.5)..{dir90}2mm*(1,2))--2mm*(0.5,1){dir=-90}..2mm*(1,0.5)..{dir=90}2mm*(1.5,1)--((2mm*(0.5,1){dir90}..2mm*(0.75,1.5)..{dir90}2mm*(1,2)) reflectedabout (2mm*(1,0),2mm*(1,0)+2mm*(0,1)))--cycle
enddef;

%
pair poubelle;

%Les marques

string marque_p;
marque_p := "non";
marque_r := 20;

def MarquePoint(expr p)=
  if marque_p = "creux":
    if color p:
      fill fullcircle scaled (marque_r/5) shifted (Projgeo(p)) withcolor white;
      draw fullcircle scaled (marque_r/5) shifted (Projgeo(p));
    else:
      fill fullcircle scaled (marque_r/5) shifted (p) withcolor white;
      draw fullcircle scaled (marque_r/5) shifted (p);
    fi;
  elseif marque_p = "croix":
    drawoptions(withpen pencircle scaled 1.25);
    if color p:
      draw (Projgeo(p) shifted (-marque_r/20,marque_r/20))--(Projgeo(p) shifted (marque_r/20,-marque_r/20));
      draw (Projgeo(p) shifted (-marque_r/20,-marque_r/20))--(Projgeo(p) shifted (marque_r/20,marque_r/20));
    else:
      draw ((p) shifted (-marque_r/20,marque_r/20))--((p) shifted (marque_r/20,-marque_r/20));
      draw ((p) shifted (-marque_r/20,-marque_r/20))--((p) shifted (marque_r/20,marque_r/20));
    fi;
    drawoptions();
  fi;
enddef;

vardef pointe(text t) =
  for p_ = t: if (pair p_) or (color p_): MarquePoint(p_); fi endfor;
enddef;

%Définition pour la feuille

path feuillet;
numeric _tfig,_nfig;
_nfig:=0;
u:=1cm;

def feuille(expr xa,ya,xb,yb) =
  numeric Xa,Ya;
  Xa=xa;
  Ya=ya;
  feuillet := (xa,ya)--(xa,yb)--(xb,yb)--(xb,ya)--cycle;
  extra_endfig := "clip currentpicture to feuillet;" & extra_endfig;
enddef;

def figureespace(expr xa,ya,xb,yb) =
  _nfig:=_nfig+1;
  beginfig(_nfig);
    feuille(xa,ya,xb,yb);
enddef;  

def finespace=
endfig;
enddef;

def figure(expr xa,ya,xb,yb)=figureespace(xa,ya,xb,yb)
enddef;

def fin=finespace
enddef;

%definitions mathématiques
vardef cercles(text t)=
  save Cer;
  save n;
  n:=0;
  for p_=t:
    if color p_:
      n:=n+1;
      _T[n]:=p_;
    fi;
  endfor;
  path Cer;
  color ptcer[];
  for k=0 step 5 until 360 :
    ptcer[k div 5]-_T[1]=Distance(_T[1],_T[2])*((_T[4]-_T[3])*cosd(k)/Distance(_T[3],_T[4])+(_T[5]-_T[3])*sind(k)/Distance(_T[3],_T[5]));
  endfor;
  Cer=Projgeo(ptcer0)
  for k=0 step 5 until 360 :
    ..Projgeo(ptcer[k div 5])
  endfor
  ..cycle;
  Cer
enddef;

vardef arcsind(expr x)=%en degré ici :)
  angle((sqrt(1-x**2),x))
enddef;

vardef arccosd(expr x)=%en degré ici :)
  angle((x,sqrt(1-x**2)))
enddef;

vardef tand(expr x)=sind(x)/cosd(x)%
enddef;

vardef cotand(expr x)=cosd(x)/sind(x)%
enddef;

vardef sinc(expr x)=if abs(x)<0.001:1 else:sind(x)*c/x fi enddef;

vardef ln(expr t)=mlog(t)/256%
enddef;

%représentation paramétrique de la sphère terrestre.
vardef FX(expr t,v)=rayon*cosd(c*t)*cosd(c*v)
enddef;

vardef FY(expr t,v)=rayon*cosd(c*t)*sind(c*v)
enddef;

vardef FZ(expr t,v)=rayon*sind(c*t)
enddef;

vardef FXx(expr t,v)=rayon*cosd(t)*cosd(v)
enddef;

vardef FYy(expr t,v)=rayon*cosd(t)*sind(v)
enddef;

vardef FZz(expr t,v)=rayon*sind(t)
enddef;

%Paramètres et macros de représentation
vardef Initialisation(expr r,t,p,d)=
  Rho:=r;
  Theta:=t;
  Phi:=p;
  DE:=d;
  Aux1:=sind(Theta);
  Aux2:=sind(Phi);
  Aux3:=cosd(Theta);
  Aux4:=cosd(Phi);
  Aux5:=Aux3*Aux2;
  Aux6:=Aux1*Aux2;
  Aux7:=Aux3*Aux4;
  Aux8:=Aux1*Aux4;
enddef;

vardef Oeil=(Rho*Aux7,Rho*Aux8,Rho*Aux2)
enddef;

vardef Vision(expr num)=
  save bb;
  color bb;
  bb=(redpart(Oeil-Sommet[num]),greenpart(Oeil-Sommet[num]),bluepart(Oeil-Sommet[num]));  
  bb
enddef;

vardef Normal(expr vecun,vecde,vectr)=
  save aa;
  color aa;
  P1:=redpart(vecde-vecun);
  P2:=greenpart(vecde-vecun);
  P3:=bluepart(vecde-vecun);
  Q1:=redpart(vectr-vecun);
  Q2:=greenpart(vectr-vecun);
  Q3:=bluepart(vectr-vecun);
  aa=(P2*Q3-Q2*P3,P3*Q1-Q3*P1,P1*Q2-Q1*P2);
  aa
enddef;

vardef ProduitScalaire(expr wec,mor)=
  redpart(wec)*redpart(mor)+greenpart(wec)*greenpart(mor)+bluepart(wec)*bluepart(mor)
enddef;

vardef Distance(expr aa,bb)=%Entre deux points
  sqrt((redpart(bb)-redpart(aa))*(redpart(bb)-redpart(aa))+(greenpart(bb)-greenpart(aa))*(greenpart(bb)-greenpart(aa))+(bluepart(bb)-bluepart(aa))*(bluepart(bb)-bluepart(aa)))
enddef;

vardef MaillageS=
  path Maillage[];
  color CentMaillage[];
  %numeric Vmin,Vmax;
  %total:=0;
  for k=Udebut step 0.5*pasU until (Ufin):
    for l=Vdebut step pasV until (Vfin):
      Maillage[100*k+l]=Projgeo((FX(k,l),FY(k,l),FZ(k,l)))--Projgeo((FX(k,l+pasV),FY(k,l+pasV),FZ(k,l+pasV)))--Projgeo((FX(k+pasU,l+pasV),FY(k+pasU,l+pasV),FZ(k+pasU,l+pasV)))--Projgeo((FX(k+pasU,l),FY(k+pasU,l),FZ(k+pasU,l)))--cycle;
      if ProduitScalaire(1/2[(FX(k,l),FY(k,l),FZ(k,l)),(FX(k+pasU,l+pasV),FY(k+pasU,l+pasV),FZ(k+pasU,l+pasV))]-pte3,Oeil-pte3)>0:
	draw Maillage[100*k+l];
      fi;
    endfor;
  endfor;
enddef;

vardef InitialiseMaillage(expr ud,uf,up,vd,vf,vp)=
  Udebut:=ud;
  Ufin:=uf;
  pasU:=up;
  Vdebut:=vd;
  Vfin:=vf;
  pasV:=vp;
enddef;

vardef MaillageSphere=
  InitialiseMaillage(((phim div 10)+1)*pi/18,((phip div 10)-1)*pi/18,pi/18,-pi,pi,pi/36);
  MaillageS;
enddef;

vardef MaillageSphereCoord=
%  InitialiseMaillage(((phim div 10)+1)*pi/12,((phip div 10)-1)*pi/12,pi/12,-pi,pi,pi/12);
  InitialiseMaillage(-pi/2,pi/2,pi/18,-pi,pi,pi/12);
  %MaillageS;
  path Maillage[];
  nbmor:=0;
  for k=-90 step 10 until 90:
    for l=-180 step 10 until 180:
      nbl:=nbl+1;
      if ProduitScalaire(1/2[(FXx(k,l),FYy(k,l),FZz(k,l)),(FXx(k+10,l+10),FYy(k+10,l+10),FZz(k+10,l+10))]-pte3,Oeil-pte3)>0:
	nbmor:=nbmor+1;
	Maillage[nbmor]=Projgeo((FXx(k,l),FYy(k,l),FZz(k,l)))..Projgeo((FXx(k,l+10),FYy(k,l+10),FZz(k,l+10)));
	draw Maillage[nbmor] if k=0: withpen pencircle scaled 1 withcolor Crimson fi;
	draw Projgeo((FXx(k,l),FYy(k,l),FZz(k,l)))..Projgeo((FXx(k+10,l),FYy(k+10,l),FZz(k+10,l))) if l=0:withpen pencircle scaled 1 withcolor LightSteelBlue fi;
      fi;
    endfor;
  endfor;  
enddef;

boolean maille;
maille=false;

vardef ParaMeri(expr lonn,latt)=%longitude et latitude en degrés%Parallèle et méridien particulier pour une représentation 3d.
  maille:=true;
  latpar:=latt;
  lonpar:=lonn;
enddef;

vardef Maille=
  InitialiseMaillage(((phim div 10)+1)*pi/18,((phip div 10)-1)*pi/18,pi/36,-pi,pi,pi/72);
  path SMaillage[];picture Smaille;
  drawoptions(withpen pencircle scaled 2bp withcolor orangevif);
  for l=Vdebut step pasV until (Vfin+pasV):
    SMaillage[100*latpar+l]=Projgeo((FX(latpar/c,l),FY(latpar/c,l),FZ(latpar/c,l)))--Projgeo((FX(latpar/c,l+pasV),FY(latpar/c,l+pasV),FZ(latpar/c,l+pasV)));
    if ProduitScalaire(1/2[(FX(latpar/c,l),FY(latpar/c,l),FZ(latpar/c,l)),(FX(latpar/c,l+pasV),FY(latpar/c,l+pasV),FZ(latpar/c,l+pasV))]-pte3,Oeil-pte3)>0:
      draw SMaillage[100*latpar+l];
    fi;
  endfor;
  for k=Udebut step pasU until (Ufin+pasU):
    SMaillage[k+100*lonpar]:=Projgeo((FX(k,lonpar/c),FY(k,lonpar/c),FZ(k,lonpar/c)))--Projgeo((FX(k+pasU,lonpar/c),FY(k+pasU,lonpar/c),FZ(k+pasU,lonpar/c)));
    if ProduitScalaire(1/2[(FX(k,lonpar/c),FY(k,lonpar/c),FZ(k,lonpar/c)),(FX(k+pasU,lonpar/c),FY(k+pasU,lonpar/c),FZ(k+pasU,lonpar/c))]-pte3,Oeil-pte3)>0:
      draw SMaillage[k+100*lonpar];
    fi;
  endfor;
  drawoptions();
    %);
enddef;

vardef Projgeo(expr X)=
  pair $;
  numeric Xobs,Yobs,Zobs,XProj,YProj;
  Xobs = -redpart(X)*Aux1 + greenpart(X)*Aux3;
  Yobs = -redpart(X)*Aux5 - greenpart(X)*Aux6 + bluepart(X)*Aux4;
  Zobs = -redpart(X)*Aux7 - greenpart(X)*Aux8 - bluepart(X)*Aux2 + Rho;
  XProj = DE*Xobs/Zobs;
  YProj = DE*Yobs/Zobs;
  $=(XProj,YProj);
  $
enddef;

%Début du package
numeric nbpts,nblec,nbcapitales;

vardef lecture(expr nomfichier,fond)=
  color Coord[],Pays[];
  numeric ll;
  ll:=0;
  nbpts:=scantokens readfrom nomfichier;
%  for k=1 upto (nbpts div 3):
%    pair latlon;
%    latlon=((scantokens readfrom nomfichier)+(scantokens readfrom nomfichier)+(scantokens readfrom nomfichier))/3;
  if nbpts<Allegee:
    Alleg:=1;
  else:
    Alleg:=Allegee;
  fi;
  for k=1 upto (nbpts div Alleg):
    pair latlon;
    latlon=((scantokens readfrom nomfichier) for l=2 upto Alleg:
	+(scantokens readfrom nomfichier)
    endfor)/Alleg;
    Coord[k]=rayon*(cosd(xpart(latlon/60))*cosd(ypart(latlon/60)),cosd(xpart(latlon/60))*sind(ypart(latlon/60)),sind(xpart(latlon/60)));
    if ((xpart(latlon/60)>phim) and (xpart(latlon/60)<phip)):
      if ProduitScalaire(Coord[k]-pte3,Oeil-pte3)>0:
	ll:=ll+1;
	Pays[k]=Coord[k];
      else:
	Pays[k]=2*Coord[k];
      fi;
    else:
      Pays[k]=2*Coord[k];
    fi;
  endfor;
  closefrom nomfichier;
  path pays;
  if ll>0:
    pays=Projgeo(Pays[1])
    for l=2 upto (nbpts div Alleg):%(nbpts div 3):
      --Projgeo(Pays[l])
    endfor;
    if noncolore=true:
      fill pays--cycle withcolor payscolor;
    else:
      fill pays--cycle withcolor fond;
    fi;
    draw pays withpen pencircle scaled 0.25;
    clip currentpicture to cercles(pte3,pte1,pte3,pte1,pte4);
  fi;
enddef;

string nomfichiermul,NomFichier;

vardef Lectureiles=
  nomfichiermul:=arborescence&"PfCiles.dat";
  nblec:=scantokens readfrom nomfichiermul;
  for p=1 upto nblec:
    color Coord[],fond,Pays[];
    numeric ll;
    ll:=0;
    nbpts:=scantokens readfrom nomfichiermul;
    fond=scantokens readfrom nomfichiermul;
    %if nbpts<Allegee:
    Alleg:=1;
    %else:
    %  Alleg:=2;%pas Allegee car sinon des artefacts apparaissent
    %fi;
    for k=1 upto (nbpts div Alleg):
      pair latlon;
      latlon=((scantokens readfrom nomfichiermul) for l=2 upto Alleg:
	  +(scantokens readfrom nomfichiermul)
      endfor)/Alleg;
%    for k=1 upto nbpts:
%      pair latlon;
%      latlon=scantokens readfrom nomfichiermul;
      Coord[k]=rayon*(cosd(xpart(latlon/60))*cosd(ypart(latlon/60)),cosd(xpart(latlon/60))*sind(ypart(latlon/60)),sind(xpart(latlon/60)));
      if ((xpart(latlon/60)>phim) and (xpart(latlon/60)<phip)):
	if ProduitScalaire(Coord[k]-pte3,Oeil-pte3)>0:
	  ll:=ll+1;
	  Pays[k]=Coord[k];
	else:
	  Pays[k]=2*Coord[k];
	fi;
      else:
	Pays[k]=2*Coord[k];
      fi;
    endfor;
    path pays;
     if ll>0:
      pays=Projgeo(Pays[1])
      for l=2 upto (nbpts div Alleg):%nbpts:
	--Projgeo(Pays[l])
      endfor;
      if noncolore=true:
	fill pays--cycle withcolor payscolor;
      else:
	fill pays--cycle withcolor fond;
      fi;
      draw pays withpen pencircle scaled 0.25;
      clip currentpicture to cercles(pte3,pte1,pte3,pte1,pte4);
    fi;
    % rustine pour tout lire chaque partie de Ile.dat
    if Alleg>1:
      for po=1 upto (nbpts mod Alleg):
	poubelle:=scantokens readfrom nomfichiermul;
      endfor;
    fi;
  endfor;
  closefrom nomfichiermul;
enddef;

vardef Lecturelacs=
  nomfichiermul:=arborescence&"PfClacs.dat";
  nblec:=scantokens readfrom nomfichiermul;
  for p=1 upto nblec:
    color Coord[],Pays[];
    numeric ll;
    ll:=0;
    nbpts:=scantokens readfrom nomfichiermul;
    for k=1 upto nbpts:
      pair latlon;
      latlon=scantokens readfrom nomfichiermul;
      Coord[k]=rayon*(cosd(xpart(latlon/60))*cosd(ypart(latlon/60)),cosd(xpart(latlon/60))*sind(ypart(latlon/60)),sind(xpart(latlon/60)));
      if ((xpart(latlon/60)>phim) and (xpart(latlon/60)<phip)):
	if ProduitScalaire(Coord[k]-pte3,Oeil-pte3)>0:
	  ll:=ll+1;
	  Pays[k]=Coord[k];
	else:
	  Pays[k]=2*Coord[k];
	fi;
      else:
	Pays[k]=2*Coord[k];
      fi;
    endfor;
    path pays;
    if ll>0:
      pays=Projgeo(Pays[1])
      for l=2 upto nbpts:
	--Projgeo(Pays[l])
      endfor;
      fill pays--cycle withcolor couleurfleuve;
      draw pays;
      clip currentpicture to cercles(pte3,pte1,pte3,pte1,pte4);
    fi;
  endfor;
  closefrom nomfichiermul;
enddef;

vardef Lecturelacssup=
  nomfichiermul:=arborescence&"PfClacssup.dat";
  nblec:=scantokens readfrom nomfichiermul;
  for p=1 upto nblec:
    color Coord[],Pays[];
    numeric ll;
    ll:=0;
    nbpts:=scantokens readfrom nomfichiermul;
    for k=1 upto nbpts:
      pair latlon;
      latlon=scantokens readfrom nomfichiermul;
      Coord[k]=rayon*(cosd(xpart(latlon))*cosd(ypart(latlon)),cosd(xpart(latlon))*sind(ypart(latlon)),sind(xpart(latlon)));
      if ((xpart(latlon)>phim) and (xpart(latlon)<phip)):
	if ProduitScalaire(Coord[k]-pte3,Oeil-pte3)>0:
	  ll:=ll+1;
	  Pays[k]=Coord[k];
	else:
	  Pays[k]=2*Coord[k];
	fi;
      else:
	Pays[k]=2*Coord[k];
      fi;
    endfor;
    path pays;
    if ll>0:
      pays=Projgeo(Pays[1])
      for l=2 upto nbpts:
	--Projgeo(Pays[l])
      endfor;
      fill pays--cycle withcolor couleurfleuve;
      draw pays;
      clip currentpicture to cercles(pte3,pte1,pte3,pte1,pte4);
    fi;
  endfor;
  closefrom nomfichiermul;
enddef;

vardef Lecturevolcans=
  drawoptions(withcolor orange);
  nomfichiermul:=arborescence&"PfCvolcans.dat";
  nblec:=scantokens readfrom nomfichiermul;
  show nblec;
  for p=1 upto nblec:
    color Coord[],Pays[];
    pair latlon;
    latlon=scantokens readfrom nomfichiermul;
    Coord[p]=rayon*(cosd(xpart(latlon/60))*cosd(ypart(latlon/60)),cosd(xpart(latlon/60))*sind(ypart(latlon/60)),sind(xpart(latlon/60)));
    if ((xpart(latlon/60)>phim) and (xpart(latlon/60)<phip)):
      if ProduitScalaire(Coord[p]-pte3,Oeil-pte3)>0:
	Pays[p]=Coord[p];
	fill flamme shifted Projgeo(Pays[p]) withcolor 1/2[orange,jaune];
      %else:
%	Pays[k]=2*Coord[k];
      fi;
%    else:
%      Pays[k]=2*Coord[k];
    fi;
  endfor;
closefrom nomfichiermul;
drawoptions();
enddef;

vardef Lecturerivieres=
  nomfichiermul:=arborescence&"PfCrivieres.dat";
  nblec:=scantokens readfrom nomfichiermul;
  for p=1 upto nblec:
    color Coord[],fond,Pays[];
    numeric ll;
    ll:=0;
    nbpts:=scantokens readfrom nomfichiermul;
    for k=1 upto nbpts:
      pair latlon;
      latlon=scantokens readfrom nomfichiermul;
      Coord[k]=rayon*(cosd(xpart(latlon/60))*cosd(ypart(latlon/60)),cosd(xpart(latlon/60))*sind(ypart(latlon/60)),sind(xpart(latlon/60)));
      if ((xpart(latlon/60)>phim) and (xpart(latlon/60)<phip)):
	if ProduitScalaire(Coord[k]-pte3,Oeil-pte3)>0:
	  ll:=ll+1;
	  Pays[k]=Coord[k];
	else:
	  Pays[k]=2*Coord[k];
	fi;
      else:
	Pays[k]=2*Coord[k];
      fi;
    endfor;
    path pays;
    if ll>0:
      pays=Projgeo(Pays[1])
      for l=2 upto nbpts:
	--Projgeo(Pays[l])
      endfor;
      draw pays withcolor couleurfleuve;
      clip currentpicture to cercles(pte3,pte1,pte3,pte1,pte4);
    fi;
  endfor;
  closefrom nomfichiermul;
enddef;

vardef Lecturerivieressup=
  nomfichiermul:=arborescence&"PfCfleuveseurope.dat";
  nblec:=scantokens readfrom nomfichiermul;
  for p=1 upto nblec:
    color Coord[],fond,Pays[];
    numeric ll;
    ll:=0;
    nbpts:=scantokens readfrom nomfichiermul;
    for k=1 upto nbpts:
      pair latlon;
      latlon=scantokens readfrom nomfichiermul;
      Coord[k]=rayon*(cosd(xpart(latlon))*cosd(ypart(latlon)),cosd(xpart(latlon))*sind(ypart(latlon)),sind(xpart(latlon)));
      if ((xpart(latlon)>phim) and (xpart(latlon)<phip)):
	if ProduitScalaire(Coord[k]-pte3,Oeil-pte3)>0:
	  ll:=ll+1;
	  Pays[k]=Coord[k];
	else:
	  Pays[k]=2*Coord[k];
	fi;
      else:
	Pays[k]=2*Coord[k];
      fi;
    endfor;
    path pays;
    if ll>0:
      pays=Projgeo(Pays[1])
      for l=2 upto nbpts:
	--Projgeo(Pays[l])
      endfor;
      draw pays withcolor couleurfleuve;
      clip currentpicture to cercles(pte3,pte1,pte3,pte1,pte4);
    fi;
  endfor;
  closefrom nomfichiermul;
enddef;

vardef Lecturecapitales=
  marque_p:="creux";
  nomfichiermul:=arborescence&"PfCcapitales.dat";
  nbcapitales:=scantokens readfrom nomfichiermul;
  for p=1 upto nbcapitales:
    color Coord[];
    pair latlon;
    picture Nom;
    string p_;
    p_=scantokens readfrom nomfichiermul;
    latlon=scantokens readfrom nomfichiermul;
    Coord[p]=rayon*(cosd(xpart(latlon/60))*cosd(ypart(latlon/60)),cosd(xpart(latlon/60))*sind(ypart(latlon/60)),sind(xpart(latlon/60)));
    Nom=image(
      label.top(TEX(""&p_&""),Projgeo(Coord[p]));
      );
    if ((xpart(latlon/60)>phim) and (xpart(latlon/60)<phip)):
      if ProduitScalaire(Coord[p]-pte3,Oeil-pte3)>0:
	pointe(Coord[p]);
	%draw Nom;
      fi;
    fi;
  endfor;
  closefrom nomfichiermul;
  marque_p:="non";
enddef;

vardef Lecture(expr Nomfichier)=
  NomFichier:=arborescence&"PfC"&Nomfichier;
  nblec:=scantokens readfrom NomFichier;
  for w=1 upto nblec:
    if projection="non":
      lecture(scantokens readfrom NomFichier);
    else:
      lecturep(scantokens readfrom NomFichier);
    fi;
  endfor;
  closefrom NomFichier;
enddef;

%Pour les projections
string projection;
projection:="non";

vardef zoom(expr nbzoom)=
  if projection="mercator":
    xunit:=nbzoom;
    yunit:=nbzoom*2*cm;
  elseif projection="cylindrique":
    xunit:=2.5*nbzoom;
    yunit:=nbzoom*10*cm;
  elseif projection="winkel":
    xunit:=nbzoom*0.5*mm;
    yunit:=nbzoom;
  elseif projection="simple":
    xunit:=nbzoom*0.5*mm;
    yunit:=nbzoom*0.5*mm;
  elseif projection="bonne":
    xunit:=nbzoom*4*cm;
    yunit:=xunit;
  fi;
enddef;

vardef mercatorc(expr aa,bb)=
  (xunit*(bb-theta),yunit*(ln(abs(tand(45+(aa/2))))-ln(abs(tand(45+(phi/2))))))
enddef;

vardef coniquec(expr aa,bb,pc)=
  abscon:=5*cm*(cosd(aa)*sind(bb*sind(pc)))/(sind(pc)*cosd(aa-pc));
  ordcon:=5*cm*(cosd(aa)*cosd(bb*sind(pc)))/(sind(pc)*cosd(aa-pc));
  (abscon,ordcon)
enddef;

vardef cylindriquec(expr aa,bb)=
  (xunit*(bb-theta),yunit*(sind(aa)-sind(phi)))
enddef;

vardef simplec(expr aa,bb)=
  (xunit*(bb-theta),yunit*(aa-phi))
enddef;

vardef bonnec(expr aaa,bbb)=
  save tt;
  pair tt;
  rho:=cotand(phi)+(phi-aaa)/c;
  E:=(((bbb-theta)/c)/rho)*cosd(aaa);
  tt=xunit*(rho*sind(E*c),cotand(phi)-rho*cosd(E*c));
  tt
enddef;

vardef winkelc(expr aaa,bbb)=
  save ttw;
  pair ttw;
  alphawinkel:=arccosd(cosd(aaa)*cosd(0.5*bbb));
  if alphawinkel=0:
    xwinkel:=0;
    ywinkel:=0;
  else:
    xwinkel:=xunit*0.5*(bbb*cosd(arccosd(2/pi))+(2*cosd(aaa)*sind(0.5*bbb)/sinc(alphawinkel)));
    ywinkel:=yunit*0.5*(aaa+sind(aaa)/sinc(alphawinkel));
  fi;
  ttw=(xwinkel,ywinkel);
  ttw
enddef;

vardef lecturep(expr nomfichier,fond)=
  pair Coord[];
  nbpts:=scantokens readfrom nomfichier;
  numeric ll;
  ll=0;
  if nbpts<Allegee:
    Alleg:=4;
  else:
    Alleg:=Allegee;
  fi;
%  for k=1 upto nbpts:
  for k=1 upto (nbpts div Alleg):
    pair latlon;
%    latlon=scantokens readfrom nomfichier;
%    latlon=((scantokens readfrom nomfichier)+(scantokens readfrom nomfichier)+(scantokens readfrom nomfichier))/3;
    latlon=((scantokens readfrom nomfichier) for l=2 upto Alleg:
	+(scantokens readfrom nomfichier)
    endfor)/Alleg;
    if projection="mercator":
      Coord[k]=mercatorc(xpart(latlon/60),ypart(latlon/60));
    elseif projection="winkel":
      Coord[k]=winkelc(xpart(latlon/60),ypart(latlon/60));
    elseif projection="cylindrique":
      Coord[k]=cylindriquec(xpart(latlon/60),ypart(latlon/60));
    elseif projection="simple":
      Coord[k]=simplec(xpart(latlon/60),ypart(latlon/60));
    elseif projection="bonne":
      Coord[k]=bonnec(xpart(latlon/60),ypart(latlon/60));
    elseif projection="coniqueh":
      if (xpart(latlon)>0) or (xpart(latlon)=0):
	ll:=ll+1;
	Coord[ll]=coniquec(xpart(latlon/60),ypart(latlon/60),45);
      fi;
    elseif projection="coniqueb":
      if (xpart(latlon)<0):
	ll:=ll+1;
	Coord[ll]=coniquec(xpart(latlon/60),ypart(latlon/60),-45);
      fi;
    fi;
  endfor;
  closefrom nomfichier;
  path pays;
  if (projection="mercator") or (projection="winkel") or(projection="cylindrique") or (projection="simple") or (projection="bonne"):
    ll:=nbpts
  fi;
  if ll>0:
    pays=Coord[1]
%    for l=4 step 3 until ll:%upto ll:4-3
      for l=2 upto (nbpts div Alleg):
      --Coord[l]
    endfor;
    if noncolore=true:
      if Impression=false:
	fill pays--cycle withcolor payscolor;
      fi;
    else:
      fill pays--cycle withcolor fond;
    fi;
    draw pays;
  fi;
enddef;

vardef Lectureilesp=
  if (projection="mercator") or (projection="winkel") or (projection="cylindrique") or (projection="simple") or (projection="bonne"):
    nomfichiermul:=arborescence&"PfCIle.dat";
  else:
    nomfichiermul:=arborescence&"PfCiles.dat";
  fi;
  nblec:=scantokens readfrom nomfichiermul;
  if projection="bonne":
    nblec:=nblec-1
  fi;
  for p=1 upto nblec:
    pair Coord[];color fond;
    nbpts:=scantokens readfrom nomfichiermul;
    fond=scantokens readfrom nomfichiermul;
    numeric ll;
    ll=0;
%%%%%%%%%%%%
    if nbpts<Allegee:
      Alleg:=1;
    else:
      Alleg:=Allegee;
    fi;
    %%%%%%%%
%    for k=1 upto nbpts:
    for k=1 upto (nbpts div Alleg):
      pair latlon;
%      latlon=scantokens readfrom nomfichiermul;
      latlon=((scantokens readfrom nomfichiermul) for l=2 upto Alleg:
	  +(scantokens readfrom nomfichiermul)
      endfor)/Alleg;
      if projection="mercator":
	Coord[k]=mercatorc(xpart(latlon/60),ypart(latlon/60));
      elseif projection="winkel":
	Coord[k]=winkelc(xpart(latlon/60),ypart(latlon/60));
      elseif projection="simple":
	Coord[k]=simplec(xpart(latlon/60),ypart(latlon/60));
      elseif projection="cylindrique":
	Coord[k]=cylindriquec(xpart(latlon/60),ypart(latlon/60));
      elseif projection="bonne":
	Coord[k]=bonnec(xpart(latlon/60),ypart(latlon/60));
      elseif projection="coniqueh":
	if (xpart(latlon)>0) or (xpart(latlon)=0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon/60),ypart(latlon/60),45)
	fi;
      elseif projection="coniqueb":
	if (xpart(latlon)<0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon/60),ypart(latlon/60),-45);
	fi;
      fi;
    endfor;
    path pays;
    if (projection="mercator") or (projection="winkel") or (projection="cylindrique") or (projection="simple") or (projection="bonne"):
      ll:=(nbpts div Alleg)
    fi;
    if ll>0:
      pays=Coord[1]
%      for l=2 upto ll:
	for l=2 upto (nbpts div Alleg):
	--Coord[l]
     endfor;
      if noncolore=true:
	fill pays--cycle withcolor payscolor;
      else:
	fill pays--cycle withcolor fond;
      fi;
      draw pays;
    fi;
    % rustine pour tout lire chaque partie de Ile.dat
    if Alleg>1:
      for po=1 upto (nbpts mod Alleg):
	poubelle:=scantokens readfrom nomfichiermul;
      endfor;
    fi;
  endfor;
  closefrom nomfichiermul;
  if (projection="mercator") or (projection="winkel") or (projection="cylindrique") or (projection="simple"):
    clip currentpicture to feuillet;
  fi;
  if projection="bonne":
    lecturep(arborescence&"PfCpolesud.dat",blanc);
    clip currentpicture to (bonnec(-90,-180) for k=-89 upto 90:..bonnec(k,-180) endfor)..reverse(bonnec(-90,180) for k=-89 upto 90:..bonnec(k,180) endfor)..cycle;
  fi;
enddef;

%14/05/2017
boolean ecriturevilles;
ecriturevilles:=true;
%14/05/2017

vardef Lecturevillesp(expr nompays)=
  nomfichiermul:=arborescence&"PfCvilles"&nompays&".dat";
  nblec:=scantokens readfrom nomfichiermul;
  drawoptions(withcolor (0.15,0.15,0.15)); 
  for p=1 upto nblec:
    pair Coord[],latlon;string p_;
    latlon=scantokens readfrom nomfichiermul;
    p_=scantokens readfrom nomfichiermul;
    if projection="mercator":
      Coord[p]=mercatorc(ypart(latlon),xpart(latlon));
    elseif projection="winkel":
      Coord[p]=winkelcc(ypart(latlon),xpart(latlon));
    elseif projection="simple":
      Coord[p]=simplec(ypart(latlon),xpart(latlon));
    elseif projection="cylindrique":
      Coord[p]=cylindriquec(ypart(latlon),xpart(latlon));
    elseif projection="bonne":
	Coord[p]=bonnec(ypart(latlon),xpart(latlon));
    fi;
    if (projection="mercator") or (projection="winkel") or (projection="cylindrique") or (projection="simple") or (projection="bonne"):
      if ecriturevilles=true:
	dotlabel.scantokens readfrom nomfichiermul(TEX(""&p_&""),Coord[p]);
      else:
	dotlabel.scantokens readfrom nomfichiermul("",Coord[p]);
      fi;
    fi;
  endfor;
  drawoptions();
  closefrom nomfichiermul;
enddef;

%16/02/2010

vardef Lecturevilles(expr nomfich)=
marque_p:="creux";
  nomfichiermul:=nomfich&".dat";
  nbcapitales:=scantokens readfrom nomfichiermul;
  for p=1 upto nbcapitales:
    color Coord[];
    pair latlon;
    picture Nom;
    string p_;
    p_=scantokens readfrom nomfichiermul;
    latlon=scantokens readfrom nomfichiermul;
    Coord[p]=rayon*(cosd(xpart(latlon/60))*cosd(ypart(latlon/60)),cosd(xpart(latlon/60))*sind(ypart(latlon/60)),sind(xpart(latlon/60)));
    Nom=image(
      label.scantokens readfrom nomfichiermul(TEX(""&p_&""),Projgeo(Coord[p]));
      );
    if ((xpart(latlon/60)>phim) and (xpart(latlon/60)<phip)):
      if ProduitScalaire(Coord[p]-pte3,Oeil-pte3)>0:
	pointe(Coord[p]);
	draw Nom;
      fi;
    fi;
  endfor;
  closefrom nomfichiermul;
  marque_p:="non";
enddef;
%


vardef Lecturelacsp=
  nomfichiermul:=arborescence&"PfClacs.dat";
  nblec:=scantokens readfrom nomfichiermul;
  for p=1 upto nblec:
    pair Coord[];
    nbpts:=scantokens readfrom nomfichiermul;
    numeric ll;
    ll=0;
    for k=1 upto nbpts:
      pair latlon;
      latlon=scantokens readfrom nomfichiermul;
      if projection="mercator":
	Coord[k]=mercatorc(xpart(latlon/60),ypart(latlon/60));
      elseif projection="winkel":
	Coord[k]=winkelc(xpart(latlon/60),ypart(latlon/60));
      elseif projection="simple":
	Coord[k]=simplec(xpart(latlon/60),ypart(latlon/60));
      elseif projection="cylindrique":
	Coord[k]=cylindriquec(xpart(latlon/60),ypart(latlon/60));
      elseif projection="bonne":
	Coord[k]=bonnec(xpart(latlon/60),ypart(latlon/60));
      elseif projection="coniqueh":
	if (xpart(latlon)>0) or (xpart(latlon)=0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon/60),ypart(latlon/60),45);
	fi;
      elseif projection="coniqueb":
	if (xpart(latlon)<0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon/60),ypart(latlon/60),-45);
	fi;
      fi;
    endfor;
    path lac;
    if (projection="mercator") or (projection="winkelc") or (projection="cylindrique") or (projection="simple") or (projection="bonne"):
      ll:=nbpts
    fi;
    if ll>0:
      lac=Coord[1]
      for l=2 upto ll:
	--Coord[l]
      endfor;
      fill lac--cycle withcolor couleurfleuve;
      draw lac;
    fi;
  endfor;
  closefrom nomfichiermul;
enddef;

vardef Lecturelacspsup=
  nomfichiermul:=arborescence&"PfClacssup.dat";
  nblec:=scantokens readfrom nomfichiermul;
  for p=1 upto nblec:
    pair Coord[];
    nbpts:=scantokens readfrom nomfichiermul;
    numeric ll;
    ll=0;
    for k=1 upto nbpts:
      pair latlon;
      latlon=scantokens readfrom nomfichiermul;
      if projection="mercator":
	Coord[k]=mercatorc(xpart(latlon),ypart(latlon));
      elseif projection="winkel":
	Coord[k]=winkelc(xpart(latlon),ypart(latlon));
      elseif projection="simple":
	Coord[k]=simplec(xpart(latlon),ypart(latlon));
      elseif projection="cylindrique":
	Coord[k]=cylindriquec(xpart(latlon),ypart(latlon));
      elseif projection="bonne":
	Coord[k]=bonnec(xpart(latlon),ypart(latlon));
      elseif projection="coniqueh":
	if (xpart(latlon)>0) or (xpart(latlon)=0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon),ypart(latlon),45);
	fi;
      elseif projection="coniqueb":
	if (xpart(latlon)<0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon),ypart(latlon),-45);
	fi;
      fi;
    endfor;
    path lac;
    if (projection="mercator") or (projection="winkel") or (projection="cylindrique") or (projection="simple") or (projection="bonne"):
      ll:=nbpts
    fi;
    if ll>0:
      lac=Coord[1]
      for l=2 upto ll:
	--Coord[l]
      endfor;
      fill lac--cycle withcolor couleurfleuve;
      draw lac;
    fi;
  endfor;
  closefrom nomfichiermul;
enddef;

vardef Lecturerivieresp=
  nomfichiermul:=arborescence&"PfCrivieres.dat";
  nblec:=scantokens readfrom nomfichiermul;
  for p=1 upto nblec:
    pair Coord[];
    nbpts:=scantokens readfrom nomfichiermul;
    numeric ll;
    ll:=0;
    for k=1 upto nbpts:
      pair latlon;
      latlon=scantokens readfrom nomfichiermul;
      if projection="mercator":
	Coord[k]=mercatorc(xpart(latlon/60),ypart(latlon/60));
      elseif projection="winkel":
	Coord[k]=winkelc(xpart(latlon/60),ypart(latlon/60));
      elseif projection="simple":
	Coord[k]=simplec(xpart(latlon/60),ypart(latlon/60));
      elseif projection="cylindrique":
	Coord[k]=cylindriquec(xpart(latlon/60),ypart(latlon/60));
      elseif projection="bonne":
	Coord[k]=bonnec(xpart(latlon/60),ypart(latlon/60));
      elseif projection="coniqueh":
	if (xpart(latlon)>0) or (xpart(latlon)=0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon/60),ypart(latlon/60),45);
	fi;
      elseif projection="coniqueb":
	if (xpart(latlon)<0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon/60),ypart(latlon/60),-45);
	fi;
      fi;
    endfor;
    path riv;
    if (projection="mercator") or (projection="winkel") or (projection="cylindrique") or (projection="simple") or (projection="bonne"):
      ll:=nbpts;
    fi;
    if ll>0:
      riv=Coord[1]
      for l=2 upto ll:
	--Coord[l]
      endfor;
      draw riv withcolor couleurfleuve;
    fi;
  endfor;
  closefrom nomfichiermul;
enddef;

vardef Lecturerivierespsup=
  nomfichiermul:=arborescence&"PfCfleuveseurope.dat";
  nblec:=scantokens readfrom nomfichiermul;
  for p=1 upto nblec:
    pair Coord[];
    nbpts:=scantokens readfrom nomfichiermul;
    numeric ll;
    ll:=0;
    for k=1 upto nbpts:
      pair latlon;
      latlon=scantokens readfrom nomfichiermul;
      if projection="mercator":
	Coord[k]=mercatorc(xpart(latlon),ypart(latlon));
      elseif projection="winkel":
	Coord[k]=winkelc(xpart(latlon),ypart(latlon));
      elseif projection="simple":
	Coord[k]=simplec(xpart(latlon),ypart(latlon));
      elseif projection="cylindrique":
	Coord[k]=cylindriquec(xpart(latlon),ypart(latlon));
      elseif projection="bonne":
	Coord[k]=bonnec(xpart(latlon),ypart(latlon));
      elseif projection="coniqueh":
	if (xpart(latlon)>0) or (xpart(latlon)=0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon),ypart(latlon),45);
	fi;
      elseif projection="coniqueb":
	if (xpart(latlon)<0):
	  ll:=ll+1;
	  Coord[ll]=coniquec(xpart(latlon),ypart(latlon),-45);
	fi;
      fi;
    endfor;
    path riv;
    if (projection="mercator") or (projection="winkel") or (projection="cylindrique") or (projection="simple") or (projection="bonne"):
      ll:=nbpts;
    fi;
    if ll>0:
      riv=Coord[1]
      for l=2 upto ll:
	--Coord[l]
      endfor;
      draw riv withcolor couleurfleuve;
    fi;
  endfor;
  closefrom nomfichiermul;
enddef;

vardef Lecturecapitalesp=
  marque_p:="creux";
  nomfichiermul:=arborescence&"PfCcapitales.dat";
  nbcapitales:=scantokens readfrom nomfichiermul;
  for p=1 upto nbcapitales:
    pair Coord[],latlon;
    string p_;
    p_=scantokens readfrom nomfichiermul;
    latlon=scantokens readfrom nomfichiermul;
    ll:=0;
    if projection="mercator":
      Coord[p]=mercatorc(xpart(latlon/60),ypart(latlon/60));
      ll:=1;
    elseif projection="winkel":
      Coord[p]=winkelc(xpart(latlon/60),ypart(latlon/60));
      ll:=1;
    elseif projection="simple":
      Coord[p]=simplec(xpart(latlon/60),ypart(latlon/60));
      ll:=1;
    elseif projection="cylindrique":
      Coord[p]=cylindriquec(xpart(latlon/60),ypart(latlon/60));
      ll:=1;
    elseif projection="bonne":
      Coord[p]=bonnec(xpart(latlon/60),ypart(latlon/60));
      ll:=1;
    elseif projection="coniqueh":
      if (xpart(latlon)>0) or (xpart(latlon)=0):
	ll:=1;
	Coord[p]=coniquec(xpart(latlon/60),ypart(latlon/60),45);
      fi;
    elseif projection="coniqueb":
      if (xpart(latlon)<0):
	ll:=1;
	Coord[p]=coniquec(xpart(latlon/60),ypart(latlon/60),-45);
      fi;
    fi;
    if ll>0:
      drawoptions(withcolor rouge);
      pointe(Coord[p]);
      drawoptions();
      if (projection="mercator") or (projection="winkel") or (projection="cylindrique") or (projection="simple") or (projection="bonne"):
	label.top(TEX(""&p_&""),Coord[p]);
      fi;
    fi;
  endfor;
  closefrom nomfichiermul;
  marque_p:="non";
enddef;

vardef MeridienParallele=
  if (projection="mercator") or (projection="winkel") or (projection="cylindrique") or (projection="simple"):
    pair Coord[];
    for k=-85 step 5 until 85:
  for j=-180 step 10 until 180:
	if projection="mercator":
	  Coord[100*k+j]=mercatorc(k,j);
	elseif projection="winkel":
	Coord[100*k+j] = winkelc(k,j);
	elseif projection="simple":
	  Coord[100*k+j]=simplec(k,j);
	elseif projection="cylindrique":
	  Coord[100*k+j]=cylindriquec(k,j);
	fi;
      endfor;
    endfor;
    for k=-85 step 5 until 85:
      draw Coord[100*k-180]
	for j=-170 step 10 until 180:
	--Coord[100*k+j]
     endfor;
    endfor;
    pair Coord[];
    for k=-180 step 10 until 180:
      for j=-85 step 5 until 85:
	if projection="mercator":
	  Coord[0.001*k+10*j]=mercatorc(j,k);
	elseif projection="winkel":
	  Coord[0.001*k+10*j]=winkelc(j,k);
	elseif projection="simple":
	  Coord[0.001*k+10*j]=simplec(j,k);
	elseif projection="cylindrique":
	  Coord[0.001*k+10*j]=cylindriquec(j,k);
	fi;
      endfor;
    endfor;
    for k=-180 step 10 until 180:
      draw Coord[0.001*k-10*85]
	for j=-80 step 5 until 85:
	--Coord[0.001*k+10*j]
      endfor;
    endfor;
  elseif projection="bonne":
    pair Coord[][];
    for k=-90 step 10 until 90:
      for j=-180 step 10 until 180:
	Coord[k][j]=bonnec(k,j);
      endfor;
    endfor;
    for k=-90 step 10 until 90:
      draw Coord[k][-180]
      for j=-170 step 10 until 180:
	--Coord[k][j]
      endfor;
    endfor;
    pair Coord[][];
    for k=-170 step 10 until 170:
      for j=-90 step 10 until 90:
	Coord[k][j]=bonnec(j,k);
      endfor;
    endfor;
    for k=-170 step 10 until 170:
      draw Coord[k][-90]
      for j=-80 step 10 until 90:
	..Coord[k][j]
      endfor;
    endfor;
  elseif projection="coniqueh":
    pair Coord[];
    for k=-180 step 10 until 180:
      for j=0 step 10 until 90:
	Coord[100*k+j]=coniquec(j,k,45);
      endfor;
    endfor;
    for k=-180 step 10 until 180:
      draw Coord[100*k]
      for j=10 step 10 until 90:
	--Coord[100*k+j]
      endfor;
    endfor;
    pair Coord[];
    for k=0 step 10 until 90:
      for j=-180 step 10 until 180:
	Coord[0.001*k+10*j]=coniquec(k,j,45);
      endfor;
    endfor;
    for k=0 step 10 until 90:
      draw Coord[0.001*k-10*180]
      for j=-170 step 10 until 180:
	--Coord[0.001*k+10*j]
      endfor;
    endfor;
    clip currentpicture to coniquec(90,0,45)--(Coord[-10*180]
      for j=-170 step 10 until 180:
	--Coord[10*j]
      endfor)--cycle;
  elseif projection="coniqueb":
    pair Coord[];
    for k=-180 step 10 until 180:
      for j=-90 step 10 until 0:
	Coord[100*k+j]=coniquec(j,k,-45);
      endfor;
    endfor;
    for k=-180 step 10 until 180:
      draw Coord[100*k-90]
      for j=-80 step 10 until 0:
	--Coord[100*k+j]
      endfor;
    endfor;
    pair Coord[];
    for k=-90 step 10 until 0:
      for j=-180 step 10 until 180:
	Coord[0.001*k+10*j]=coniquec(k,j,-45);
      endfor;
    endfor;
    for k=-90 step 10 until 0:
      draw Coord[0.001*k-10*180]
      for j=-170 step 10 until 180:
	--Coord[0.001*k+10*j]
      endfor;
    endfor;
    clip currentpicture to coniquec(-90,0,-45)--(Coord[-10*180]
      for j=-170 step 10 until 180:
	--Coord[10*j]
      endfor)--cycle;
  fi;
enddef;

boolean Echelle;
Echelle=false;

vardef echelle(expr Th,Ph,long)=%long en km.
  %Echelle:=true;
  theta:=Th;
  phi:=Ph;
  Long:=long;
  zoom(1);
  numeric $;
  if projection="bonne":
    $=(cm*pi*cosd(Ph)/36)/(long*abs(bonnec(Ph,Th)-bonnec(Ph,Th+5)))*6340;
  elseif projection="mercator":
    $=(cm*pi*cosd(Ph)*6340/36)/(long*abs(mercatorc(Ph,Th)-mercatorc(Ph,Th+5)));
    elseif projection="winkel":
    $=(cm*pi*cosd(Ph)*6340/36)/(long*abs(winkelc(Ph,Th)-winkelc(Ph,Th+5)));
  elseif projection="simple":
    $=(cm*pi*cosd(Ph)*6340/36)/(long*abs(simplec(Ph,Th)-simplec(Ph,Th+5)));
  elseif projection="cylindrique":
    $=(cm*pi*cosd(Ph)*6340/36)/(long*abs(cylindriquec(Ph,Th)-cylindriquec(Ph,Th+5)));
  fi;
  $
enddef;

boolean Amsud,Amnord,Amcentrale,Caraibes,Asie,Europe,Afrique,All;

Amsud:=false;
Amnord:=false;
Amcentrale:=false;
Caraibes:=false;
Asie:=false;
Europe:=false;
Afrique:=false;
All:=true;

vardef Projection(expr TH,PH,Zoom)=
  theta:=TH;
  phi:=PH;
  zoom(Zoom);
  if projection="bonne":
    fill (bonnec(-90,-180) for k=-85 step 5 until 90:..bonnec(k,-180) endfor)..reverse(bonnec(-90,180) for k=-85 step 5 until 90:..bonnec(k,180) endfor)..cycle withcolor couleurfond;
  fi;
  if All=true:
    Lecture("Cameriquesud.dat");
    Lecture("Ccaraibes.dat");
    Lecture("Cameriquecentrale.dat");
    Lecture("Cameriquenord.dat");
    Lecture("Casia.dat");
    Lecture("Ceurope.dat");
    Lecture("Cafrique.dat");
  else:
    if Amsud=true:
      Lecture("Cameriquesud.dat");
    fi;
    if Amnord=true:
      Lecture("Cameriquenord.dat");
    fi;
    if Amcentrale=true:
      Lecture("Cameriquecentrale.dat");
    fi;
    if Caraibes=true:
      Lecture("Ccaraibes.dat");
    fi;
    if Asie=true:
      if projection="bonne":
	Lecture("Casie.dat");
      else:
	Lecture("Casia.dat");
      fi;
    fi;
    if Europe=true:
      Lecture("Ceurope.dat");
    fi;
    if Afrique=true:
      Lecture("Cafrique.dat");
    fi;
  fi;
  if lacs=true:
    Lecturelacsp;
    Lecturelacspsup;
  fi;
  Lectureilesp;
  if capitales=true:
    Lecturecapitalesp;
  fi;
  if fleuves=true:
    Lecturerivieresp;
    Lecturerivierespsup;
  fi;
  if maillage=true:
    drawoptions(withcolor gris);
    MeridienParallele;
    drawoptions();
  fi;
  if Echelle=true:
    draw ((Xa,Ya)+u*(1,1))--((Xa,Ya)+u*(2,1));
    labeloffset:=labeloffset*1.5;
    label.top(btex 0 etex,(Xa,Ya)+u*(1,1));
    label.top(TEX(""&decimal(Long)&"~km"),(Xa,Ya)+u*(2,1));
    labeloffset:=labeloffset/1.5;
    draw ((Xa,Ya)+u*(1,1.1))--((Xa,Ya)+u*(1,0.9));
    draw (((Xa,Ya)+u*(1,1.1))--((Xa,Ya)+u*(1,0.9))) shifted(u*(1,0));
  fi;
enddef;

vardef Simple(expr TH,PH,Zoom)=
  projection:="simple";
  theta:=TH;
  phi:=PH;
  zoom(Zoom);
  Lecture("Cameriquesud.dat");
  Lecture("Ccaraibes.dat");
  Lecture("Cameriquecentrale.dat");
  Lecture("Cameriquenord.dat");
  Lecture("Casia.dat");
  Lecture("Ceurope.dat");
  Lecture("Cafrique.dat");
  if lacs=true:
    Lecturelacsp;
    Lecturelacspsup;
  fi;
  Lectureilesp;
  if capitales=true:
    Lecturecapitalesp;
  fi;
  if fleuves=true:
    Lecturerivieresp;
   fi;
  if maillage=true:
    MeridienParallele
  fi;
enddef;

vardef Mercator(expr TH,PH,Zoom)=
  projection:="mercator";
  theta:=TH;
  phi:=PH;
  zoom(Zoom);
  Lecture("Cameriquesud.dat");
  Lecture("Ccaraibes.dat");
  Lecture("Cameriquecentrale.dat");
  Lecture("Cameriquenord.dat");
  Lecture("Casia.dat");
  Lecture("Ceurope.dat");
  Lecture("Cafrique.dat");
  if lacs=true:
    Lecturelacsp;
    Lecturelacspsup;
  fi;
  Lectureilesp;
  if capitales=true:
    Lecturecapitalesp;
  fi;
  if fleuves=true:
    Lecturerivieresp;
  fi;
  if maillage=true:
    MeridienParallele
  fi;
enddef;

vardef Winkel(expr TH,PH,Zoom)=
  projection:="winkel";
  theta:=TH;
  phi:=PH;
  zoom(Zoom);
  Lecture("Cameriquesud.dat");
  Lecture("Ccaraibes.dat");
  Lecture("Cameriquecentrale.dat");
  Lecture("Cameriquenord.dat");
  Lecture("Casia.dat");
  Lecture("Ceurope.dat");
  Lecture("Cafrique.dat");
  if lacs=true:
    Lecturelacsp;
    Lecturelacspsup;
  fi;
  Lectureilesp;
  if capitales=true:
    Lecturecapitalesp;
  fi;
  if fleuves=true:
    Lecturerivieresp;
  fi;
  if maillage=true:
    MeridienParallele;
  fi;
enddef;

vardef Cylindrique(expr TH,PH,Zoom)=
  projection:="cylindrique";
  theta:=TH;
  phi:=PH;
  zoom(Zoom);
  Lecture("Cameriquesud.dat");
  Lecture("Ccaraibes.dat");
  Lecture("Cameriquecentrale.dat");
  Lecture("Cameriquenord.dat");
  Lecture("Casia.dat");
  Lecture("Ceurope.dat");
  Lecture("Cafrique.dat");
  if lacs=true:
    Lecturelacsp;
    Lecturelacspsup;
  fi;
  Lectureilesp;
  if capitales=true:
    Lecturecapitalesp;
  fi;
  if fleuves=true:
    Lecturerivieresp;
  fi;
  if maillage=true:
    MeridienParallele
  fi;
enddef;

vardef Bonne(expr TH,PH,Zoom)=
  projection:="bonne";
  theta:=TH;
  phi:=PH;
  zoom(Zoom);
  fill (bonnec(-90,-180) for k=-85 step 5 until 90:..bonnec(k,-180) endfor)..reverse(bonnec(-90,180) for k=-85 step 5 until 90:..bonnec(k,180) endfor)..cycle withcolor couleurfond;
  Lecture("Cameriquesud.dat");
  Lecture("Ccaraibes.dat");
  Lecture("Cameriquecentrale.dat");
  Lecture("Cameriquenord.dat");
  Lecture("Casie.dat");
  Lecture("Ceurope.dat");
  Lecture("Cafrique.dat");
  if lacs=true:
    Lecturelacsp;
    Lecturelacspsup;
  fi;
  Lectureilesp;
  if capitales=true:
    Lecturecapitalesp;
  fi;
  if fleuves=true:
    Lecturerivieresp;
  fi;
  if maillage=true:
    drawoptions(withcolor gris);
    MeridienParallele;
    drawoptions();
  fi;
  draw (bonnec(-90,-180) for k=-85 step 5 until 90:..bonnec(k,-180) endfor)..reverse(bonnec(-90,180) for k=-85 step 5 until 90:..bonnec(k,180) endfor)..cycle;
enddef;

vardef ConiqueH=
  projection:="coniqueh";
  Lecture("Cameriquesud.dat");
  Lecture("Ccaraibes.dat");
  Lecture("Cameriquecentrale.dat");
  Lecture("Cameriquenord.dat");
  Lecture("Casie.dat");
  Lecture("Ceurope.dat");
  Lecture("Cafrique.dat");
  if lacs=true:
    Lecturelacsp;
    Lecturelacspsup;
  fi;
  Lectureilesp;
  if capitales=true:
    Lecturecapitalesp;
  fi;
  if fleuves=true:
    Lecturerivieresp;
    Lecturerivierespsup;
  fi;
  drawoptions(withcolor gris);
  MeridienParallele;
  drawoptions();
enddef;

vardef ConiqueB=
  projection:="coniqueb";
  Lecture("Cameriquesud.dat");
  Lecture("Ccaraibes.dat");
  Lecture("Cameriquecentrale.dat");
  Lecture("Cameriquenord.dat");
  Lecture("Casie.dat");
  Lecture("Ceurope.dat");
  Lecture("Cafrique.dat");
  if lacs=true:
    Lecturelacsp;
    Lecturelacspsup;
  fi;
  Lectureilesp;
  if capitales=true:
    Lecturecapitalesp;
  fi;
  if fleuves=true:
    Lecturerivieresp;
    Lecturerivierespsup;
  fi;
  drawoptions(withcolor gris);
  MeridienParallele;
  drawoptions();
enddef;

%%%%%%%

rayon:=2;

boolean fleuves,lacs,capitales,noncolore,maillage,volcans;
fleuves=true;
lacs=true;
capitales=true;
noncolore=false;
maillage=false;
volcans=false;

color couleurfond,couleurmaillage,couleurfleuve;
couleurfond:=ciel;
couleurmaillage:=gris;
couleurfleuve:=cielfonce;

vardef Mappemonde(expr longobs,latobs)=
  projection:="non";
  %figureespace(-100u,-100u,100u,100u);
  Initialisation(5,longobs,latobs,distanceecran);
  numeric phim,phip,phii;%phi moins -- phi plus - phi intermédiaire
  phim=Phi+arcsind(rayon/Rho)-90;
  phip=Phi+90-arcsind(rayon/Rho);
  color pte[];
  pte1=rayon*(cosd(phim)*cosd(Theta),cosd(phim)*sind(Theta),sind(phim));
  pte2=rayon*(cosd(phip)*cosd(Theta),cosd(phip)*sind(Theta),sind(phip));
  pte3=1/2[pte1,pte2];
  pte4-pte3=Normal((0,0,0),pte1,pte2);
  if (Phi>90):
    phip:=180-phip;
    phii:=180-phim;
    phim:=phip;
    phip:=phii;
  fi;
  if (Phi<-90):
    phip:=-180-phip;
    phii:=-180-phim;
    phim:=phip;
    phip:=phii;
  fi;
  fill cercles(pte3,pte1,pte3,pte1,pte4) withcolor couleurfond;
%  Lecture("Cameriquesud.dat");
%  Lecture("Ccaraibes.dat");
%  Lecture("Cameriquecentrale.dat");
%  Lecture("Cameriquenord.dat");
%  Lecture("Casie.dat");
%  Lecture("Ceurope.dat");
%  Lecture("Cafrique.dat");
  if volcans=true:
%    Lecturevolcans;
  fi;
  if lacs=true:
%    Lecturelacs;
%    Lecturelacssup;
  fi;
%  Lectureiles;
  if capitales=true:
%    Lecturecapitales;
  fi;
  if fleuves=true:
%    Lecturerivieres;
%    %Lecturerivieressup;
  fi;
  if maillage=true:
    drawoptions(withcolor couleurmaillage);
    MaillageSphere;
    drawoptions();
  fi;
  if maille=true:
    Maille;
  fi;
  draw cercles(pte3,pte1,pte3,pte1,pte4);
  %finespace;
enddef;

vardef mappemonde(expr longobs,latobs)=
  projection:="non";
  %figureespace(-100u,-100u,100u,100u);
  Initialisation(5,longobs,latobs,distanceecran);
  numeric phim,phip,phii;%phi moins -- phi plus - phi intermédiaire
  phim=Phi+arcsind(rayon/Rho)-90;
  phip=Phi+90-arcsind(rayon/Rho);
  color pte[];
  pte1=rayon*(cosd(phim)*cosd(Theta),cosd(phim)*sind(Theta),sind(phim));
  pte2=rayon*(cosd(phip)*cosd(Theta),cosd(phip)*sind(Theta),sind(phip));
  pte3=1/2[pte1,pte2];
  pte4-pte3=Normal((0,0,0),pte1,pte2);
  if (Phi>90):
    phip:=180-phip;
    phii:=180-phim;
    phim:=phip;
    phip:=phii;
  fi;
  if (Phi<-90):
    phip:=-180-phip;
    phii:=-180-phim;
    phim:=phip;
    phip:=phii;
  fi;
  fill cercles(pte3,pte1,pte3,pte1,pte4) withcolor couleurfond;
  Lecture("Cameriquesud.dat");
  Lecture("Ccaraibes.dat");
  Lecture("Cameriquecentrale.dat");
  Lecture("Cameriquenord.dat");
  Lecture("Casie.dat");
  Lecture("Ceurope.dat");
  Lecture("Cafrique.dat");
  if volcans=true:
    Lecturevolcans;
  fi;
  if lacs=true:
    Lecturelacs;
    Lecturelacssup;
  fi;
  Lectureiles;
  if capitales=true:
    Lecturecapitales;
  fi;
  if fleuves=true:
    Lecturerivieres;
    %Lecturerivieressup;
  fi;
  if maillage=true:
    drawoptions(withcolor couleurmaillage);
    MaillageSphere;
    drawoptions();
  fi;
  if maillagecoord=true:
    drawoptions(withpen pencircle scaled 0.25 withcolor couleurmaillage);
    MaillageSphereCoord;
    drawoptions();
  fi;
  if maille=true:
    Maille;
  fi;
  draw cercles(pte3,pte1,pte3,pte1,pte4);
%  finespace;
enddef;

endinput;
