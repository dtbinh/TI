// return a matrix representation of a cube
function m = cube()
    p1 = [-0.5, -0.5, -0.5, 1];
    p2 = [0.5, -0.5, -0.5, 1];
    p3 = [0.5, 0.5, -0.5, 1];
    p4 = [-0.5, 0.5, -0.5, 1];
    p5 = [-0.5, -0.5, 0.5, 1];
    p6 = [0.5, -0.5, 0.5, 1];
    p7 = [0.5, 0.5, 0.5, 1];
    p8 = [-0.5, 0.5, 0.5, 1];
    
    m = [p1',p2',p3',p4',p5',p6',p7',p8']; 
endfunction

function seg = segmentCube()
    
    liste  = [1:4];
    liste1 = liste+4;
    
    liste2 = moveNElemToTheEnd(liste,liste(1,1))
    liste3 = moveNElemToTheEnd(liste1,liste1(1,1))
    
    seg = [liste, liste1, liste; liste2, liste3,liste1] 
endfunction


function t =  moveNElemToTheEnd(tab, n)
    t = modulo(tab,size(tab,2))+n
endfunction

function m = grille()
    x = [1:6] - 3.5;
    y = [-1.5,-1.5,-1.5,-1.5,-1.5,-1.5];
    z = zeros(1,24);
    w = ones(1,24);

    m = [x, x, x, x; y, y+1,y+2, y+3; z; w]
endfunction


function seg = segmentGrille()
    liste  = [1:5];
    liste2 = [1:6];
    seg = [liste, liste+6, liste+12, liste+18, liste2, liste2+6, liste2+12;
           liste+1, liste+7, liste+13, liste+19, liste2+6, liste2+12, liste2+18];
endfunction

// Calcule la matrice homogène définissant 
// la rotation d'un angle theta autour de l'axe X
function m = RotationX(theta)
    m = [1,     0,        0,       0;
         0,cosd(theta),-sind(theta), 0;
         0,sind(theta),cosd(theta),  0;
         0,     0,        0,       1];
endfunction

// Calcule la matrice homogène définissant 
// la rotation d'un angle theta autour de l'axe Y
function m = RotationY(theta)
    m = [cosd(theta),0,sind(theta), 0;
         0,         0,      0,    0;   
         -sind(theta),0,cosd(theta),0;
         0,         0,      0,    1];
endfunction

// Calcule la matrice homogène définissant 
// la rotation d'un angle theta autour de l'axe Z
function m = RotationZ(theta)
    m = [cosd(theta),-sind(theta),0 ,0;
         sind(theta),cosd(theta) ,0 ,0;   
         0         ,0          ,1 ,0;
         0         ,0          ,0 ,1];
endfunction

// Calcule la matrice homogène définissant 
// la translation de vecteur (x,y,z).
function m = Translation(x,y,z)
    m = [1,0,0,x;
         0,1,0,y;
         0,0,1,z;
         0,0,0,1];
endfunction



// f = distance focal
// matExtr = matrice extrinsec
function m = projection(f, matExtr)
    proj = [f, 0, 0, 0;
            0, f, 0, 0;
            0, 0, 1, 0]
    m = proj * matExtr
endfunction


// Sc = colonne
// Sl = ligne
// Oc = colonne
// Ol = ligne
// xiyiw = matrice de projection
function m = Intrinsec(f,Sc, Sl, Oc, Ol, matExtr)
    proj = [f, 0, 0, 0;
            0, f, 0, 0;
            0, 0, 1, 0]
            
    xiyi = proj * matExtr;
    
    m1 = [1/Sc,  0,   Oc;
           0,   1/Sl, Ol;
           0,     0,   1]
    
    m = m1*xiyi;
endfunction



// -----------------------------------------------------------------------
// Fonction d'affichage d'un objet 2D
// nfigure = numero de la figure scilab
// taille = [nblignes, nbpixels]
// points = matrice 2*N des coordonnees des points
// segments = matrice 2*M des indices des points
// -----------------------------------------------------------------------
function tiAfficheObjet2D (nfigure, taille, points, segments)
    // Creer une nouvelle figure ou activer une figure existante
    hf = scf (nfigure);
    hf.figure_name = "Projection numero %d";
    // Echelle identique sur les deux axes
    ha = gca ();
    ha.isoview = "on";
    ha.axes_reverse = ["off", "on", "off"];
    ha.x_location = "top";
    ha.box = "on";
    // Tracer les points
    plot2d (points(1,:), points(2,:), style = -4, ...
    rect=[0,0,taille(2),taille(1)]);
    // Tracer les segments
    sx = [points(1,segments(1,:));points(1,segments(2,:))];
    sy = [points(2,segments(1,:));points(2,segments(2,:))];
    xsegs (sx, sy);
endfunction
