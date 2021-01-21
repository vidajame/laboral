* Stata. Ejercicio 1. Mercado de trabajo
* Enero 21 de 2020

clear all
set mem 800m
cd "C:\Users\VICTO\Documents\Observatorio de Género de Nariño\Compendio GEIH\GEIH\GEIH 2018\"
use "Geih_completo_2018 - resumen.dta"

* 1=Hombres
* 0=Mujeres

* Sexo
gen sexo=1
replace sexo=0 if p6020==2
label var sexo "sexo de la persona"
label define sexo 1"Hombre" 0"Mujer"
label value sexo sexo

* Grupos etareos quinquenales
gen quinquenios=.
replace quinquenios=1 if (p6040>=0 & p6040<=4)
replace quinquenios=2 if (p6040>=5 & p6040<=9)
replace quinquenios=3 if (p6040>=10 & p6040<=14)
replace quinquenios=4 if (p6040>=15 & p6040<=19)
replace quinquenios=5 if (p6040>=20 & p6040<=24)
replace quinquenios=6 if (p6040>=25 & p6040<=29)
replace quinquenios=7 if (p6040>=30 & p6040<=34)
replace quinquenios=8 if (p6040>=35 & p6040<=39)
replace quinquenios=9 if (p6040>=40 & p6040<=44)
replace quinquenios=10 if (p6040>=45 & p6040<=49)
replace quinquenios=11 if (p6040>=50 & p6040<=54)
replace quinquenios=12 if (p6040>=55 & p6040<=59)
replace quinquenios=13 if (p6040>=60 & p6040<=64)
replace quinquenios=14 if (p6040>=65 & p6040<=69)
replace quinquenios=15 if (p6040>=70 & p6040<=74)
replace quinquenios=16 if (p6040>=75 & p6040<=79)
replace quinquenios=17 if (p6040>=80 & p6040<=84)
replace quinquenios=18 if (p6040>=85 & p6040<=89)
replace quinquenios=19 if (p6040>=90 & p6040<=94)
replace quinquenios=20 if (p6040>=95 & p6040<=99)
replace quinquenios=21 if (p6040>=100 & p6040<=104)
replace quinquenios=22 if (p6040>=105 & p6040<=109)
replace quinquenios=23 if (p6040>=110)
label var quinquenios "edades quinquenales"
label define grupoetario2  1"Población de 0-4 años" 2"Población de 5-9 años" 3"Población de 10-14 años" 4"Población de 15-19 años" 5"Población de 20-24 años" 6"Población de 25-29 años" 7 "Población de 30-34 años" 	8 "Población de 35-39 años" 9 "Población de 40-44 años" 10 "Población de 45-49 años" 11 "Población de 50-54 años" 12 "Población de 55-59 años" 13 "Población de 60-64 años" 14 "Población de 65-69 años" 15  "Población de 70-74 años" 16 "Población de 75-79 años" 17 "Población de 80-84 años" 18 "Población de 85-89 años" 19 "Población de 90-94 años"	20 "Población de 95-99 años" 21 "Población de 100-104 años" 22 "Población de 105-109 años" 23"Población de +109 años" 
label value quinquenios quinquenios


* Nivel educativo
gen educacion=.
replace educacion=1 if p6210==1
replace educacion=2 if p6210==2
replace educacion=3 if p6210==3
replace educacion=4 if p6210==4
replace educacion=5 if p6210==5
replace educacion=6 if p6210==6
replace educacion=7 if p6210==9
label var educacion "nivel educativo alcanzado"
label define educacion 1"Ninguno" 2"Prescolar" 3"Basica primaria" 4"Basica secundaria" 5"Media" 6"Superior o universitaria" 7"Ns/Nr"
label value educacion educacion


**************** Mercado trabajo *************************

gen pet=0
replace pet = 1 if clase == "2" & p6040>=10 /*Rural*/
replace pet = 1 if clase == "1" & p6040>=12 /*Urbana*/
label var pet "Población en edad de trabajar"

gen pea=.
replace pea=0 if pet==1
replace pea=1 if oci==1 | dsi==1
label var pea "población economicamente activa"

gen ocu=.
replace ocu=0 if pet==1
replace ocu=1 if oci==1
label var ocu "población ocupada"

gen des=.
replace des=0 if pea==1
replace des=1 if dsi==1
label var des "población desocupada"

gen des_o=.
replace des_o=0 if pea==1
replace des_o=1 if p6280==2 & (p6310>=2 & p6310<=8) & p6351==1
label var des_o "desempleo oculto"

gen des_a=.
replace des_a=0 if pea==1
replace des_a=1 if des==1 & des_o!=1
label var des_a "desempleo abierto"

destring rama2d, replace /* convierte la variable a numerica tipo byte */
gen r2d=.
replace r2d=1 if (rama2d>=1 & rama2d<=2)
replace r2d=2 if rama2d==5
replace r2d=3 if (rama2d>=10 & rama2d<=14)
replace r2d=4 if (rama2d>=15 & rama2d<=37)
replace r2d=5 if (rama2d>=40 & rama2d<=41)
replace r2d=6 if rama2d==45
replace r2d=7 if (rama2d>=50 & rama2d<=52)
replace r2d=8 if rama2d==55
replace r2d=9 if (rama2d>=60 & rama2d<=64)
replace r2d=10 if (rama2d>=65 & rama2d<=67)
replace r2d=11 if (rama2d>=70 & rama2d<=74)
replace r2d=12 if rama2d==75
replace r2d=13 if rama2d==80
replace r2d=14 if rama2d==85
replace r2d=15 if (rama2d>=90 & rama2d<=93)
replace r2d=16 if rama2d==95
replace r2d=17 if rama2d==99
label var r2d "rama de actividad economica"
label define r2d 1"Agricultura, ganadería..." 2"Pesca" 3"Explotación de minas y canteras" 4"Industria manufacturera" 5"Suministro de electricidad..." 6"Construcción" 7"Comercio al por mayor y menor..." 8"Hoteles y restaurantes" 9"Transporte, almacenamiento..." 10"Intermediación financiera" 11"Actividades inmobiliarias..." 12"Administración pública y defensa..." 13"Educación" 14"Servicios sociales y de salud" 15"Otras actividades servicios..." 16"Hogares privados servicio domestico" 17"Organizaciones y organos extra..."
label value r2d r2d


gen jefe=(p6050==1)
gen compromiso=(p6070<=3)
gen conyuge=(p6050==2)
gen hijo=(p6050==3)

gen aedu=p6210s1
replace aedu=. if p6210s1==99

sort directorio secuencia_p
egen idh=group(directorio secuencia_p)

gen menores6=(p6040<6)
bysort idh: egen nmenores6=sum(menores6)

gen mayores60=(p6040>60)
bysort idh: egen nmayores60=sum(mayores60)

gen desempleados=des
replace desempleados=. if pea!=1
bysort idh: egen ndesempleados=sum(desempleados)

gen notrosdesem=ndesempleados - (1*desempleados)
replace notrosdesem = ndesempleados if ini==1 & notrosdesem==.

gen odes=(notrosdesem>0)
replace odes=. if notrosdesem==.

gen edad=p6040
gen edad2=p6040*p6040

gen hombre=(sexo==1)
gen mujer=(sexo==0)

xi:logit pea edad edad2 aedu ylm_ch, vce(robust)
mfx
*ssc install outreg2
outreg2 using laboral.xls, mfx ctitle(Mode 1 - logit)

xi:probit pea edad edad2 aedu ylm_ch, vce(robust)
mfx
outreg2 using laboral.xls, append mfx ctitle(Model 2 - probit)

xi:probit pea edad edad2 aedu hombre ylm_ch, vce(robust)
mfx
outreg2 using laboral.xls, append mfx ctitle(Model 3 - probit) 

xi:probit pea edad edad2 aedu mujer ylm_ch, vce(robust)
mfx
outreg2 using laboral.xls, append mfx ctitle(Model 4 - probit)


xi:probit pea edad edad2 aedu mujer jefe ylm_ch, vce(robust)
mfx
outreg2 using laboral.xls, append mfx ctitle(Model 4 - probit) adds("LR chi2(`=e(df_m)') ", e(chi2), Prob > chi2, e(p))

















