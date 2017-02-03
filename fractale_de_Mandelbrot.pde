int iMax = 100;  //nombre max d'itérations pour tester si un point est oui ou non dans la fractale de Mandelbrot
int i;
float x1 = -2.1;  //on définit les conditions initiales de zoom (les coordonnées des points en haut à gauche et en bas à droite de la fenêtre
float x2 = .6;
float y1 = -1.2;
float y2 = 1.2;

size(1080,960);  //taille de la fenêtre
surface.setTitle("Fractale de Mandelbrot");

float zoomX = width/(x2-x1);  //zoom sur chaque axe de la fenêtre, il est égal à la longueur de l'axe en pixel divisé par la différence des coordonnées des 2 points
float zoomY = height/(y2-y1);
 
for (float x = 0; x < width; x++)  {  //boucle qui va nous permettre de parcourir chaque point de l'écran
  for (float y = 0; y < height; y++)  {
    
    //cR et cI sont les coordonnées du point
    //zR définit la partie réelle de z, et zI sa partie complexe
    float cR = x / zoomX + x1;
    float cI = y / zoomY + y1;
    float zR = 0;
    float zI = 0;
    i = 0;  //on remet le nombre d'itérations à 0
    
    while  (zR*zR+zI*zI < 4 && i < iMax)  {  //on fait ceci tant que la fonction ne dépasse pas 2 et que le nombre d'itérations est inférieur à celui fixé au début 
                                             //nous avons 2 parties, donc il faut que racineCarrée(zR^2+zI^2) < 2, autrement dit que zR^2 + zI^2 = 2^2
      
      /*la suite que nous devant calculer par récurence est Z(n+1) = Z(n)^2+c, or notre ordinateur ne prend pas en compte les nombres complexes, donc nous devons séparer ce calcul en 2
        (rappel : zR définit la partie réelle de z, et zI sa partie complexe)
       z = z^2 + c  (où z = x + y*i, avec x = zR (partie réelle) et y = zI (partie complexe) et où c est lui aussi divisé en deux parties, une partie réelle notée cR et une partie complexe notée cI)
         = (zR + zI * i)^2 + (cR + cI * i)  on développe
         = zR^2 + 2i * zR * zI + (zI*i)^2 + cR + cI * i  on développe
         = zR^2 + 2i * zR * zI - zI^2 (car i^2 = -1) + cR + cI * i
         = (zR^2 - zI + cR) (<== partie réelle du nombre) + i(2*zR*zI+cI)  (<== partie complexe du nombre, où on a juste factorisé par i)
      */
      float temp = zR;
      zR = zR*zR - zI*zI + cR;
      zI = 2*zI*temp + cI;
      i++;
    }
    
    if  (i == iMax)  {  //si on a fait autant d'essais que le nombre maximum possible, alors c'est que la suite ne tend pas vers l'infini, donc on dessine un pixel noir
      
      set(int(x),int(y),color(0));
    }  else  {set(int(x),int(y),color(0,0,i*255/iMax));}  //sinon cela veut dire que la suite tend vers l'infini, on dessine alors un pixel bleu avec une nuance qui correspond au nombre d'essai qu'on a effectué avant de se rendre compte qu'elle tend vers l'infini
  }
}