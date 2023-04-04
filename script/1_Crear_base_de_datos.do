*==============================================
* CREACIÓN DE LA BASE DE DATOS
*==============================================

* Limpiar la memoria del programa
*=================================
clear all 

* Definición de rutas (carpetas)
*================================
global root "C:/Users/Usuario/Desktop/Replica Cozzubo"
global data "$root/data"
global cleaned "$root/cleaned"

*--------------------------------------------------------
* Modulo 100: Características de la vivienda y del hogar
*--------------------------------------------------------

use "$data/enaho01_2007_2011_100_panel.dta", clear

*reetiquetamos algunas variables
forvalue h=7/9{
rename result_0`h' result_`h'
rename estrato_0`h' estrato_`h' 
rename p111_0`h' p111_`h'
rename t110_0`h' t110_`h' 
}

forvalue h=7/9{
rename nbi1_0`h'  nbi1_`h' 
rename nbi2_0`h'  nbi2_`h'  
rename nbi3_0`h'  nbi3_`h' 
rename nbi4_0`h'  nbi4_`h' 
}

forvalue h=7/9{
rename nbi5_0`h' nbi5_`h' 
rename p1141_0`h' p1141_`h'  
rename p1121_0`h' p1121_`h' 
rename p110_0`h'  p110_`h' 
}

*mantenemos solo las variables de interés
keep num_hog cong vivi ///
result_7 nbi1_7 nbi2_7 nbi3_7 nbi4_7 nbi5_7 estrato_7 p111_7 t110_7 p1141_7 p1121_7 p110_7 ///
result_8 nbi1_8 nbi2_8 nbi3_8 nbi4_8 nbi5_8 estrato_8 p111_8 t110_8 p1141_8 p1121_8 p110_8 ///
result_9 nbi1_9 nbi2_9 nbi3_9 nbi4_9 nbi5_9 estrato_9 p111_9 t110_9 p1141_9 p1121_9 p110_9 ///
result_10 nbi1_10 nbi2_10 nbi3_10 nbi4_10 nbi5_10 estrato_10 p111_10 t110_10 p1141_10 p1121_10 p110_10 ///
result_11 nbi1_11 nbi2_11 nbi3_11 nbi4_11 nbi5_11 estrato_11 p111_11 t110_11 p1141_11 p1121_11 p110_11 ///
    
reshape long result_ nbi1_ nbi2_ nbi3_ nbi4_ nbi5_ estrato_ p111_ t110_ p1141_ p1121_ p110_, i(num_hog cong vivi) j(año)
	
*Renombrando el  año
recode año (7=2007)(8=2008)(9=2009)(10=2010)(11=2011)

*Ordenando 
sort num_hog cong vivi año

*Nos quedamos solo con las encuestras completas e incompletas
drop if  result==3 | result==4 | result==5 | result==7 

save "$cleaned/caracteristicas_del_hogar.dta", replace

*-------------------------------------------------
* Módulo 300 - Educación
*------------------------------------------------

use "$data/enaho01a_2007_2011_300_panel.dta", clear

forvalue h=7/9{
rename p203_0`h' p203_`h'
rename p203a_0`h' p203a_`h' 
rename p203b_0`h' p203b_`h' 
rename p204_0`h' p204_`h'
}

forvalue h=7/9{
rename p206_0`h' p206_`h'
rename p207_0`h'  p207_`h' 
rename p208a_0`h' p208a_`h'  
rename p209_0`h'  p209_`h' 
}

forvalue h=7/9{
rename p300a_0`h' p300a_`h' 
rename p301a_0`h' p301a_`h' 
rename p301b_0`h' p301b_`h' 
rename hog_0`h' hog_`h' 
rename p301c_0`h' p301c_`h'
}

forvalue h=7/9{ 
rename p301d_0`h' p301d_`h'
rename ubigeo_0`h' ubigeo_`h' 
}


*mantenemos solo las variables de interés
keep num_per cong vivi ///
p203_7 p203a_7 p203b_7 p204_7 p206_7 p207_7 p208a_7 p209_7 p300a_7 p301a_7 p301b_7 p301c_7 p301d_7 hog_7 ubigeo_7 ///
p203_8 p203a_8 p203b_8 p204_8 p206_8 p207_8 p208a_8 p209_8 p300a_8 p301a_8 p301b_8 p301c_8 p301d_8 hog_8 ubigeo_8 ///
p203_9 p203a_9 p203b_9 p204_9 p206_9 p207_9 p208a_9 p209_9 p300a_9 p301a_9 p301b_9 p301c_9 p301d_9 hog_9 ubigeo_7 ///
p203_10 p203a_10 p203b_10 p204_10 p206_10 p207_10 p208a_10 p209_10 p300a_10 p301b_10 p301c_10 p301d_10 p301a_10 hog_10 ubigeo_9 ///
p203_11 p203a_11 p203b_11 p204_11 p206_11 p207_11 p208a_11 p209_11 p300a_11 p301b_11 p301c_11 p301d_11 p301a_11 hog_11 ubigeo_10 ///
    
reshape long p203_ p203a_ p203b_ p204_ p206_ p207_ p208a_ p209_ p300a_ p301a_ p301b_ p301c_ p301d_ hog_ ubigeo_, i(num_per cong vivi) j(año)
	
*Renombrando el  año
recode año (7=2007)(8=2008)(9=2009)(10=2010)(11=2011)

*Ordenando 
sort num_per cong  vivi año

*renombrando algunas variables
rename p203_ p203
rename p204_ p204
rename p206_ p206

*Nos quedamos solo con los miembros del hogar
drop if p203==0
drop if p204!=1 & p206==2

save "$cleaned/educación.dta", replace

*---------------------------------
* Módulo 400 - Salud
*---------------------------------

use "$data/enaho01A-2007-2011-400-panel.dta", clear

forvalue h=7/9{
rename p4191_0`h' p4191_`h'
rename p4192_0`h' p4192_`h' 
rename p4193_0`h' p4193_`h' 
rename p4194_0`h' p4194_`h'
}

forvalue h=7/9{
rename p4195_0`h' p4195_`h'
rename p4196_0`h' p4196_`h' 
rename p4197_0`h' p4197_`h'  
rename p4198_0`h' p4198_`h' 
}

forvalue h=7/9{
rename p4199_0`h' p4199_`h' 
}

*mantenemos solo las variables de interés
keep num_per cong vivi ///
p4191_7 p4192_7 p4193_7 p4194_7 p4195_7 p4196_7 p4197_7 p4198_7 p4199_7 ///
p4191_8 p4192_8 p4193_8 p4194_8 p4195_8 p4196_8 p4197_8 p4198_8 p4199_8 ///
p4191_9 p4192_9 p4193_9 p4194_9 p4195_9 p4196_9 p4197_9 p4198_9 p4199_9 ///
p4191_10 p4192_10 p4193_10 p4194_10 p4195_10 p4196_10 p4197_10 p4198_10 p4199_10 ///
p4191_11 p4192_11 p4193_11 p4194_11 p4195_11 p4196_11 p4197_11 p4198_11 p4199_11 ///

reshape long p4191_ p4192_ p4193_ p4194_ p4195_ p4196_ p4197_ p4198_ p4199_, i(num_per cong vivi) j(año)

*Renombrando el  año
recode año (7=2007)(8=2008)(9=2009)(10=2010)(11=2011)

*Ordenando 
sort num_per cong vivi año

save "$cleaned/salud.dta", replace


*---------------------------------
* Módulo 500 - Empleo e Ingresos
*---------------------------------
set more on
use "$data/enaho01A-2007-2011-500-panel.dta", clear

forvalue h=7/9{
rename p505_0`h' p505_`h'
rename p506_0`h' p506_`h' 
rename p513a1_0`h' p513a1_`h' 
rename ocu500_0`h' ocu500_`h'
}

*mantenemos solo las variables de interés
keep num_per cong vivi ///
p505_7 p506_7 p513a1_7 ocu500_7 ///
p505_8 p506_8 p513a1_8 ocu500_8 ///
p505_9 p506_9 p513a1_9 ocu500_9 ///
p505_10 p506_10 p513a1_10 ocu500_10 ///
p505_11 p506_11 p513a1_11 ocu500_11 ///

reshape long p505_ p506_ p513a1_ ocu500_, i(num_per cong vivi) j(año)

*Renombrando el  año
recode año (7=2007)(8=2008)(9=2009)(10=2010)(11=2011)

*Ordenando 
sort num_per cong  vivi año

save "$cleaned/empleo.dta", replace

*--------------------------
* Modulo 34 - Sumaria 2017
*--------------------------

use "$data/sumaria_2007_2011_panel.dta", clear


forvalue h=7/9{
rename mieperho_0`h' mieperho_`h'
rename pobreza_0`h'  pobreza_`h' 
rename estrato_0`h' estrato_`h' 
rename fac_0`h' fac_`h'
}

forvalue h=7/9{
rename dominio_0`h' dominio_`h'
rename ubigeo_0`h' ubigeo_`h'
rename gashog2d_0`h' gashog2d_`h'
rename linpe_0`h' linpe_`h'
}

forvalue h=7/9{
rename inghog1d_0`h' inghog1d_`h'
rename linea_0`h' linea_`h'
}


keep num_hog cong vivi ///
mieperho_7 pobreza_7 estrato_7 fac_7 dominio_7 ubigeo_7 gashog2d_7 linpe_7 linea_7 inghog1d_7 hpan0708 ///
mieperho_8 pobreza_8 estrato_8 fac_8 dominio_8 ubigeo_8 gashog2d_8 linpe_8 linea_8 inghog1d_8 hpan0809 /// 
mieperho_9 pobreza_9 estrato_9 fac_9 dominio_9 ubigeo_9 gashog2d_9 linpe_9 linea_9 inghog1d_9 hpan0910 ///
mieperho_10 pobreza_10 estrato_10 fac_10 dominio_10 ubigeo_10 gashog2d_10 linpe_10  linea_10 inghog1d_10 hpan1011 ///
mieperho_11 pobreza_11 fac_11 dominio_11 estrato_11 ubigeo_11  gashog2d_11 linpe_11 linea_11 inghog1d_11 hpan0711 ///
                
reshape long pobreza_ estrato_ mieperho_  fac_ dominio_ ubigeo_ gashog2d_ linpe_ linea_ inghog1d_ hpan0708_ hpan0809_ hpan0910_ hpan1011_ hpan0711_, i(num_hog cong vivi) j(año)

*Renombrando el  año

recode año (7=2007)(8=2008)(9=2009)(10=2010)(11=2011)

*Ordenando 

sort num_hog año

save "$cleaned/sumaria.dta", replace

*--------------------------------
* Merge - Base de datos
*--------------------------------
use "$cleaned/caracteristicas_del_hogar.dta"
merge 1:1 num_hog cong  vivi año using "$cleaned/sumaria.dta"
drop _m

save "$cleaned/data_para_análisis1.dta"

use "$cleaned/educación.dta"
sort num_per cong vivi año
mer 1:1 num_per cong vivi año using "$cleaned/salud.dta"
drop _m

sort num_per cong  vivi año
mer 1:1 num_per cong  vivi año using "$cleaned/empleo.dta"
drop _m

save "$cleaned/data_para_análisis2.dta"
