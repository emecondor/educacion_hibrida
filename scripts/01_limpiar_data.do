
    *****************************************
    *1. GUARDAR BASES DE DATOS EN FORMATO DTA*
    *****************************************

    *******************************
    *Base de codigos modulares*
    *******************************	
    import excel using "$data_raw/inf_consolidado.xlsx", sheet(cod_mod) firstrow clear
	save "$data_clean/cod_mod.dta", replace

    ******************************
    *Base de locales educativos*
    ******************************	
	import excel using "$data_raw/inf_consolidado.xlsx", sheet(equipo_por_local) firstrow clear
	save "$data_clean/equipo_local.dta", replace 
	
	*************************************
    *Base de CONECTIVIDAD + PLAN DE DATOS*
    *************************************
	import excel using "$data_raw/210607 DATA DE CONECTIVIDAD + Plan de datos Final_01.02.2021 + CODCPINEI....xlsx", sheet("Data_Consolidada + MTC") firstrow clear 
	keep   CÓDIGODELOCAL Servicio_Movil_F Servicio_Movil_2G Servicio_Movil_3G Servicio_Movil_4G Internet_Fijo
	rename CÓDIGODELOCAL cod_local_2
	rename Servicio_Movil_F num_operadores_SM_T
	rename Servicio_Movil_2G num_operadores_SM_2G
	rename Servicio_Movil_3G num_operadores_SM_3G
	rename Servicio_Movil_4G num_operadores_SM_4G
	rename Internet_Fijo num_operadores_IF
	save "$data_clean/num_operadores_mtc.dta", replace
	
	****************************
    *Base de Microservers* 
    ****************************
    import excel using "$data_raw/Base_Microservers.xlsx", sheet("BBDD") firstrow clear 
    keep cod_local_2 Microserver_BM Microserver_Minedu
    gen N_microserver= Microserver_BM + Microserver_Minedu
    collapse (sum) N_microserver Microserver_BM Microserver_Minedu, by(cod_local_2)

    *egen x= sum(N_microserver)
    *sort cod_local_2 
    *quietly by cod_local_2: gen dup = cond(_N==1,0,_n)
    *export excel "$root\Output\microservers.xlsx", firstrow(varlabels) replace
	  
    save "$data_clean/Base_Microservers.dta", replace
	
    ****************************************************
    *Base de COD_MOD para generar Fase 1 y Fase 2*
    ****************************************************
	use "$data_clean/cod_mod.dta", clear
	keep if D_NIV_MOD == "Primaria"  | D_NIV_MOD == "Secundaria"
	sort D_NIV_MOD
	by D_NIV_MOD: sum TotalMatricula

	gen total_mat4to = 0 
	replace total_mat4to = mat04g + mat05g + mat06g if D_NIV_MOD== "Primaria" 
	replace total_mat4to = mat01g + mat02g + mat03g + mat04g + mat05g + mat06g if D_NIV_MOD=="Secundaria"
	
	replace TDOCENTE_CE2020 ="" if TDOCENTE_CE2020 == "n.d."
	destring TDOCENTE_CE2020, replace
	
	replace FASE1 = 0 if FASE1==.
	replace FASE2 = 0 if FASE2==.
	replace F1_Estudiantes = 0 if F1_Estudiantes ==.
	replace F2_Estudiantes = 0 if F2_Estudiantes ==.
	replace F1_Estudiantes_Internet  = 0 if F1_Estudiantes_Internet==.
	replace F2_Estudiantes_Internet = 0 if F2_Estudiantes_Internet==.
	replace F1_Estudiantes_Ncargador = 0 if F1_Estudiantes_Ncargador==.
	replace F2_Estudiantes_Ncargador = 0 if F2_Estudiantes_Ncargador==.
	replace F1_Docentes = 0 if F1_Docentes==.
	replace F1_Docentes = 0 if F1_Docentes==.
	replace F1_Docentes_Internet  = 0 if  F1_Docentes_Internet==.
	replace F2_Docentes_Internet = 0 if F2_Docentes_Internet==.
	replace F1_Docentes_Ncargador  = 0 if F1_Docentes_Ncargador==.
	replace F2_Docentes_Ncargador= 0 if F2_Docentes_Ncargador==.
	
	gen FASE1o2= FASE1 + FASE2 
	gen F1o2_Estudiantes = F1_Estudiantes + F2_Estudiantes
	gen F1o2_Estudiantes_Internet = F1_Estudiantes_Internet + F2_Estudiantes_Internet 
	gen F1o2_Estudiantes_Ncargador = F1_Estudiantes_Ncargador  + F2_Estudiantes_Ncargador 
	gen F1o2_Docentes = F1_Docentes  + F2_Docentes 
	gen F102_Docentes_Internet = F1_Docentes_Internet + F2_Docentes_Internet 
	gen F1o2_Docentes_Ncargador = F1_Docentes_Ncargador + F2_Docentes_Ncargador
	
	collapse (first) internet_local GRADIENTE QUINTIL_FINAL DAREACENSO D_COD_CAR D_DPTO D_PROV D_DIST D_REGION D_DREUGEL VRAEM VRAEM_INTERV FRONTERA COAR INCLUYE_CHIP electricidad_local cobertura_electricidad CALIDAD_COBERTURA_FIJO_3T2019 CALIDAD_COBERTURA_2T2020 D_NIV_MOD (sum) TotalMatricula FASE1 FASE2 FASE1o2 F1o2_Estudiantes  F1o2_Estudiantes_Internet F1o2_Estudiantes_Ncargador F1o2_Docentes F102_Docentes_Internet F1o2_Docentes_Ncargador TDOCENTE_CE2020 total_mat4to mat01g mat02g mat03g mat04g mat05g mat06g, by(CODLOCAL)
	
	replace FASE1o2 = 1 if FASE1o2 > 0

	rename CODLOCAL cod_local_2
	save "$data_clean/cod_mod_coll.dta", replace
	//table internet_local, c(sum TotalMatricula) row col 
