%===============================================
%% PfC-Geometrie
%% christophe.poulain@melusine.eu.org
%%===============================================
%------------------------------------------------
% Appel fichier
%------------------------------------------------
%input PfC-Constantes;
%------------------------------------------------
% La figure (debut et fin) JMS/CP
%------------------------------------------------
path feuillet;
numeric _tfig,_nfig;
_tfig:=5cm;
_nfig:=0;
pair coinbg,coinbd,coinhd,coinhg;

string typetrace;
typetrace="normal";

def feuille(expr xa,ya,xb,yb) =
  feuillet := (xa,ya)--(xa,yb)--(xb,yb)--(xb,ya)--cycle;
  coinbg := (xa,ya);
  coinbd := (xb,ya);
  coinhd := (xb,yb);
  coinhg := (xa,yb);
  %modifie le 29.09.04
  z.so=(xpart(coinbg/1cm),ypart(coinbg/1cm));
  z.ne=(xpart(coinhd/1cm),ypart(coinhd/1cm));
  %fin modification
  extra_endfig := "clip currentpicture to feuillet;" & extra_endfig;
enddef;

def Figure(expr xa,ya,xb,yb) =
  feuille(xa,ya,xb,yb);
  _tfig:= if (xb-xa)>(yb-ya): xb-xa else: yb-ya fi;
  _tfig:=2*_tfig;
enddef;

%%-----------------------------------------------
%% Les marques (JMS)
%%-----------------------------------------------
string marque_p;
marque_p := "non";
marque_r := 20;
marque_a := 20;
marque_s := 5;
marque_ang := 10;
m_c := 10 ;%Pour la croix du marquage des points

%------------------------------------------------
% Les tables
%------------------------------------------------
numeric _tn;
_tn:=0;
pair _t[];
color _T[];

%%-----------------------------------------------
%% Procedures d'affichage
%%-----------------------------------------------
def MarquePoint(expr p)=
  if typetrace="3D":
    %JMS
    if marque_p = "plein":
      fill fullcircle scaled (marque_r/5) shifted Projette(p);
    elseif marque_p = "creux":
      fill fullcircle scaled (marque_r/5) shifted (Projette(p)) withcolor white;
      draw fullcircle scaled (marque_r/5) shifted (Projette(p));
        %fin JMS
    elseif marque_p = "croix":
      draw (Projette(p) shifted (-u/10,u/10))--(Projette(p) shifted (u/10,-u/10));
      draw (Projette(p) shifted (-u/10,-u/10))--(Projette(p) shifted (u/10,u/10));
    elseif marque_p = "tiretv":
      draw (Projette(p) shifted (0,u/10))--(Projette(p) shifted(0,-u/10));
    elseif marque_p = "tireth":
      draw (Projette(p) shifted (u/10,0))--(Projette(p) shifted(-u/10,0));
    fi;
  else:
    if marque_p = "plein":
      fill fullcircle scaled (marque_r/5) shifted p;
    elseif marque_p = "creux":
      fill fullcircle scaled (marque_r/5) shifted p withcolor white;
      draw fullcircle scaled (marque_r/5) shifted p;
    elseif marque_p = "croix":
      draw (p shifted (-u/m_c,u/m_c))--(p shifted (u/m_c,-u/m_c));
      draw (p shifted (-u/m_c,-u/m_c))--(p shifted (u/m_c,u/m_c));
    elseif marque_p = "tiretv":
      draw (p shifted (0,u/10))--(p shifted(0,-u/10));
    elseif marque_p = "tireth":
      draw (p shifted (u/10,0))--(p shifted(-u/10,0));
    fi;
  fi;
enddef;

vardef pointe(text t) =
  for p_ = t: if (pair p_) or (color p_): MarquePoint(p_); fi endfor;
enddef;

%------------------------------------------------
% Points
%------------------------------------------------
%JMS
vardef iso(text t) =
  save s,n; numeric n;
  if typetrace="3D":
    color s; s := (0,0,0) ; n := 0;
    for p_ = t: s := s + p_; n := n + 1 ; endfor;
  else:
    pair s; s := (0,0) ; n := 0;
    for p_ = t: s := s + p_; n := n + 1 ; endfor;
  fi;
  if n>0: (1/n)*s fi
enddef;

vardef milieu(expr AA,BB)=
  save $;
  pair $;
  if typetrace="mainlevee":
    $=point((length segment(AA,BB))*(1/2+(-1+uniformdeviate(2))/10)) of segment(AA,BB)
  else:
    $=iso(AA,BB)
  fi;
  $
enddef;

vardef CentreCercleC(expr a, b ,c) =
  save o; pair o;
  o - .5[a,b] = whatever * (b-a) rotated 90;
  o - .5[b,c] = whatever * (c-b) rotated 90;
  o
enddef;

vardef Orthocentre(expr a, b, c) =
  save h; pair h;
  h - a = whatever * (c-b) rotated 90;
  h - b = whatever * (a-c) rotated 90;
  h
enddef;

vardef CentreCercleI(expr aa,bb,cc)=
  save $,a,c;
  pair $;
  numeric a,c;
  a=(angle(aa-cc)-angle(bb-cc))/2;
  c=(angle(cc-bb)-angle(aa-bb))/2;
  ($-cc) rotated a shifted cc=whatever[aa,cc];
  ($-bb) rotated c shifted bb=whatever[bb,cc];
  $
enddef;

%------------------------------------------------
% Cercles
%------------------------------------------------
%Cercle connaissant le centre A et le rayon q
vardef cercle(expr aa, q)=fullcircle scaled (2*q) shifted aa
enddef;
%Cercle de centre A et passant par B
vardef cerclepoint(expr aa,bb)=fullcircle scaled (2*abs(aa-bb)) shifted aa
enddef;
%Cercle connaissant le diametre [AB]
vardef cercledia(expr aa,bb)=cercles(iso(aa,bb),bb)
  %fullcircle scaled (2*abs(1/2[aa,bb]-bb)) shifted (1/2[aa,bb])
enddef;
%Cercles complets
vardef cercles(text t)=
  save Cer;
  save n;
  n:=0;
  for p_=t:
    if pair p_:
      n:=n+1;
      _t[n]:=p_;
    fi
    if numeric p_:
      rayon:=p_;
    fi;
    if color p_:
      n:=n+1;
      _T[n]:=p_;
    fi;
  endfor;
  if typetrace="3D":%centre aa passant par bb dans le plan (ccddee) généralement aa=cc
    path Cer;
    color ptcer[];
    for k=0 step 5 until 360 :
      ptcer[k div 5]-_T[1]=Distance(_T[1],_T[2])*((_T[4]-_T[3])*cosd(k)/Distance(_T[3],_T[4])+(_T[5]-_T[3])*sind(k)/Distance(_T[3],_T[5]));
    endfor;
    Cer=Projette(ptcer0)
      for k=0 step 5 until 360 :
      ..Projette(ptcer[k div 5])
    endfor
    ..cycle;
  else:
    path Cer;
    if n=1 : Cer=fullcircle scaled (2*rayon) shifted _t[1];
    elseif n=2 : Cer=fullcircle scaled (2*abs(_t[1]-_t[2])) shifted _t[1];
    elseif n=3 : Cer=cercles(CentreCercleC(_t[1],_t[2],_t[3]),_t[1]);
    fi
  fi
  Cer
enddef;

%Point particulier sur le cercle
vardef pointarc(expr cercla,angle)=
  point(arctime((angle/360)*arclength cercla) of cercla) of cercla
enddef;

%Arc de cercle AB de centre 0(dans le sens direct) : les points A et B doivent etre sur le cercle.
vardef arccercle(expr aa,bb,oo)=
  path tempo;
  path arc;
  tempo=fullcircle scaled (2*abs(aa-oo)) shifted oo;
  if (angle(aa-oo)=0) or (angle(aa-oo)>0) :
    if (angle(bb-oo)=0) or (angle(bb-oo)>0):
      if (angle(aa-oo)<angle(bb-oo)):
	arc=subpath(angle(aa-oo)*(length tempo)/360,angle(bb-oo)*(length tempo)/360) of tempo;
      else:
	arc=subpath(angle(aa-oo)*(length tempo)/360,(length tempo)+angle(bb-oo)*(length tempo)/360) of tempo;
      fi;
    elseif (angle(bb-oo)<0):
      arc=subpath(angle(aa-oo)*(length tempo)/360,(length tempo)+angle(bb-oo)*(length tempo)/360) of tempo;
    fi;
  elseif (angle(aa-oo)<0):
    if (angle(bb-oo)=0) or (angle(bb-oo)>0):
      arc=subpath(length tempo+angle(aa-oo)*(length tempo)/360,length tempo+angle(bb-oo)*(length tempo)/360) of tempo;
    elseif (angle(bb-oo)<0):
      if (angle(aa-oo)=angle(bb-oo)) or (angle(aa-oo)<angle(bb-oo)):
	arc=subpath((length tempo)+angle(aa-oo)*(length tempo)/360,(length tempo)+angle(bb-oo)*(length tempo)/360) of tempo;
      else:
	arc=subpath((length tempo)+angle(aa-oo)*(length tempo)/360,2*(length tempo)+angle(bb-oo)*(length tempo)/360) of tempo;
      fi;
    fi;
  fi;
  arc
enddef;

vardef coupdecompas(expr ab,ac,ad)=arccercle(pointarc(cercles(ab,ac),angle(ac-ab)-ad),pointarc(cercles(ab,ac),angle(ac-ab)+ad),ab)
enddef;

%------------------------------------------------
% Procedures de codage
%------------------------------------------------
%Codage de l'angle droit de sommet B
vardef codeperp(expr aa,bb,cc,m)=%normalement m=5
  save codep;
  path codep;
  if typetrace="3D":
    codep=(Projette(bb)+m*unitvector(Projette(aa)-Projette(bb)))--(Projette(bb)+m*unitvector(Projette(aa)-Projette(bb))+m*unitvector(Projette(cc)-Projette(bb)))--(Projette(bb)+m*unitvector(Projette(cc)-Projette(bb)));
  else:
    codep=(bb+m*unitvector(aa-bb))--(bb+m*unitvector(aa-bb)+m*unitvector(cc-bb))--(bb+m*unitvector(cc-bb));
  fi;
  codep
enddef;

%Codage d'un milieu
vardef codemil(expr AA,BB, n) =%extremites-angle de codage
  save $,a,b,c,d;
  path $;
  pair a,b,c,d;
  a=1/2[AA,BB];
  b=(a+marque_s*unitvector(BB-AA))-(a-marque_s*unitvector(BB-AA));
  c=b rotated n shifted a;
  d=2[c,a];
  $=c--d;
  $
enddef;
%Codage de deux segments egaux
vardef codesegments(expr aa,bb,cc,dd,n)=%extremites des segments(4)-type de codage
  save $,v,w;
  picture $;
  pair AA,BB,CC,DD;
  $=image(
    if typetrace="3D":
      AA=Projette(aa);      BB=Projette(bb);      CC=Projette(cc);      DD=Projette(dd);
    else:
      AA=aa;BB=bb;CC=cc;DD=dd;
    fi;
    if n=5 :
      draw fullcircle scaled 0.1cm shifted (1/2[AA,BB]);
      draw fullcircle scaled 0.1cm shifted (1/2[CC,DD]);
    elseif n=4 :
      pair v,w;
      v=1/2[AA,BB];
      w=1/2[CC,DD];
      draw codemil(AA,BB,60);
      draw codemil(AA,BB,120);
      draw codemil(CC,DD,60);
      draw codemil(CC,DD,120);
    elseif n=3 :
      draw codemil(AA,BB,60);
      draw codemil(AA,BB,60) shifted (2*unitvector(AA-BB));
      draw codemil(AA,BB,60) shifted (2*unitvector(BB-AA));
      draw codemil(CC,DD,60);
      draw codemil(CC,DD,60) shifted (2*unitvector(CC-DD));
      draw codemil(CC,DD,60) shifted (2*unitvector(DD-CC));
    elseif n=2 :
      draw codemil(AA,BB,60) shifted unitvector(AA-BB);
      draw codemil(AA,BB,60) shifted unitvector(BB-AA);
      draw codemil(CC,DD,60) shifted unitvector(CC-DD);
      draw codemil(CC,DD,60) shifted unitvector(DD-CC);
    elseif n=1 :
      draw codemil(AA,BB,60);
      draw codemil(CC,DD,60);
    fi;
    );
    $
  enddef;

%Codage de plusieurs segments de meme longueur
  vardef Codelongueur(text t)=
  save result;
  picture result;
  pair tt[];
  k:=0;
  for p_=t:
    if pair p_:
      k:=k+1;
      tt[k]=p_;
    elseif color p_:
      k:=k+1;
      tt[k]=Projette(p_);
    elseif numeric p_:
      co:=p_;
    fi;
  endfor;
  result=image(
    if co=5:
      for j=1 upto (k div 2):
	draw fullcircle scaled 0.1cm shifted (1/2[tt[2*j-1],tt[2*j]]);
      endfor;
    elseif co=4:
      for j=1 upto (k div 2):
	draw codemil(tt[2*j-1],tt[2*j],60);
	draw codemil(tt[2*j-1],tt[2*j],120);
      endfor;
    elseif co=3:
      for j=1 upto (k div 2):
	draw codemil(tt[2*j-1],tt[2*j],60);
	draw codemil(tt[2*j-1],tt[2*j],60) shifted (2*unitvector(tt[2*j-1]-tt[2*j]));
	draw codemil(tt[2*j-1],tt[2*j],60) shifted (2*unitvector(tt[2*j]-tt[2*j-1]));
      endfor;
    elseif co=2:
      for j=1 upto (k div 2):
	draw codemil(tt[2*j-1],tt[2*j],60) shifted unitvector(tt[2*j-1]-tt[2*j]);
	draw codemil(tt[2*j-1],tt[2*j],60) shifted unitvector(tt[2*j]-tt[2*j-1]);
      endfor;
    elseif co=1:
      for j=1 upto (k div 2):
	draw codemil(tt[2*j-1],tt[2*j],60);
      endfor;
    fi;
    );
  result
enddef;

%Codage de l'angle abc non oriente (mais donne dans le sens direct) n fois avec des mesures differentes
vardef codeangle@#(expr aa,bb,cc,nb,nom)=
  save s,p,$;
  path p;
  picture $;
  $=image(
    trace marqueangle(aa,bb,cc,nb);
    label.@#(nom,w);
    );
  $
enddef;

vardef Marqueangle(expr aa,bb,mark)=%codage d'un angle forme par les demi-droites aa et bb dans le sens direct avec la marque mark
  save $;
  picture $;
  path conf,rr;
  pair w,tangent;
  numeric t,tt;
  conf=fullcircle scaled (2*marque_a) shifted (aa intersectionpoint bb);
  numeric te;
  te=angle((conf intersectionpoint aa)-(aa intersectionpoint bb));
  rr=(conf intersectionpoint aa){dir(90+angle((conf intersectionpoint aa)-(aa intersectionpoint bb)))}..(conf intersectionpoint bb);
  t=length rr/2;
  w=point(t) of rr;
  tangent=unitvector(direction t of rr);
  $=image(
    trace rr;
    if mark=1:
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90);
    elseif mark=2:
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90) shifted tangent;
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90) shifted(-tangent);
    elseif mark=3:
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90);
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90) shifted(1.5*tangent);
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,90) shifted(-1.5*tangent);
    elseif mark=4:
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,45);
      trace rotation((w shifted(5*tangent))--(w shifted(-5*tangent)),w,-45);
    fi;
    );
  $
enddef;

vardef marqueangle(expr aa,bb,cc,mark)=%codage d'un angle de sommet bb dans le sens direct par la marque mark.
  save $;
  picture $;
  path conf,rr;
  pair w,tangent;
  numeric t;
  if typetrace="mainlevee":
    conf=fullcircle scaled (2*marque_a) shifted bb;
    rr=(conf intersectionpoint demidroite(bb,aa)){dir(90+angle(aa-bb))}..(conf intersectionpoint demidroite(bb,cc));
    w=rr intersectionpoint droite(bb,CentreCercleI(aa,bb,cc));
    t=length rr/2;
    tangent=unitvector(direction t of rr);
    $=image(
	trace rr;
      if mark=1:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90);
      elseif mark=2:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted tangent;
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(-tangent);
      elseif mark=3:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(1.marque_s*tangent);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(-1.marque_s*tangent);
      elseif mark=4:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,45);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,-45);
      fi;
      );
  else:
    rr=arccercle(bb+marque_a*unitvector(aa-bb),bb+marque_a*unitvector(cc-bb),bb);
    w=rr intersectionpoint droite(bb,CentreCercleI(aa,bb,cc));
    t=length rr/2;
    tangent=unitvector(direction t of rr);
    $=image(
	if mark=5:
	drawarrow rr;
      else:
	trace rr;
      fi;
      if mark=1:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90);
      elseif mark=2:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted tangent;
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(-tangent);
      elseif mark=3:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(1.marque_s*tangent);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,90) shifted(-1.marque_s*tangent);
      elseif mark=4:
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,45);
	trace rotation((w shifted(marque_s*tangent))--(w shifted(-marque_s*tangent)),w,-45);
      fi;
      );
  fi;
  $
enddef;

vardef coloreangle(expr aa,bb,cc)=arccercle(bb+marque_a*unitvector(aa-bb),bb+marque_a*unitvector(cc-bb),bb)--bb--cycle
enddef;

vardef Codeangle(expr aa,bb,cc,nb,nom)=
  save s,p,$;
  path p;
  picture $;
  $=image(
    trace marqueangle(aa,bb,cc,nb);
    label(nom,w shifted(marque_ang*unitvector(w-bb)));
    );
  $
enddef;

vardef marquesegment(expr aa,bb)=
  save tr;
  picture tr;
  if typetrace="3D":
    tr=image(%
	typetrace:="normal";
      trace rotation(segment(Projette(aa)-marque_s*unitvector(Projette(bb)-Projette(aa)),Projette(aa)+marque_s*unitvector(Projette(bb)-Projette(aa))),Projette(aa),90);
      trace rotation(segment(Projette(bb)-marque_s*unitvector(Projette(bb)-Projette(aa)),Projette(bb)+marque_s*unitvector(Projette(bb)-Projette(aa))),Projette(bb),90);
      typetrace:="3D";
      );
  else:
    tr=image(%
	trace rotation(segment(aa-marque_s*unitvector(bb-aa),aa+marque_s*unitvector(bb-aa)),aa,90);
      trace rotation(segment(bb-marque_s*unitvector(bb-aa),bb+marque_s*unitvector(bb-aa)),bb,90);
      );
  fi;
  tr
enddef;

vardef marquedemidroite(expr aa,bb)=
  save tr;
  picture tr;
  tr=image(
    trace rotation(segment(aa-marque_s*unitvector(bb-aa),aa+marque_s*unitvector(bb-aa)),aa,90);
    );
  tr
enddef;

%------------------------------------------------
% Transformations
%------------------------------------------------
vardef projection(expr m,a,b) =
  save h; pair h;
  h - m = whatever * (b-a) rotated 90;
  h = whatever [a,b];
  if typetrace="mainlevee":
    h:=h shifted((-2+uniformdeviate(4))*unitvector(a-b))
  fi;
  h
enddef;
  
vardef homothetie(expr objet,CTR,rapport)=
  ((objet shifted (-CTR)) scaled rapport) shifted CTR
enddef;

vardef rotation(expr p,c,a)=
  p rotatedaround(c,a)
enddef;

vardef symetrie(expr x)(text t)=
  save n;
  n:=0;
  for p_=t: if pair p_:
      n:=n+1;
      _t[n]:=p_;
    elseif color p_:
      n:=n+1;
      _T[n]:=p_;
    fi;
  endfor;
  if n=1:
    if typetrace="3D":
      2[x,_T[1]]
    else:
      rotation(x,_t[1],180)
    fi
  elseif n=2:
    x reflectedabout(_t[1],_t[2])
  elseif n=3:%Par rapport a un plan
    2[x,ProjectionsurPlan(x,_T[1],_T[2],_T[3])]
  fi
enddef;

%------------------------------------------------
% Droites
%------------------------------------------------
vardef segment(expr aa,bb)=
  save Seg;
  path Seg;
  if typetrace="mainlevee":
    Seg=aa{dir(angle(bb-aa)+5)}..bb{dir(angle(bb-aa)+5)}
  elseif typetrace="3D":
    Seg=Projette(aa)--Projette(bb)
  else:
    Seg=aa--bb
  fi;
  Seg
enddef;

vardef droite(expr AA,BB)=
  save Dro;
  path Dro;
  if typetrace="mainlevee":
    Dro=(_tfig/abs(AA-BB))[BB,AA]{dir(angle(BB-AA)+10)}..segment(AA,BB)..(_tfig/abs(AA-BB))[AA,BB]{dir(angle(BB-AA)+10)}
  elseif typetrace="3D":
    Dro=(_tfig/abs(Projette(AA)-Projette(BB)))[Projette(BB),Projette(AA)]--(_tfig/abs(Projette(AA)-Projette(BB)))[Projette(AA),Projette(BB)]
  else:
    Dro=(_tfig/abs(AA-BB))[BB,AA]--(_tfig/abs(AA-BB))[AA,BB]
  fi;
  Dro
enddef;
vardef demidroite(expr AA,BB)=
  save Dem;
  path Dem;
  if typetrace="mainlevee":
    Dem=segment(AA,BB)..(_tfig/abs(AA-BB))[AA,BB]
  elseif typetrace="3D":
    Dem=Projette(AA)--(_tfig/abs(Projette(AA)-Projette(BB)))[Projette(AA),Projette(BB)]
  else:
    Dem=AA--(_tfig/abs(AA-BB))[AA,BB]
  fi;
  Dem
enddef;

vardef bissectrice(expr AA,BB,CC)=
  save $;
  path $;
  if typetrace="mainlevee":
    $=rotation(demidroite(BB,CentreCercleI(AA,BB,CC)),BB,-5+uniformdeviate(10))
  else:
    $=demidroite(BB,CentreCercleI(AA,BB,CC))
  fi;
  $
enddef;

vardef mediatrice(expr AA,BB)=droite(iso(AA,BB),rotation(BB,iso(AA,BB),90))
enddef;
%main levee : passer par la perpendiculaire passant par le milieu.

vardef perpendiculaire(expr AA,BB,II)=droite(iso(AA,BB),rotation(BB,iso(AA,BB),90)) shifted (II-iso(AA,BB))
enddef;

vardef parallele(expr AA,BB,II)=droite(AA,BB) shifted (II-(projection(II,AA,BB)))
enddef;

%%%%%%%%%%
%Polygone/Ligne brisée
%%%%%%%%%
vardef polygone(text t)=
  pair aaa[];
  j:=0;
  for p_=t: if pair p_:
      j:=j+1;
      aaa[j]=p_;
    elseif color p_:
      j:=j+1;
      aaa[j]=Projette(p_);
    fi;
  endfor;
  aaa[j+1]:=aaa[1];
  save $;
  path $;
  if typetrace="mainlevee":
    $=segment(aaa[1],aaa[2])--
      for k=2 upto (j-1):
      segment(aaa[k],aaa[k+1])--
    endfor
    segment(aaa[j],aaa[1])--cycle;
  else:
    $=aaa1--
      for k=2 upto j:
      aaa[k]--
    endfor
    cycle;
  fi;
  $
enddef;

vardef chemin(text t)=
  pair aaa[];
  j:=0;
  for p_=t: if pair p_:
      j:=j+1;
      aaa[j]=p_;
    elseif color p_:
      j:=j+1;
      aaa[j]=Projette(p_);
    fi;
  endfor;
  if typetrace="mainlevee":
    save $;
    picture $;
    $=image(
      for k=1 upto (j-1):
	trace segment(aaa[k],aaa[k+1]);
      endfor;
      );
  else:
    save $;
    path $;
    $=aaa1
    for k=2 upto j:
      --aaa[k]
    endfor;
  fi;
  $
enddef;

vardef Triangleqcq(text t)=
  save PfCTqc;
  pair pointchoisi[];
  pointchoisi1:=iso(coinbg,1/4[coinbg,coinbd],iso(coinbg,iso(coinhg,coinhd)),iso(coinhg,coinbg));
  pointchoisi2:=iso(coinbd,3/4[coinbg,coinbd],iso(coinbd,iso(coinhg,coinhd)),iso(coinhd,coinbd));
  test:=uniformdeviate(1);
  choix:=43+uniformdeviate(4);
  ecart:=abs(45-choix);
  relation:=60-(ecart/2)+uniformdeviate(ecart);
  if test<0.5 :
    pointchoisi3:=droite(pointchoisi1,rotation(pointchoisi2,pointchoisi1,choix)) intersectionpoint droite(pointchoisi2,rotation(pointchoisi1,pointchoisi2,-relation));
  else :
    pointchoisi3:=droite(pointchoisi2,rotation(pointchoisi1,pointchoisi2,-choix)) intersectionpoint droite(pointchoisi1,rotation(pointchoisi2,pointchoisi1,relation));
  fi
  j:=1;
  for p_=t:
    p_=pointchoisi[j];
    j:=j+1;
  endfor;
  path PfCTqc;
  PfCTqc=polygone(pointchoisi1,pointchoisi2,pointchoisi3);
  PfCTqc
enddef;

%------------------------------------------------
%Sucres
%------------------------------------------------
vardef hachurage(expr chemin, angle, ecart, trace)=
  save $;
  picture $;
  path support;
  support=((u*(-50,0))--(u*(50,0))) rotated angle;
  if trace=1:
    drawoptions(dashed evenly);
  elseif trace=2:
    drawoptions(dashed dashpattern(on12bp off6bp on3bp off6bp));
  elseif trace=3:
    drawoptions(dashed withdots);
  fi;
  $ = image(
    for j=-200 upto 200:
      if ((support shifted (ecart*j*(u,0))) intersectiontimes chemin)<>(-1,-1):
	draw support shifted (ecart*j*(u,0));
      fi
    endfor;
    );
  clip $ to chemin;
  drawoptions();
  $
enddef;

vardef Hachurage(expr Chemin, Angle, Ecart, Trace)=
  %Avec écart constant quel que soit l'angle d'inclinaison.
  save $;
  picture $;
  if Trace=0:
    drawoptions();
  elseif Trace=1:
    drawoptions(dashed evenly);
  elseif Trace=2:
    drawoptions(dashed dashpattern(on12bp off6bp on3bp off6bp));
  elseif Trace=3:
    drawoptions(dashed withdots);
  fi;
  path support;
  support=(u*(-50,0)--u*(50,0)) rotated Angle;
  $ = image(
      for j=-200 upto 200:
      if (support shifted (Ecart*j*u*(cosd(90-Angle),-sind(90-Angle)))) intersectiontimes Chemin<>(-1,-1):
	draw support shifted (Ecart*j*u*(cosd(90-Angle),-sind(90-Angle)));%));%(cosd(Angle),sind(Angle)));
      fi
    endfor;
    );
  clip $ to Chemin;
  drawoptions();
  $
enddef;
%fleche pour coter un segment [AB] (Jacques Marot)
vardef cotation(expr aa,bb,ecart,decalage,cote)=
  pair m[] ;
  save $;
  picture $;
  m3=unitvector(bb-aa) rotated 90;
  m1=aa+ecart*m3;
  m2=bb+ecart*m3;
  $=image(
    pickup pencircle scaled 0.2bp;
    drawdblarrow m1--m2 ;
    draw aa--m1 dashed evenly;
    draw bb--m2 dashed evenly;
    label(cote rotated angle(m2-m1),(m1+m2)/2+decalage*m3);
    );
  $
enddef;

vardef appelation(expr aa,bb,decalage,cote)=
  save $;
  pair m[],AA,BB;
  if color aa:
    AA=Projette(aa);
  else:
    AA=aa;
  fi;
  if color bb:
    BB=Projette(bb);
  else:
    BB=bb;
  fi;
  m3=unitvector(BB-AA) rotated 90;
  picture $;
  $=image(
    label(cote rotated angle(BB-AA),(BB+AA)/2+decalage*m3);
    );
  $
enddef;

vardef cotationmil(expr aa,bb,ecart,decalage,cote)= %Christophe
  pair m[],AA,BB;
  save $;
  picture cot;
   if color aa:
    AA=Projette(aa)
  else:
    AA=aa
  fi;
  if color bb:
    BB=Projette(bb)
  else:
    BB=bb
  fi;
  m3=unitvector(BB-AA) rotated 90;
  m1=AA+ecart*m3;
  m2=BB+ecart*m3;
  cot=image(
    pickup pencircle scaled 0.2bp;
    drawarrow (1/2[m1,m2]+decalage*unitvector(m1-m2))--m1;
    drawarrow (1/2[m1,m2]-decalage*unitvector(m1-m2))--m2;
    draw AA--m1 dashed evenly;
    draw BB--m2 dashed evenly;
    label(cote rotated angle(m2-m1),(m1+m2)/2);
    );
  cot
enddef;

vardef cotationarc(expr aaa,bbb,decal,ecart,sens,texte)=%pour le texte sens=1 ou -1
   save ty;
   picture ty;
   pair mnp,ctr;
   mnp=iso(aaa,bbb)+decal*unitvector(rotation(bbb,iso(aaa,bbb),90)-iso(aaa,bbb));
   ctr=CentreCercleC(aaa,bbb,mnp);
   path cts[];
   cts0=arccercle(bbb,aaa,ctr);
   cts1=arccercle(bbb,cts0 intersectionpoint perpendiculaire(aaa,bbb,iso(aaa,bbb)),ctr);
   cts2=arccercle(cts0 intersectionpoint perpendiculaire(aaa,bbb,iso(aaa,bbb)),aaa,ctr);
   ty=image(
     trace subpath(0,arctime(arclength cts1*(1-(ecart/10))) of cts1) of cts1 dashed evenly;
     trace subpath(0,arctime(arclength cts2*(1-(ecart/10))) of reverse(cts2)) of reverse(cts2) dashed evenly;
     if sens=1:
       label(texte rotated (angle(bbb-aaa)),mnp);
     else:
       label(texte rotated (angle(bbb-aaa)+180),mnp);
     fi;
     );
   ty
 enddef;

%%%%%%%%%%
%francisation
%%%%%%%%%
def trace expr o =
    if path o: draw o else: draw o fi
enddef;
def remplis expr o =
    if path o: fill o else: fill o fi
enddef;

%3D - basé sur donymodule
color Sommet[];

color Co[];
Co0=jaune;
Co1=violet;
Co2=orange;
Co3=ciel;
Co4=vert;
Co5=bleu;
Co6=rouge;

string pointilles;

string typerepre;
typerepre:="proj";

%generalite
vardef Projette(expr X)=
  pair $;
  Xobs := -redpart(X)*Aux1 + greenpart(X)*Aux3;
  Yobs := -redpart(X)*Aux5 - greenpart(X)*Aux6 + bluepart(X)*Aux4;
  if typerepre="proj":
    Zobs := -redpart(X)*Aux7 - greenpart(X)*Aux8 - bluepart(X)*Aux2 + Rho;
    XProj := DE*Xobs/Zobs;
    YProj := DE*Yobs/Zobs;
  elseif typerepre="persp":
    XProj := DE*Xobs;
    YProj := DE*Yobs;
  fi;
  $=(XProj,YProj);
  $
enddef;

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
  pointilles:="oui";
enddef;

%vues cachees

vardef Face(text t)=
  j:=0;
  for p_=t :
    if numeric p_:
      a[j]:=p_;
      j:=j+1;
    fi;
  endfor;
  for k=1 upto (j-1):
    Fc[a0*100+(k-1)]:=a[k];
  endfor;
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

vardef Module(expr aa)=%module d'un vecteur
sqrt((redpart(aa))**2+(greenpart(aa))**2+(bluepart(aa)**2))
enddef;

color CoulTrace;
CoulTrace=black;

vardef DessineObjet=
  for l=1 upto NF:
    color cc,dd;
    dd=Vision(Fc[l*100+1]);
    cc=Normal(Sommet[Fc[l*100+1]],Sommet[Fc[l*100+2]],Sommet[Fc[l*100+3]]);
    if (ProduitScalaire(dd,cc)<0):
      if pointilles="oui":
	drawoptions(dashed dashpattern(on3pt off6pt) withcolor CoulTrace);
	trace for k=1 upto Fc[100*l]:
	  Projette(Sommet[Fc[100*l+k]])--
	endfor
	cycle;
      fi;
    else:
      trace for k=1 upto Fc[100*l]:
	Projette(Sommet[Fc[100*l+k]])--
      endfor
      cycle withcolor CoulTrace;
    fi;
    drawoptions();
  endfor;
enddef;

%%Transformations

%Translations

vardef TranslateSommets(expr v)=
  for k=1 upto NbS:
    Sommet[k]:=Sommet[k]+v;
  endfor;
enddef;

vardef SymetriePlanZ(expr vv)=
  for k=1 upto NbS:
    w:=vv-bluepart(Sommet[k]);
    Sommet[k]:=(redpart(Sommet[k]),greenpart(Sommet[k]),w);
  endfor;
enddef;

vardef IntersectionDroite(expr aa,bb,cc,dd)=
  save tt;
  color tt;
  tt=whatever[aa,bb];
  tt=whatever[cc,dd];
  tt
enddef;

%%denis Roegel----------
vardef Intersectionplandroite(expr aa,bb,cc,dd,ee)=
  save int;
  boolean int;
  color gg,caaa[];
  caaa3=Normal(aa,bb,cc)/Module(Normal(aa,bb,cc));
  caaa1=aa-dd;
  caaa2=ee-dd;
  if ProduitScalaire(caaa2,caaa3)<>0:
    caaa4=caaa2*(ProduitScalaire(caaa1,caaa3)/ProduitScalaire(caaa2,caaa3));
    int:=true;
  else: % the line is parallel to the plane
    int:=false;
  fi;
  int
enddef;

vardef IntersectionPlanDroite(expr aa,bb,cc,dd,ee)=%plan (aa,bb,cc) droite(dd,ee)
  if Intersectionplandroite(aa,bb,cc,dd,ee):
    gg=dd+caaa4;
  fi;
  gg
enddef;

vardef ProjectionsurPlan(expr aa,bb,cc,dd)=%Projection du point aa sur le plan (bbccdd)
  save di,vc;
  color va,vb,vc;
  va=Normal(bb,cc,dd)/Module(Normal(bb,cc,dd));
  vb=aa-bb;
  di=-ProduitScalaire(vb,va);
  va:=di*va;
  vb:=vb+va;
  vc=bb+vb;
  vc
enddef;

vardef Intersectionplanplan(expr AA,BB,CC,DD,EE,FF)=%besoin pour la suite
  color trial[];
  path INTer;
  if Intersectionplandroite(DD,EE,FF,AA,BB):
    trial1=IntersectionPlanDroite(DD,EE,FF,AA,BB);
  else:% there is no intersection or the intersection is the line
    trial1=IntersectionPlanDroite(DD,EE,FF,AA,1/2[BB,CC]);
  fi;
  if Intersectionplandroite(DD,EE,FF,AA,CC):
    trial2=IntersectionPlanDroite(DD,EE,FF,AA,CC);
  else:% there is no intersection or the intersection is the line
    trial2=IntersectionPlanDroite(DD,EE,FF,CC,1/2[BB,AA]);%modif de cp
  fi;
  %INTer=segment(10[trial1,trial2],10[trial2,trial1]);
  INTer=droite(trial1,trial2);
  INTer
enddef;

vardef IntersectionPlanPlan(expr aa,bb,cc,dd,ee,ff)=
  %a verifier
  save da,db,dc,int,INTER;
  boolean int;
  path INTER;
  da=Module(aa-ProjectionsurPlan(aa,dd,ee,ff));
  %show da;
  db=Module(bb-ProjectionsurPlan(bb,dd,ee,ff));
  %show db;
  dc=Module(cc-ProjectionsurPlan(cc,dd,ee,ff));
  %show dc;
  if (da=db) and (db=dc): % the two planes are parallel
    int:=false;
  else:
    int:=true;
    if (da=db):
      INTER=droite(aa,bb);
    elseif (db=dc):
      INTER=droite(bb,cc);
    elseif (dc=da):
      INTER=droite(cc,aa);
    elseif (da>=db) and (da>=dc):
      INTER=Intersectionplanplan(aa,bb,cc,dd,ee,ff);
    elseif (db>=da) and (db>=dc):
      INTER=Intersectionplanplan(bb,cc,aa,dd,ee,ff);
    elseif (dc>=da) and (dc>=db):
      INTER=Intersectionplanplan(cc,aa,bb,dd,ee,ff);
    fi;
  fi;
  INTER
enddef;
%%---------------------

%Cube
numeric arete;
arete=1;

vardef Cube(text t)=
  picture cub;
  cub=image(
  NbS:=8;
  Sommet1:=(arete,0,0);
  Sommet2:=(arete,arete,0);
  Sommet3:=(0,arete,0);
  Sommet4:=(0,0,0);
  Sommet5:=(0,0,arete);
  Sommet6:=(arete,0,arete);
  Sommet7:=(arete,arete,arete);
  Sommet8:=(0,arete,arete);
%%Faces
  NF:=6;
  Fc[100]:=4;Fc[101]:=1;Fc[102]:=4;Fc[103]:=3;Fc[104]:=2;
  Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
  Fc[300]:=4;Fc[301]:=1;Fc[302]:=6;Fc[303]:=5;Fc[304]:=4;
  Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
  Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
  Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
  DessineObjet;
  k:=1;
  for p_=t:
    if color p_:
      p_=Sommet[k];
      k:=k+1;
    fi
  endfor;
  );
cub
enddef;

vardef cube=
  typetrace:="3D";
  typerepre:="persp";
  Initialisation(1500,30,20,100);
  picture cub;
  cub=image(
      NbS:=8;
    Sommet1:=(arete,0,0);
    Sommet2:=(arete,arete,0);
    Sommet3:=(0,arete,0);
    Sommet4:=(0,0,0);
    Sommet5:=(0,0,arete);
    Sommet6:=(arete,0,arete);
    Sommet7:=(arete,arete,arete);
    Sommet8:=(0,arete,arete);
%%Faces
    NF:=6;
    Fc[100]:=4;Fc[101]:=1;Fc[102]:=4;Fc[103]:=3;Fc[104]:=2;
    Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
    Fc[300]:=4;Fc[301]:=1;Fc[302]:=6;Fc[303]:=5;Fc[304]:=4;
    Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
    Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
    Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
    DessineObjet;
    );
  cub
enddef;

%Cube
vardef Paveh(text t)=
  picture paveh;
  paveh=image(
  NbS:=8;
  Sommet1:=(0.75,0,0);
  Sommet2:=(0.75,1.5,0);
  Sommet3:=(0,1.5,0);
  Sommet4:=(0,0,0);
  Sommet5:=(0,0,1);
  Sommet6:=(0.75,0,1);
  Sommet7:=(0.75,1.5,1);
  Sommet8:=(0,1.5,1);
%%Faces
  NF:=6;
  Fc[100]:=4;Fc[101]:=1;Fc[102]:=4;Fc[103]:=3;Fc[104]:=2;
  Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
  Fc[300]:=4;Fc[301]:=1;Fc[302]:=6;Fc[303]:=5;Fc[304]:=4;
  Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
  Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
  Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
  DessineObjet;
  k:=1;
  for p_=t:
    if color p_:
      p_=Sommet[k];
      k:=k+1;
    fi
  endfor;
  );
paveh
enddef;

%Cube
vardef Pavev(text t)=
  picture pavev;
  pavev=image(
  NbS:=8;
  Sommet1:=(1,0,0);
  Sommet2:=(1,0.75,0);
  Sommet3:=(0,0.75,0);
  Sommet4:=(0,0,0);
  Sommet5:=(0,0,1.5);
  Sommet6:=(1,0,1.5);
  Sommet7:=(1,0.75,1.5);
  Sommet8:=(0,0.75,1.5);
%%Faces
  NF:=6;
  Fc[100]:=4;Fc[101]:=1;Fc[102]:=4;Fc[103]:=3;Fc[104]:=2;
  Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
  Fc[300]:=4;Fc[301]:=1;Fc[302]:=6;Fc[303]:=5;Fc[304]:=4;
  Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
  Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
  Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
  DessineObjet;
  k:=1;
  for p_=t:
    if color p_:
      p_=Sommet[k];
      k:=k+1;
    fi
  endfor;
  );
pavev
enddef;

vardef Pave(text t)(expr aa,bb,cc)=
  picture pave;
  pave=image(
  NbS:=8;
  Sommet1:=(aa,0,0);
  Sommet2:=(aa,bb,0);
  Sommet3:=(0,bb,0);
  Sommet4:=(0,0,0);
  Sommet5:=(0,0,cc);
  Sommet6:=(aa,0,cc);
  Sommet7:=(aa,bb,cc);
  Sommet8:=(0,bb,cc);
%%Faces
  NF:=6;
  Fc[100]:=4;Fc[101]:=4;Fc[102]:=3;Fc[103]:=2;Fc[104]:=1;
  Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
  Fc[300]:=4;Fc[301]:=4;Fc[302]:=1;Fc[303]:=6;Fc[304]:=5;
  Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
  Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
  Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
  DessineObjet;
  k:=1;
  for p_=t:
    if color p_:
      p_=Sommet[k];
      k:=k+1;
    fi
  endfor;
  );
pave
enddef;

vardef pave(expr aa,bb,cc)=
  typetrace:="3D";
  typerepre:="persp";
  Initialisation(1500,30,20,100);
  picture PAVE;
  PAVE=image(
      NbS:=8;
    Sommet1:=(aa,0,0);
    Sommet2:=(aa,bb,0);
    Sommet3:=(0,bb,0);
    Sommet4:=(0,0,0);
    Sommet5:=(0,0,cc);
    Sommet6:=(aa,0,cc);
    Sommet7:=(aa,bb,cc);
    Sommet8:=(0,bb,cc);
%%Faces
    NF:=6;
    Fc[100]:=4;Fc[101]:=4;Fc[102]:=3;Fc[103]:=2;Fc[104]:=1;
    Fc[200]:=4;Fc[201]:=4;Fc[202]:=5;Fc[203]:=8;Fc[204]:=3;
    Fc[300]:=4;Fc[301]:=4;Fc[302]:=1;Fc[303]:=6;Fc[304]:=5;
    Fc[400]:=4;Fc[401]:=5;Fc[402]:=6;Fc[403]:=7;Fc[404]:=8;
    Fc[500]:=4;Fc[501]:=2;Fc[502]:=3;Fc[503]:=8;Fc[504]:=7;
    Fc[600]:=4;Fc[601]:=1;Fc[602]:=2;Fc[603]:=7;Fc[604]:=6;
    DessineObjet;
    );
  PAVE
enddef;

vardef Tetraedrer(text t)=
  picture tetrar;
  tetrar=image(
    %Sommets
    NbS:=4;
    Sommet1:=(0,0,1);
    Sommet2:=(-0.4714045,-0.8164965,-1/3);
    Sommet3:=(0.942809,0,-1/3);
    Sommet4:=(-0.4714045,0.8164965,-1/3);
    %Faces
    NF:=4;
    Fc[100]:=3;Fc[101]:=1;Fc[102]:=2;Fc[103]:=3;
    Fc[200]:=3;Fc[201]:=1;Fc[202]:=3;Fc[203]:=4;
    Fc[300]:=3;Fc[301]:=1;Fc[302]:=4;Fc[303]:=2;
    Fc[400]:=3;Fc[401]:=2;Fc[402]:=4;Fc[403]:=3;
    DessineObjet;
    k:=1;
    for p_=t:
      if color p_:
	p_=Sommet[k];
	k:=k+1;
      fi
    endfor;
    );
  tetrar
enddef;

%Outils
numeric echelleequerre;
echelleequerre=2;
vardef equerre(expr dte,drte,perpe,sens)=
  save picequerre;
  picture picequerre;
  pair ww,t[];
  path intermede;
  pair perpen,ptt,pttt;
  perpen:=projection(perpe,dte,drte);
  %if sens=1 :
    ptt:=longueurequerre*(drte-dte) rotated 90 shifted perpen;
  %else :
%    ptt:=longueurequerre*(drte-dte) rotated (-90) shifted perpen;
  %fi;
  ww=unitvector(drte-dte);
  intermede=ptt--(10[ptt,(perpen rotatedabout(ptt,if sens=1: 30 else:-30 fi))]);
  pttt=intermede intersectionpoint (10[dte,drte]--10[drte,dte]);
  picequerre=image(
    draw perpen--ptt--pttt--cycle;
    draw codeperp(ptt,perpen,pttt,5);
    );
  picequerre
enddef;

  vardef regle(expr depart,arrivee,rr)=
  save picregle;
  picture picregle,grad[],gradu[],final;
  pair t[];
  path reduit;
  t1000=depart shifted (5*unitvector(depart-arrivee));
  t1003=arrivee shifted (20*unitvector(arrivee-depart));
  t1004=(unitvector(arrivee-depart) rotated (-90)) shifted t1000;
  t1001=t1000 shifted (50*(t1004-t1000));
  t1002=t1001 shifted (t1003-t1000);
  reduit=t1000--t1001--t1002..(t1002 shifted(5*unitvector(t1001-t1002)+1/4(t1003-t1002)))..(t1002 shifted(5*unitvector(t1002-t1001)+2/4(t1003-t1002)))..(t1002 shifted(5*unitvector(t1001-t1002)+3/4(t1003-t1002)))..t1003--cycle;
  gradu1=image(
    for k=0 upto 59:
      for j=1 upto 4:
	t[5*k+j]=depart shifted (1mm*(5*k+j)*unitvector(arrivee-depart));
	t[400+5*k+j]=t[5*k+j] shifted (2*(t1004-t1000));
	draw t[5*k+j]--t[400+5*k+j];
      endfor;
    endfor
    );
  gradu2=image(
    for k=0 upto 29:
      t[5*(2*k+1)]=depart shifted (1mm*5*(2*k+1)*unitvector(arrivee-depart));
      t[400+5*(2*k+1)]=t[5*(2*k+1)] shifted (5*(t1004-t1000));
      draw t[5*(2*k+1)]--t[400+5*(2*k+1)];
    endfor
    );
  gradu3=image(
    for k=0 upto 30:
      t[10*k]=depart shifted(1mm*10*k*unitvector(arrivee-depart));
      t[400+10*k]=t[10*k] shifted (10*(t1004-t1000));
      draw t[10*k]--t[400+10*k];
    endfor
    );
  for j=0 upto 30:
    grad[j]=image(
	label.bot(TEX(""&decimal(j)&""),t[400+10*j]);
      %affixe[j](t[400+10*j])s;
      currentpicture:=currentpicture rotatedabout(t[400+10*j],90+angle(t[400+10*j]-t[10*j]));
      );
  endfor
  final=image(
    for k=0 upto 30:
      draw grad[k];
    endfor
    for k=1 upto 3:
      draw gradu[k];
    endfor
    clip currentpicture to reduit;
    draw reduit;
    );
  if rr=-1:
    picregle=image(
      draw final rotatedabout(1/2[depart,arrivee],180);
      );
  else:
    picregle=image(
      draw final;
      );
  fi
  picregle
enddef;

vardef crayon(expr depart,arrive,ptplace,nbechelle)=
  save piccray;
  picture piccray,crayolat;
  pair w[];
  w0=(0,0);
  w1=(1,2)*u/2;
  w2=(-1,2)*u/2;
  w3=(0,2)*u/2;
  w4=(0,7)*u/2;
  path ccc,ccd;
  ccc=cercles(w0,abs(w3-w2));
  ccd=ccc yscaled 0.25 shifted w3;
  crayolat=image(
    draw subpath((length ccd)/2,length ccd) of ccd;
    draw ccd shifted (w4-w3);
    draw w2--w0--w1;
    draw w1--((1,7)*u/2);
    draw w2--((-1,7)*u/2);
    );
  crayolat:=crayolat scaled nbechelle;
  piccray=(crayolat rotated(angle(arrive-depart)-30)) shifted ptplace;
  piccray
enddef;

boolean Simple;
Simple=false;

vardef rapporteur(expr centre,segment,rr)=
  save raps;
  picture raps;
  raps=image(
  Simple:=true;
  trace rapporteurdouble(centre,segment,rr);
    Simple:=false;
    );
  raps
enddef;

vardef rapporteurdouble(expr centre,segment,rr)=
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
    for i=0 upto 35 :
      for j=1 upto 4 :
	draw a[5*i+j]--b[5*i+j];
      endfor;
    endfor;
    for i=1 step 2 until 35:
      draw a[5*i]--b[5*i];
    endfor;
    for i=1 upto 18:
      draw a[10*i]--b[10i] withpen pencircle scaled 1.25;
    endfor;
    draw a0--a180;
    path cent;
    cent=cercle(centre,0.05*u);
    fill cent withcolor if unknown fillrap: 0.9white else: fillrap fi;
    );
  rap
enddef;

vardef compas(expr centre,extre,n)=
  save piccompas;
  picture piccompas;
  pair r,s,t,a,b,c,d,e,f;
  if (abs(centre-extre)<10*u):
    r=((extre-1/2[centre,extre]) rotated (n*90)) shifted (1/2[centre,extre]);
  else:
    r=0.25[1/2[centre,extre],((extre-1/2[centre,extre]) rotated (n*90)) shifted (1/2[centre,extre])];
  fi
  s=(1+50/abs(centre-extre))[1/2[centre,extre],r];
  t=10*unitvector(extre-centre) rotated (n*90);
  a=centre shifted t;
  b=s shifted (5*unitvector(centre-extre)+10*unitvector(s-r));
  c=b shifted (30*unitvector(s-r));
  d=c reflectedabout(r,s);
  e=b reflectedabout(r,s);
  f=a reflectedabout(r,s);
  path comp;
  comp=a--b--c--d--e--f--s--a--cycle;
  piccompas=image(
    fill comp withcolor black;
    draw centre--a withpen pencircle scaled 1.5bp;
    draw f--extre withpen pencircle scaled 1.5bp withcolor 0.25[red,blue];
    );
  piccompas
enddef;

%Grilles
boolean orig,uni;
orig=false;
uni=false;

vardef origine(expr p)=
  x.origine:=x.so+xpart(p)*quad.u;
  y.origine:=y.so+ypart(p)*quad.u;
  orig:=true;
enddef;

vardef unites(expr g,h)=
  x.u:=g*cm;
  y.u:=h*cm;
  uni:=true;
enddef;

vardef axes=
  path axehor,axever;
  axehor=(x.so*cm,y.origine)--(x.ne*cm,y.origine);
  axever=(x.origine,y.so*cm)--(x.origine,y.ne*cm);
  picture axx;
  axx=image(
    drawarrow (x.so*cm,y.origine)--(x.ne*cm,y.origine);
    drawarrow (x.origine,y.so*cm)--(x.origine,y.ne*cm);
    label.llft(btex $O$ etex,z.origine);
    );
  axx
enddef;

vardef axesvide=
  path axehor,axever;
  axehor=(x.so*cm,y.origine)--(x.ne*cm,y.origine);
  axever=(x.origine,y.so*cm)--(x.origine,y.ne*cm);
  picture axxx;
  axxx=image(
    drawarrow (x.so*cm,y.origine)--(x.ne*cm,y.origine);
    drawarrow (x.origine,y.so*cm)--(x.origine,y.ne*cm);
    );
  axxx
enddef;

vardef axesvideorigine=
  path axehor,axever;
  axehor=(x.origine,y.origine)--(x.ne*cm,y.origine);
  axever=(x.origine,y.origine)--(x.origine,y.ne*cm);
  picture axxx;
  axxx=image(
    drawarrow (x.origine,y.origine)--(x.ne*cm,y.origine);
    drawarrow (x.origine,y.origine)--(x.origine,y.ne*cm);
    );
  axxx
enddef;

def enplace=
  if orig:
    xscaled x.u yscaled y.u shifted (z.origine)
  else:
    xscaled x.u yscaled y.u shifted (z.so)
  fi
enddef;

vardef placepoint(expr q,r)=
  (q,r) enplace
enddef;

vardef pp(expr qq,rr)=placepoint(qq,rr)
enddef;

def replace=
  xscaled (1/x.u) yscaled (1/y.u) shifted (-z.origine)
enddef;

def retrouvecoord(expr p)=%trasnforme les coordonées du point d'affixe p dans le repère absolu de metapost en les coordonnées du point dans le repère défini par l'utilisateur
  p replace
enddef;

vardef placepointtri(expr q,r)=
  save $;
  pair $;
  if orig:
    $=z.origine shifted (q*(x.u,0)+r*(x.u/2,y.u));
  else:
    $=z.so*cm shifted (q*(x.u,0)+r*(x.u/2,y.u));
  fi;
  $
enddef;

vardef pptri(expr qq,rr)=placepointtri(qq,rr)
enddef;

vardef placepointiso(expr q,r)=
  save $;
  pair $;
  $=if orig: z.origine else: (z.so+((sqrt(3)/2),0.5))*cm fi shifted (q*(sqrt(3)*cm,0)+0.5*r*cm*(sqrt(3),1));
  $
enddef;

vardef ppiso(expr qq,rr)=placepointiso(qq,rr)
enddef;

vardef reperehexa(expr colo,lign)=
  save $;
  path $;
  if (colo mod 2)=1:
    $=(hexa shifted(0.5cm,0)) shifted((colo-1)*1.5*cm,(lign-1)*2*((sqrt 3)/2)*cm);
  else:
    $=(hexa shifted(0.5cm,0)) shifted((colo-1)*1.5*cm,((lign-1)*2+1)*((sqrt 3)/2)*cm);
  fi;
  $
enddef;

vardef Centrehexa(expr colo,lign)=
  save $;
  pair $;
  if (colo mod 2)=1:
    $=(centrehexa shifted(0.5cm,0)) shifted((colo-1)*1.5*cm,(lign-1)*2*((sqrt 3)/2)*cm);
  else:
    $=(centrehexa shifted(0.5cm,0)) shifted((colo-1)*1.5*cm,((lign-1)*2+1)*((sqrt 3)/2)*cm);
  fi;
  $
enddef;

%%Les grilles

vardef grille(expr t)=
  save gri;
  picture gri;
  orig:=false;
  x.u:=t*cm;
  y.u:=t*cm;
  quad.u:=t*cm;
  gri=image(
    path p[];
      %horizontale
    p1:=(x.so*cm,0)--(x.ne*cm,0);
      %verticale
    p2:=(0,y.so*cm)--(0,y.ne*cm);
          %options
          %horizontales
    for i:=0 step t until (y.ne-y.so):
      draw p1 shifted (0,i*cm);
    endfor;
          %verticales
    for i:=0 step t until (x.ne-x.so) :
      draw p2 shifted (i*cm,0);
    endfor;
    );
  gri
enddef;

vardef papiermillimetre=
  save $;
  picture $;
  orig:=false;
  x.u:=1cm;
  y.u:=1cm;
  quad.u:=1cm;
  $=image(
    path p[];
      %horizontale
    p1:=(x.so*cm,0)--(x.ne*cm,0);
      %verticale
    p2:=(0,y.so*cm)--(0,y.ne*cm);
    %grille millimétrique
    pickup pencircle scaled 0.2;
    %horizontales
    for j:=y.so step 0.1 until y.ne:
      draw p1 shifted (0,j*cm);
    endfor;
    %verticales
    for j:=x.so step 0.1 until x.ne :
      draw p2 shifted (j*cm,0);
    endfor;
    %grille demi-centimétrique
    pickup pencircle scaled 0.5;
    %horizontales
    for j:=y.so step 0.5 until y.ne:
      draw p1 shifted (0,j*cm);
    endfor;
    %verticales
    for j:=x.so step 0.5 until x.ne :
      draw p2 shifted (j*cm,0);
    endfor;
    %grille centimétrique
    pickup pencircle scaled 0.7;
    %horizontales
    for j:=y.so step 1 until y.ne:
      draw p1 shifted (0,j*cm);
    endfor;
    %verticales
    for j:=x.so step 1 until x.ne :
      draw p2 shifted (j*cm,0);
    endfor;    
    %grille penta-centimétrique
    pickup pencircle scaled 1;
    %horizontales
    for j:=y.so step 5 until y.ne:
      draw p1 shifted (0,j*cm);
    endfor;
    %verticales
    for j:=x.so step 5 until x.ne :
      draw p2 shifted (j*cm,0);
    endfor;
    );
  $
enddef;

vardef Pointe(text t)=
  for p_=t: if pair p_:
      fill fullcircle scaled 1mm shifted p_;
    fi;
  endfor;
enddef;

vardef papiercahier=
  save $;
  orig:=false;
  picture $;
  x.u:=8mm;
  y.u:=8mm;
  quad.u:=8mm;
  $=image(
    path p[];
  %horizontale
p1:=(x.so*cm,0)--(x.ne*cm,0);
  %verticale
p2:=(0,y.so*cm)--(0,y.ne*cm);
     %grille 2-millimétrique
    pickup pencircle scaled 0.5;
     %lignes horizontales
    for i:=y.ne step -0.2 until y.so:
      draw p1 shifted (0,i*cm);
    endfor;
     %grille 8-millimétrique
    pickup pencircle scaled 1bp;
     %lignes horizontales
    for i:=y.ne step -0.8 until y.so:
      draw p1 shifted (0,i*cm);
    endfor;
     %lignes verticales
    for i:=x.so step 0.8 until (x.ne+1):
      draw p2 shifted (i*cm,0);
    endfor;
    );
  $
enddef;

vardef papierdeuxlignes=
  save $;
  orig:=false;
  picture $;
  x.u:=8mm;
  y.u:=6mm;
  $=image(
    path p[];
    %horizontale
    p1:=(x.so*cm,0)--(x.ne*cm,0);
    %grille 2-millimétrique
    pickup pencircle scaled 0.5;
    %lignes horizontales
    for i:=y.so+0.2 step 0.6 until y.ne:
      draw p1 shifted (0,i*cm);
    endfor;
    %grille 8-millimétrique
    pickup pencircle scaled 1;
    %lignes horizontales
    for i:=y.so step 0.6 until y.ne:
      draw p1 shifted (0,i*cm);
    endfor;
    );
  $
enddef;

vardef papierpointe=
  save $;
  picture $;
  orig:=false;
  x.u:=5mm;
  y.u:=5mm;
  quadu:=5mm;
  $=image(
    for i:=0 upto 2*(xpart(retrouvecoord(z.ne*cm))-xpart(retrouvecoord(z.so*cm))):
      for j:=0 upto 2*(ypart(retrouvecoord(z.ne*cm))-ypart(retrouvecoord(z.so*cm))):
	fill ((fullcircle scaled 1bp shifted(z.so*cm)) shifted ((i/2,j/2)*cm));
      endfor
    endfor;
    );
  $
enddef;

vardef papiertriangle=
  save $;
  orig:=false;
  if uni=false:
    x.u:=1cm;
    y.u:=(sqrt(3)/2)*cm;
  fi;
  picture $;
  $=image(
    path p[];
    %triangle haut
    %p1:=(x.so*cm,0)--(x.so*cm+1cm,0)--((x.so*cm,0) rotatedabout((x.so*cm+1cm,0),-60))--cycle;
    p1:=(x.so*cm,0)--(x.so*cm+x.u,0)--((x.so*cm,0) rotatedabout((x.so*cm+x.u,0),-60))--cycle;
    %triangle bas
    %p2:=((x.so*cm,0)--(x.so*cm+1cm,0)--((x.so*cm,0) rotatedabout((x.so*cm+1cm,0),60))--cycle) shifted (-0.5cm,((sqrt3)/2)*cm);
    p2:=((x.so*cm,0)--(x.so*cm+x.u,0)--((x.so*cm,0) rotatedabout((x.so*cm+x.u,0),60))--cycle) shifted (-x.u/2,y.u);
    %grille horizontale1
    pickup pencircle scaled 0.5;
    numeric etag;
    etag=floor(2*cm*(ypart(retrouvecoord(z.ne*cm))-ypart(retrouvecoord(z.so*cm)))/(y.u))+1;
    for i:=0 step 2 until etag:
      for j:=0 upto (xpart(retrouvecoord(z.ne*cm))-xpart(retrouvecoord(z.so*cm))):
	draw p1 shifted (j*x.u,i*y.u);
	draw p2 shifted (j*x.u,i*y.u);
      endfor
    endfor;
     %grille horizontale 2
    pickup pencircle scaled 0.5;
    for i:=1 step 2 until etag:
      for j:=0 upto (xpart(retrouvecoord(z.ne*cm))-xpart(retrouvecoord(z.so*cm))):
	draw p1 shifted ((j-1/2)*x.u,i*y.u);
	draw p2 shifted ((j+1/2)*x.u,i*y.u);
      endfor
    endfor;
    );
  $
enddef;

vardef papiertrianglepointe=
  save $;
  orig:=false;
  if uni=false:
    x.u:=1cm;
    y.u:=(sqrt(3)/2)*cm;
  fi;
  picture $;
  $=image(
     pickup pencircle scaled 0.5;
    numeric etag;
    etag=floor(2*cm*(ypart(retrouvecoord(z.ne*cm))-ypart(retrouvecoord(z.so*cm)))/(y.u))+1;
    for i:=0 step 2 until etag:
      for j:=0 upto (xpart(retrouvecoord(z.ne*cm))-xpart(retrouvecoord(z.so*cm))):
	fill (fullcircle scaled 1bp shifted(z.so*cm)) shifted (j*x.u,i*y.u);
      endfor
    endfor;
    for i:=1 step 2 until etag:
      for j:=0 upto (xpart(retrouvecoord(z.ne*cm))-xpart(retrouvecoord(z.so*cm))):
	fill (fullcircle scaled 1bp shifted(z.so*cm)) shifted ((j-1/2)*x.u,i*y.u);
      endfor
    endfor;
    );
  $
enddef;

vardef papierisometriquepointe=
  save $;
  orig:=false;
  y.u:=1cm;
  x.u:=(sqrt(3)/2)*cm;
  picture $;
  $=image(
    %grille horizontale1
    pickup pencircle scaled 0.5;
    for i:=0 step 1 until (ypart(retrouvecoord(z.ne*cm))-ypart(retrouvecoord(z.so*cm))):
      for j:=0 step 2 until (xpart(retrouvecoord(z.ne*cm))-xpart(retrouvecoord(z.so*cm))+2):
	fill (fullcircle scaled 1bp shifted (z.so*cm)) shifted (j*((sqrt3)/2)*cm,i*cm);
      endfor
    endfor;
     %grille horizontale 2
    for i:=0 step 1 until (ypart(retrouvecoord(z.ne*cm))-ypart(retrouvecoord(z.so*cm))-1):
      for j:=1 step 2 until (xpart(retrouvecoord(z.ne*cm))-xpart(retrouvecoord(z.so*cm))+1):
	fill (fullcircle scaled 1bp shifted (z.so*cm)) shifted (j*((sqrt3)/2)*cm,(i+0.5)*cm);
      endfor
    endfor;
    );
  $
enddef;

vardef papierisometrique=
  save $;
  orig:=false;
  x.u:=(sqrt(3)/2)*cm;
  y.u:=1cm;
  picture $;
  $=image(
    path p[];
    %triangle haut
    p1:=(x.so*cm,1cm)--((x.so*cm,0) rotatedabout((x.so*cm,1cm),60))--(x.so*cm,0);
    %triangle bas
    p2:=((x.so*cm,1cm)--((x.so*cm,0) rotatedabout((x.so*cm,1cm),-60))--(x.so*cm,0)) shifted (((sqrt3)/2)*cm,0);
    %grille horizontale1
    pickup pencircle scaled 0.5;
    for i:=0 step 2  until (xpart(retrouvecoord(z.ne*cm))-xpart(retrouvecoord(z.so*cm))):
      for j:=0 upto (ypart(retrouvecoord(z.ne*cm))-ypart(retrouvecoord(z.so*cm))-1):
	draw p1 shifted (i*((sqrt3)/2)*cm,j*cm);
	draw p2 shifted ((i+1)*((sqrt3)/2)*cm,j*cm);
      endfor
    endfor;
    );
  $
enddef;

vardef papierhexagonal=
  save $;
  picture $;
  orig:=false;
  path hexa;
  %hexagone de départ
  hexa:=z.so*cm--(x.so*cm+1cm,y.so*cm)--(z.so*cm rotatedabout((x.so*cm+1cm,y.so*cm),-120))--((x.so*cm+1cm,y.so*cm) rotatedabout((z.so*cm rotatedabout((x.so*cm+1cm,y.so*cm),-120)),-120))--((z.so*cm rotatedabout((x.so*cm+1cm,y.so*cm),-120)) rotatedabout(((x.so*cm+1cm,y.so*cm) rotatedabout((z.so*cm rotatedabout((x.so*cm+1cm,y.so*cm),-120)),-120)),-120))--(((x.so*cm+1cm,y.so*cm) rotatedabout((z.so*cm rotatedabout((x.so*cm+1cm,y.so*cm),-120)),-120)) rotatedabout(((z.so*cm rotatedabout((x.so*cm+1cm,y.so*cm),-120)) rotatedabout(((x.so*cm+1cm,y.so*cm) rotatedabout((z.so*cm rotatedabout((x.so*cm+1cm,y.so*cm),-120)),-120)),-120)),-120))--cycle;
  $=image(
    pair centrehexa;
    centrehexa=1/2[z.so*cm,((x.so*cm+1cm,y.so*cm) rotatedabout((z.so*cm rotatedabout((x.so*cm+1cm,y.so*cm),-120)),-120))];
    pickup pencircle scaled 0.5;
    numeric etag;
    etag=floor((abs(y.ne*cm-y.so*cm))/((sqrt(3)/2)*cm));
    for i:=0 step 3  until (abs(x.ne*cm-x.so*cm)/1cm):
      for j:=0 step 2 until etag:
	draw hexa shifted ((i+0.5)*cm,j*((sqrt 3)/2)*cm);
	draw hexa shifted ((i+2)*cm,(j+1)*((sqrt 3)/2)*cm);
      endfor
    endfor;
    );
  $
enddef;

endinput;
