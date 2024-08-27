set
d Dias /1*7/
i Bloques /1*10/
p Peliculas /1*1000/
g Generos /1*8/
c EspaciosPublicitarios /1*100/
n CategoriasPublicitarias /1*9/
e Patron Peliculas /1*8/
f Patron Espacios Publicitarios /1*3/
;

parameters
A(e,d) Patron e contempla dia d
B(f,d) Patron f contempla dia d
CategoriaC(c,n) Indica si el espacio publicitario c es de la categoría n (binario) Hay 9 categorias: (1 Moda 2 bebidas alcoholicas 3 hogar 4 videojuegos 5 computadoras 6 automoviles 7 tecnologia y electronica 8 alimentos y bebidas no alcoholicas 9 salud y bienestar)

DurP(p) Duracion de cada pelicula p en minutos
DurC(c) Duracion de cada espacio publicitario c en minutos
Aud(d,i) Puntos de audiencia en el día d para el bloque i
RevC(n) Ingreso por minuto de la categoria n
ExitoP(p) Probabilidad de éxito de cada película p
GeneroP(p,g) Indica si la pelicula p es del genero g (binario) Hay 8 categorias (1 accion y aventura 2 terror y suspenso 3 comedia y musicales 4 Drama y Romance 5 Ciencia Ficcion y fantasia 6 Documentales e Historia 7 Animacion y familiar 8 Crimen y Noir)
S(n) Define si la categoría n es incompatible
MinutosBloque /144/
;

$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\A(e,d).inc";
$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\B(f,d).inc";
$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\CategoriaC(c,n).inc";
$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\GeneroP(p,g).inc";
$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\DurP(p).inc";
$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\DurC(c).inc";
$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\S(n).inc";
$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\ExitoP(p).inc";
$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\Aud(d,i).inc"
$include "C:\Users\chris\OneDrive\Documentos\MAN\CASOS APLICADOS EN ANALITICA DE DATOS\Taller Computacional P\Taller Computacional P\CYC\incs_2\RevC(n).inc";


Variables
X(p,e,i) Binaria: Si pelicula p es asignada a esquema e en bloque i
Y(c,f,i) Binaria: Si espacio publicitario c es asignado a esquema f en bloque i
Z Función objetivo
ST(d,i)  Minutos sobrantes no utilizados en el bloque horario i del día d
;
Binary variable X(p,e,i),Y(c,f,i);
Integer variable ST(d,i);

Equations
NoSaturarPeliculas(e,d,p) Asegura que las películas no se pueden transmitir más de una vez en el mismo día.
NoSaturarComerciales(f,d,c) Asegura que los espacios publicitarios no se pueden transmitir más de una vez en el mismo día.
ComputadorasUltimoBloque(d) Asegura que al menos un espacio publicitario cuya categoría sea computadoras (n=5) debe ser programado en el último bloque horario para cada día.
DramaConAlcohol(d,i) Asegura que cada vez que se programe una película cuyo género es drama (g=4)debe acompañarse de un espacio publicitario cuya categoría sea alcohol (n=2)
NoAlcoholPrimerosBloques(d,i) Asegura que en los bloques 1 2 y 3 no pueden tener programados espacios publicitarios relacionados al alcohol (n=2).
AnimacionPrimerBloque(d) Asegura que el bloque 1 contenga al menos una película de género animación (g=7) para cada día.
CategoriasNoConsecutivas1(d,i) Asegura que las categorías de moda(n=1) bebidas alcohólicas(n=2) hogar(n=3) y videojuegos(n=4) no pueden ser programadas en dos bloques consecutivos.
CategoriasNoConsecutivas2(d,i) Asegura que las categorías de moda(n=1) bebidas alcohólicas(n=2) hogar(n=3) y videojuegos(n=4) no pueden ser programadas en dos bloques consecutivos.
CategoriasNoConsecutivas3(d,i) Asegura que las categorías de moda(n=1) bebidas alcohólicas(n=2) hogar(n=3) y videojuegos(n=4) no pueden ser programadas en dos bloques consecutivos.
CategoriasNoConsecutivas4(d,i) Asegura que las categorías de moda(n=1) bebidas alcohólicas(n=2) hogar(n=3) y videojuegos(n=4) no pueden ser programadas en dos bloques consecutivos.
ComediaPorDia(d) Asegura que se deba programar al menos una película de género comedia (g=3) cada día
BloqueDuracion(d,i) Asegura que se respeten los minutos del bloque i
ST_Definicion Es una variable que representa los minutos sobrantes no utilizados en el bloque horario i del día d
FuncionObjetivo Funcion Objetivo
;

NoSaturarPeliculas(e,d,p)..sum(i,X(p,e,i)) =L=1;
NoSaturarComerciales(f,d,c)..sum(i,Y(c,f,i))=L=1;
ComputadorasUltimoBloque(d)..sum((c,f)$(CategoriaC(c,'5') and B(f,d)), Y(c,f,'10'))=G=1;
DramaConAlcohol(d,i)..sum((p,e)$(GeneroP(p,'4') and A(e,d)), X(p,e,i))=L=sum((c,f)$(CategoriaC(c,'2') and B(f,d)), Y(c,f,i));
*Restricción de no alcohol en los primeros tres bloques
NoAlcoholPrimerosBloques(d,i)$(ord(i) <= 3)..sum((c,f)$(CategoriaC(c,'2') and B(f,d)), Y(c,f,i))=E=0;

* Restricción de película de animación en el primer bloque
AnimacionPrimerBloque(d)..sum((p,e)$(GeneroP(p,'7') and A(e,d)), X(p,e,'1')) =G= 1;

CategoriasNoConsecutivas1(d,i)$(ord(i) < 10)..sum((c,f)$(CategoriaC(c,'1') and B(f,d)), Y(c,f,i) + Y(c,f,i+1)) =L= 1;
CategoriasNoConsecutivas2(d,i)$(ord(i) < 10)..sum((c,f)$(CategoriaC(c,'2') and B(f,d)), Y(c,f,i) + Y(c,f,i+1)) =L= 1;
CategoriasNoConsecutivas3(d,i)$(ord(i) < 10)..sum((c,f)$(CategoriaC(c,'3') and B(f,d)), Y(c,f,i) + Y(c,f,i+1)) =L= 1;
CategoriasNoConsecutivas4(d,i)$(ord(i) < 10)..sum((c,f)$(CategoriaC(c,'4') and B(f,d)), Y(c,f,i) + Y(c,f,i+1)) =L= 1;

* Restricción de al menos una película de comedia por día
ComediaPorDia(d)..sum((p,e)$(GeneroP(p,'3') and A(e,d)), sum(i, X(p,e,i))) =G= 1;
BloqueDuracion(d,i)..sum(p, DurP(p) * sum(e, X(p,e,i))) + sum(c, DurC(c) * sum(f, Y(c,f,i)))=L= MinutosBloque;

ST_Definicion(d,i)..ST(d,i)=E= MinutosBloque - (sum(p, DurP(p) * sum(e, X(p,e,i))) + sum(c, DurC(c) * sum(f, Y(c,f,i))));


*FuncionObjetivo..Z=E= sum((d,i,p,e), ExitoP(p) * Aud(d,i) * (1500 * X(p,e,i) - 1450 * (1 - X(p,e,i))))+ sum((d,i,c,f,n), CategoriaC(c,n) * RevC(n) * DurC(c) * Y(c,f,i))- sum((d,i), ST(d,i) * 200);
FuncionObjetivo..Z =E= sum((p,e,d,i), (1500 * X(p,e,i) * ExitoP(p) + 50 * X(p,e,i) * (1 - ExitoP(p))) * A(e,d) * Aud(d,i))+ sum((c,f,i,d,n), Y(c,f,i) * RevC(n) * CategoriaC(c,n) * DurC(c))- 200 * sum((d,i), ST(d,i));


* Modelo
model ProgramacionTV_2 /all/;
option mip=cplex;
$onecho > cplex.opt
$offecho
ProgramacionTV_2.optfile=1
;
solve ProgramacionTV_2 using mip maximizing Z;
* Output
*display X.l, Y.l, Z.l;

execute_unload "ProgramacionTV_2.gdx" X.L, Y.L, Z.L, ST.L
execute 'gdxxrw.exe ProgramacionTV_2.gdx var=X.L rng=X!A1'
execute 'gdxxrw.exe ProgramacionTV_2.gdx var=Y.L rng=Y!A1'
execute 'gdxxrw.exe ProgramacionTV_2.gdx var=Z.L rng=Z!A1'
execute 'gdxxrw.exe ProgramacionTV_2.gdx var=ST.L rng=ST!A1'
