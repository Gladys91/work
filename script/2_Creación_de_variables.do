*==============================================
* CREACIÓN DE VARIABLES
*==============================================

* Limpiar la memoria del programa
*=================================
clear all 

* Definición de rutas (carpetas)
*================================
global root "C:/Users/Usuario/Desktop/Replica Cozzubo"
global data "$root/data"
global cleaned "$root/cleaned"


*--------------------------------
* Renombrando algunas variables
*--------------------------------
use "$cleaned/data_para_análisis1.dta", clear
rename cong conglome
rename vivi vivienda
rename estrato_ estrato
rename result_ result
rename nbi1_ nbi1
rename nbi2_ nbi2
rename nbi3_ nbi3
rename nbi4_ nbi4
rename nbi5_ nbi5
rename fac_ factor07
rename mieperho_ mieperho
rename gashog2d_ gashog2d
rename linpe_ linpe
rename linea_ linea 
rename pobreza_ pobreza
rename año aniorec
rename dominio_ dominio
rename inghog1d_ inghog1d
save "$cleaned/data_para_análisis1.dta", replace


use "$cleaned/data_para_análisis2.dta", clear
rename p209_ p209 
rename p203_ p203
rename p203b_ p203b
rename p300a_ p30a
rename p301a_ p301a
rename p301b_ p301b
rename p301c_ p301c
rename p301d_ p301d
rename p207_ p207
rename p208_ p208
rename estrato_ estrato
rename dominio_ dominio
rename ubigeo_ ubigeo
save "$cleaned/data_para_análisis2.dta", replace

*Trabajando algunas variables
*======================================
* Cantidad de Núcleos Familiares en el Hogar
rename p203a nucleo
label variable nucleo "Cantidad de Nucleos Familiares en el Hogar"

* Relación de parentesco con jefe del hogar
rename p203 parent
label variable parent "Parentesco con el jefe del hogar"
label define parent 0 "Persona PANEL no presente actualmente" 1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a)" 4 "Yerno/nuera" 5 "Nieto(a)" ///
6 "Padres/suegros" 7 "Otros parientes" 8 "Trabajador con cama dentro" 9 "Pensionista" 10 "Otros no parientes"
label values parent parent

* Parentesco con el jefe del núcleo familiar
rename p203b parent_fam
label variable parent_fam "Parentesco con el jefe del nucleo familiar"
label define parent_fam 1 "Jefe(a)" 2 "Esposo(a)" 3 "Hijo(a)" 6 "Padres/suegros" 7 "Otros parientes"
label values parent_fam parent_fam

* Jefatura del Hogar y Familia
gen jefe=(parent_fam==1) if !missing(parent_fam)
label variable jefe "Jefe Familiar"
label values jefe yn

* Estado Civil/Conyugal
rename p209 civil
label variable civil "Estado Civil"
label define civil 1 "Conviviente" 2 "Casado(a)" 3 "Viudo(a)" 4 "Divorciado(a)" 5 "Separado(a)" 6 "Soltero(a)"
label values civil civil

* Couple
gen couple=(civil<=2)
label variable couple "Casado o Conviviente"
label values couple yn

* Lengua Materna
rename p300a lengua
replace lengua=. if lengua==9
label variable lengua "Lengua Materna"

* Categoría (Lengua Materna)
gen lenguacat=.
label variable lenguacat "Categoría de Lengua Materna"
replace lenguacat=1 if lengua==4 & !missing(lengua) 
replace lenguacat=2 if lengua<4 & !missing(lengua) 
replace lenguacat=3 if lengua>4 & lengua<8 & !missing(lengua)
replace lenguacat=4 if lengua==8 & !missing(lengua) 
label define lenguacat 1 "Castellano" 2 "Quechua/Aymara/Otra lengua nativa" ///
3 "Inglés/Portugués/Otra lengua extranjera" 4 "Sordo mudo"
label values lenguacat lenguacat

* Nivel educativo
gen educ=.
replace educ=0 if p301a==1 | p301a==2
replace educ=1 if p301a==3 | p301a==4
replace educ=2 if p301a==5 | p301a==6
replace educ=3 if p301a==7 | p301a==8
replace educ=4 if p301a==9 | p301a==10
replace educ=5 if p301a==11
label variable educ "Nivel educativo"
label define niveduc 0 "Sin nivel" 1 "Primaria" 2 "Secundaria" 3 "Superior no universitaria" 4 "Superior universitaria" 5 "Postgrado" 
label values educ niveduc

* Escolaridad (años)
gen sch=.
replace sch=0  if p301a==1 | p301a==2 					                                                            // Sin nivel, nivel inicial
replace sch=0  if p301a==3 & (p301b==0 & p301c==0)																    // Sin nivel :799
replace sch=1  if (p301a==3 & p301b==1) | (p301a==3 & p301c==1) | (p301a==4 & p301b==1) | (p301a==4 & p301c==1)     // 1 año  
replace sch=2  if (p301a==3 & p301b==2) | (p301a==3 & p301c==2) | (p301a==4 & p301b==2) | (p301a==4 & p301c==2)     // 2 años
replace sch=3  if (p301a==3 & p301b==3) | (p301a==3 & p301c==3) | (p301a==4 & p301b==3) | (p301a==4 & p301c==3)     // 3 años
replace sch=4  if (p301a==3 & p301b==4) | (p301a==3 & p301c==4) | (p301a==4 & p301b==4) | (p301a==4 & p301c==4)     // 4 años
replace sch=5  if (p301a==3 & p301b==5) | (p301a==3 & p301c==5) | (p301a==4 & p301b==5) | (p301a==4 & p301c==5)     // 5 años
replace sch=6  if (p301a==3 & p301b==6) | (p301a==3 & p301c==6) | (p301a==4 & p301b==6) | (p301a==4 & p301c==6)     // 6 años
replace sch=7  if (p301a==5 & p301b==1) | (p301a==6 & p301b==1)                                                     // 7 años
replace sch=8  if (p301a==5 & p301b==2) | (p301a==6 & p301b==2)   											        // 8 años
replace sch=9  if (p301a==5 & p301b==3) | (p301a==6 & p301b==3)   												    // 9 años
replace sch=10 if (p301a==5 & p301b==4) | (p301a==6 & p301b==4)   												    // 10 años
replace sch=11 if (p301a==5 & p301b==5) | (p301a==6 & p301b==5)   												    // 11 años
replace sch=12 if (p301a==6 & p301b==6) 																			// Secundaria
replace sch=12 if (p301a==7 & p301b==1) | (p301a==8 & p301b==1) | (p301a==9 & p301b==1) | (p301a==10 & p301b==1)   // 12 años
replace sch=13 if (p301a==7 & p301b==2) | (p301a==8 & p301b==2) | (p301a==9 & p301b==2) | (p301a==10 & p301b==2)   // 13 años
replace sch=14 if (p301a==7 & p301b==3) | (p301a==8 & p301b==3) | (p301a==9 & p301b==3) | (p301a==10 & p301b==3)   // 14 años
replace sch=15 if (p301a==7 & p301b==4) | (p301a==8 & p301b==4) | (p301a==9 & p301b==4) | (p301a==10 & p301b==4)   // 15 años
replace sch=16 if (p301a==7 & p301b==5) | (p301a==8 & p301b==5) | (p301a==9 & p301b==5) | (p301a==10 & p301b==5)   // 16 años
replace sch=17 if (p301a==9 & p301b==6) | (p301a==10 & p301b==6) | (p301a==11 & p301b==1)
replace sch=18 if (p301a==9 & p301b==7) | (p301a==10 & p301b==7) | (p301a==11 & p301b==2)
label variable sch "Escolaridad (años)"

* Sexo
recode p207 (2=0 "Mujer") (1=1 "Hombre"), gen(male)
label variable male "Sexo"

* Edad
rename p208 age
label variable age "Edad"

*Establecer a los datos como un panel de datos
xtset num_hog aniorec