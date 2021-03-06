////////////////////////////////////////////////////
// Définition des échantillons sur un axe         //
// Créer un axe avec un pas de i = 100 / i + 5e-3 //
////////////////////////////////////////////////////
axe = [0:99] / 100 + 5e-3;

////////////////////////////////////////////////////////////////////////
// Définition des éléments de surface                                 //
// créer une matrice avec la matrice de 1 transposer * la matrice axe //
////////////////////////////////////////////////////////////////////////
x = ones (1:100)' * axe;

////////////////////////////////////////////////////////////////////////
// créer une matrice avec la matrice de axe transposer * la matrice 1 //
////////////////////////////////////////////////////////////////////////
y = axe' * ones (1:100); 

///////////////////////////
// Position de la source //
///////////////////////////
xs = 0.5;
ys = 0.5;

/////////////////////////////////////////////////////////////////////////////
// Calcule de la distance                                                  //
// d = sqrt ((x - xs).^2 + (y - ys).^2);                                   //
// (x - xs).^2    ->  pour chaque valeur de la matrice x                   //
// on lui soustrait xs(car un scalaire) et on l'eleve au carre             //
//                                                                         //
// si on voulais faire un produit matriciel on ferai juste ^2.             //
// on calcule la distance entre les valeurs de la matrice x et celle de y  //
/////////////////////////////////////////////////////////////////////////////
d = sqrt ((x - xs).^2 + (y - ys).^2);

///////////////////////////////////
// Tracé de la fonction distance //
///////////////////////////////////

//plot3d (axe, axe, d);

//////////////////////////////////////////////////////////////////////
// calculer, puis représenter sous forme d'image et de fonction 3D, //
// les valeurs d'éclairement reçues par les éléments de la surface  //
// plane éclairée par la source ponctuelle isotrope.                //
//////////////////////////////////////////////////////////////////////

h = 0.5; // 50 cm
fluxEnerg = 100;
I = fluxEnerg / (2* %pi);
e0 = I / h^2;

//eclairementISO = e0 * h^3 * ( h^2 + d.^2).^(-3/2);
//varRelMaxIso = (max(eclairementISO) - min(eclairementISO)) / max(eclairementISO) * 100;

//plot3d (axe, axe, eclairementISO);

//////////////////////////////////////////////////////////////////////
// calculer, puis représenter sous forme d'image et de fonction 3D, //
// les valeurs d'éclairement reçues par les éléments de la surface  //
// plane éclairée par une source ponctuelle lambertienne.           //
//////////////////////////////////////////////////////////////////////

//eclairementLAM = e0 * h^4 * ( h^2 + d.^2).^(-2);
//varRelMaxLam = (max(eclairementLAM) - min(eclairementLAM)) / max(eclairementLAM) * 100

//plot3d (axe, axe, eclairementLAM);


// calcule de la grille
axe = [0:99] / 100 + 5e-3;
x = ones (1:100)' * axe;
y = axe' * ones (1:100); 


axe200 = [0:199] / 100 + 5e-3;
x200 = ones (1:200)' * axe200;
y200 = axe200' * ones (1:200); 

h = 0.5; // 50 cm
fluxEnerg = 100;
I = fluxEnerg / (2* %pi);
e0 = I / h^2;

// nombre de lumière par ligne
num = 2;

// the distance between each light (2 metters square long)
dist = 2 / (num+1); 

grilleLum = [1:num] * dist;
// - (ceil(num/2)*dist)

a = grilleLum';
b = (grilleLum * %i);

a = repmat(a,1,num);
b = repmat(b,num,1);

grille = a + b;

eclairement = [];

for i = 1 : num
    for j = 1 : num
        
            xs = real(grille(i,j));
            ys = imag(grille(i,j));
    
            d = sqrt ((x200 - xs).^2 + (y200 - ys).^2);
    
            eclairementLAM = e0 * h^4 * ( h^2 + d.^2).^(-2);
            
            eclairement = eclairement + eclairementLAM;
    end
end

centre = eclairement(51:150,51:150);
plot3d (axe, axe, centre);

varRelMaxLam = (max(centre) - min(centre)) / max(centre) * 100;


moy = ones(100,100);


