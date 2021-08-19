    *****************************************************************************************************	
    *2. Utilizar las variables que nos interesan de la hoja "EquipoLocal" del excel info_consolidada
    *****************************************************************************************************
    use "$data_clean/equipo_local.dta", clear 
	
    drop ancho_banda_total
    gen  Mpbs_total = TOTAL_BAJADA

    replace ancho_banda_promedio = "0" if ancho_banda_promedio=="-"
    destring ancho_banda_promedio, replace
	 
    replace dispositivos_total= "0" if dispositivos_total=="-"
    destring dispositivos_total, replace
    rename dispositivos_total dispositivos_2020

    rename rango_ancho_banda_total Mpbs_total_rango
    rename ancho_banda_promedio  Mpbs_Xdisp
    rename ancho_banda_calidad Mpbs_calidad
    replace Mpbs_calidad = "" if Mpbs_calidad == "-"

    keep cod_local_2 TOTAL_PROVE TOTAL_ESTADO TOTAL_MEDIO_TRANS2 TOTAL_BAJADA TOTAL_SUBIDA TOTAL_GARANTIZADO TOTAL_ACCESOS PRONATEL_1 PRONATEL_2 PRONATEL_3 PRONATEL_4 OTIC_1 OTIC_1 OTIC_2  pc_4 notebook_4 laptopXO_4 tablet_4 dispositivos_2020 Mpbs_total Mpbs_total_rango Mpbs_Xdisp Mpbs_calidad

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
	

	*d. Guardar base construida
	*************************************************************
		
		save "$data_clean/base_construida.dta", replace

