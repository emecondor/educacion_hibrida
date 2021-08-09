*****************************************************************************************************	
*2. Utilizar las variables que nos interesan de la hoja "EquipoLocal" del excel info_consolidada
*****************************************************************************************************
    use "$data_clean/equipo_local.dta", clear 
	
    drop ancho_banda_total
    gen  Mgbs_total = TOTAL_BAJADA

    replace ancho_banda_promedio = "0" if ancho_banda_promedio=="-"
    destring ancho_banda_promedio, replace
	 
    replace dispositivos_total= "0" if dispositivos_total=="-"
    destring dispositivos_total, replace
    rename dispositivos_total dispositivos_2020

    rename rango_ancho_banda_total Mgbs_total_rango
    rename ancho_banda_promedio  Mgbs_Xdisp
    rename ancho_banda_calidad Mgbs_calidad
    replace Mgbs_calidad = "" if Mgbs_calidad == "-"

    keep cod_local_2 TOTAL_PROVE TOTAL_ESTADO TOTAL_MEDIO_TRANS2 TOTAL_BAJADA TOTAL_SUBIDA TOTAL_GARANTIZADO TOTAL_ACCESOS PRONATEL_1 PRONATEL_2 PRONATEL_3 PRONATEL_4 OTIC_1 OTIC_1 OTIC_2  pc_4 notebook_4 laptopXO_4 tablet_4 dispositivos_2020 Mgbs_total Mgbs_total_rango Mgbs_Xdisp Mgbs_calidad

***************************************	
*3.Merge de todas las bases de datos 
***************************************
	 
	*a. Merge con base de datos de la hoja cod_mod del excel info_consolidada (Punto 1 del dofile)
	***********************************************************************************************
	merge 1:1 cod_local_2 using "$data_clean/cod_mod_coll.dta"
	drop if _merge==1 //son codigos locales que no tienen primaria o secundaria
	drop _merge
		 
	replace GRADIENTE = "Urbano" if GRADIENTE ==""
	
	*b. hacer merge con base de internet MTC  (Punto 0 del dofile)
	***************************************************************
	merge 1:1 cod_local_2 using "$data_clean/num_operadores_mtc.dta"
	drop if _merge==2 //son codigos locales que no tienen primaria o secundaria
	drop _merge

	
	*c. hacer merge con base de microservers
	*************************************************************
	merge 1:1 cod_local_2 using "$data_clean/Base_Microservers.dta"
	drop _merge
	
*************************************
*4. Generar variables- Internet
*************************************
    rename internet_local internet_UE
	  
    gen internet_OTIC = "no"
    replace internet_OTIC = "si" if TOTAL_PROVE != ""
    replace internet_OTIC = "si" if PRONATEL_2 == "EN OPERACIÓN"
    label variable internet_OTIC "el local educativo cuenta con internet por alguno de los contratos de OTIC o MTC"
	  
    gen internet_OTICyUE = ""
    replace internet_OTICyUE = "si" if internet_OTIC == "si" & (internet_UE == "No" | internet_UE == "n.d.") //solo OTIC
    replace internet_OTICyUE = "si" if internet_OTIC == "no" & internet_UE == "Sí" // solo UE
    replace internet_OTICyUE = "si" if internet_OTIC == "si" & internet_UE == "Sí" // OTIC y UE
    replace internet_OTICyUE = "no" if internet_OTIC == "no" & (internet_UE == "No" | internet_UE == "n.d.") //ninguno
    label variable internet_OTICyUE "el local educativo cuenta con internet por alguno de los contratos de OTIC o MTC o identificado por el censo educativo"

    gen dispositivos_2021 = dispositivos_2020 + F1o2_Estudiantes

     *a.  Tipo de Internet (Operador y Satelital) 
      **************************************************
      gen tipo_internet_costeo = "satelital"
      replace tipo_internet_costeo = "operador" if num_operadores_SM_4G>0 | num_operadores_IF>0
      replace tipo_internet_costeo ="operador" if TOTAL_MEDIO_TRANS2 == "ADSL"  | TOTAL_MEDIO_TRANS2 == "FIBRA OPTICA"  | TOTAL_MEDIO_TRANS2 == "RED MOVIL"  | TOTAL_MEDIO_TRANS2 == "WIFI"

     *b. Tipo de Internet (Operador, Satelital, Microserver) 
      *************************************************************
      gen tipo_internet_costeo_2 = tipo_internet_costeo
      replace N_microserver = 0 if N_microserver ==. 
      replace tipo_internet_costeo_2="microserver" if N_microserver>0

	*c. Guardar base construida
	*************************************************************
		
		save "$data_clean/base_construida.dta", replace

