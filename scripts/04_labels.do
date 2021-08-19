

			use "$data_clean/base_costeo.dta", clear 
			
***************************************************************************************************************
*8. FORMATO DE LAS VARIABLES Y BASE DE DATOS* 
***************************************************************************************************************
            label variable  cod_local_2 "Código Local"
			label variable  D_COD_CAR "Relación entre el número de docentes y el número de secciones que atienden (solo primaria)"
			label variable  D_DPTO "Departamento"
            label variable  D_PROV "Provincia"
			label variable  D_DIST "Distrito"
			label variable  D_REGION "Dirección Regional de Educación"
			label variable  D_DREUGEL "DRE o UEL que supervisa la IE"
			label variable  VRAEM "VRAEM"
			label variable  VRAEM_INTERV "Tipo de invervención VRAEM"
			label variable  FRONTERA "Frontera"
			label variable  COAR "COAR"
			label variable  GRADIENTE "Gradiente Ruralidad"
			label variable  QUINTIL_FINAL "Quintil de Pobreza"
			label variable  DAREACENSO "Área"
			label variable  TotalMatricula "Total Matricula"
			label variable  total_mat4to "Total de matrículas de acuerdo al nivel (primaria o secundaria"
			label variable  TDOCENTE_CE2020 "Total de docentes del servicio educativo (CE 2020)"			
			label variable  TOTAL_PROVE "Proveedor"
			label variable  TOTAL_ESTADO "Estado conexión"
			label variable  TOTAL_MEDIO_TRANS2 "Medio de Transmisión"
			label variable  TOTAL_BAJADA "Mgbs Bajada"
			label variable  TOTAL_SUBIDA "Mgbs Subida"
			label variable  TOTAL_GARANTIZADO "Internet Garantizado"
			label variable  TOTAL_ACCESOS "Total de Accesos"
			label variable  PRONATEL_1  "Proyecto PRONATEL 1"
			label variable  PRONATEL_2 "Proyecto PRONATEL 2"
			label variable  PRONATEL_3 "Proyecto PRONATEL 3"
			label variable  PRONATEL_4 "Proyecto PRONATEL 4"
			label variable  OTIC_1 "OTIC 1"
			label variable  OTIC_2 "OTIC 2"
			label variable  num_operadores_SM_T "Número de operadores que ofrecen Servicio Móvil (independientemente de la tecnología)"
			label variable  num_operadores_SM_2G "Número de operadores que ofrecen Servicio Móvil 2G"
			label variable  num_operadores_SM_3G "Número de operadores que ofrecen Servicio Móvil 3G"
			label variable  num_operadores_SM_4G "Número de operadores que ofrecen Servicio Móvil 4G"
			label variable  num_operadores_IF "Número de operadores que ofrecen Internet Fijo"
			label variable  internet_UE "Internet de acuerdo a la Información de la Unidad de Estadistica (1)"
			label variable  internet_OTIC "Internet - escuela cuenta con un contrato de MINEDU o MTC (2)"
			label variable  internet_OTICyUE "Internet por (1) o (2)"
			label variable  CALIDAD_COBERTURA_FIJO_3T2019 "Calidad Cobertura 3T2019"
			label variable  CALIDAD_COBERTURA_2T2020 "Calidad Cobertura 2T2020"
			label variable FASE1 "Servicio educativo focalizado y priorizado en la Fase 1"
			label variable FASE2 "Servicio educativo focalizado y priorizado en la Fase 2"
            label variable FASE1o2 "Servicio educativo focalizado y priorizado en la Fase 1 y Fase 2"
            label variable F1o2_Estudiantes	"Total de estudiantes beneficiarios de tablets en Fase 1 y Fase 2"
            label variable F1o2_Estudiantes_Internet "Total de estudiantes beneficiarios de tablets con internet en Fase 1 y Fase 2"
            label variable F1o2_Estudiantes_Ncargador "Total de estudiantes beneficiarios de cargador solar en Fase 1 y Fase 2"
            label variable F1o2_Docentes "Total de docentes beneficiarios de tablets en Fase 1 y Fase 2"
            label variable F102_Docentes_Internet "Total de docentes beneficiarios de tablets con internet en Fase 1 y Fase 2"
            label variable F1o2_Docentes_Ncargador	"Total de docentes beneficiarios de cargador solar en Fase 1 y Fase 2"
			label variable INCLUYE_CHIP "estudiantes/docentes del IE beneficiarios de chip con internet en las tablets"
			label variable dispositivos_2021 "Dispositivos en 2021"		
			label variable nueva_cobertura_electricidad "Cobertura de electricidad"
			label variable electricidad_local "Electricidad local"
			label variable tipo_internet_costeo "Tipo de internet 1 (operador/satelital)"
		    label variable tipo_internet_costeo_2 "Tipo de internet 2 (operados/satelital/microserver)"
			label variable estandar_internet_2021 "Estandar de internet 2021"
			label variable estandar_internet_2022 "Estandar de internet 2022"
			label variable Mpbs_total "Total Mbps actualmente en la escuela"
			label variable Mpbs_total_rango "Rango - Total Mgbs actualmente en la escuela"
			label variable Mpbs_Xdisp "Mbps por dispositivo en la escuela"	
			label variable Mpbs_calidad "Internet de la escuela cumple con el estandar de calidad"
	
			label variable Mpbs_E0 "Demanda de Mbps 2020"
			label variable cost_uniE0 "Costo unitario de la demanda de Mbps 2020"
			label variable cost_anualE0 "Costo variable anual de los Mbps 2020"
			label variable Mpbs_E1 "Demanda de Mbps 2021"
		    label variable cost_uniE1 "Costo unitario de la demanda de Mbps 2021"
		    label variable cost_anualE1 "Costo variable anual de los Mbps 2021"	
			label variable costo_ope_sat "Costo fijo Operador o Satelital"
			label variable Microserver_BM "Número de microservers focalizados por el Banco Mundial (Fase 1 y Fase 2)"
			label variable Microserver_Minedu "Número de microservers focalizados por el Minedu (Fase 1 y Fase 2)"
			label variable N_microserver "Total de Microserver"
		
		    label variable costo_microserver_1 "Costo unitario del microserver"
			label variable costo_microserver_2 "Costo fijo del modelado y transporte-Microserver"
			label variable costo_total_microservers "Costo total de microservers"
			label variable tablet_E1 "Costo tablets"
			
			
			 order cod_local_2 D_COD_CAR D_DPTO D_PROV D_DIST D_REGION D_DREUGEL VRAEM VRAEM_INTERV FRONTERA COAR GRADIENTE QUINTIL_FINAL DAREACENSO TotalMatricula  total_mat4to TDOCENTE_CE2020 TOTAL_PROVE TOTAL_ESTADO TOTAL_MEDIO_TRANS2 TOTAL_BAJADA TOTAL_SUBIDA TOTAL_GARANTIZADO TOTAL_ACCESOS PRONATEL_1 PRONATEL_2 PRONATEL_3 PRONATEL_4 OTIC_1 OTIC_2 num_operadores_SM_T num_operadores_SM_2G num_operadores_SM_3G num_operadores_SM_4G num_operadores_IF internet_OTIC internet_UE internet_OTICyUE CALIDAD_COBERTURA_FIJO_3T2019 CALIDAD_COBERTURA_2T2020 FASE1 FASE2 FASE1o2 F1o2_Estudiantes F1o2_Estudiantes_Internet F1o2_Estudiantes_Ncargador F1o2_Docentes F102_Docentes_Internet F1o2_Docentes_Ncargador INCLUYE_CHIP dispositivos_2021 nueva_cobertura_electricidad electricidad_local tipo_internet_costeo tipo_internet_costeo_2 estandar_internet_2021 estandar_internet_2022 Mpbs_total Mpbs_total_rango Mpbs_Xdisp Mpbs_calidad Mpbs_E0 cost_uniE0 cost_anualE0 Mpbs_E1 cost_uniE1 cost_anualE1 costo_ope_sat Microserver_BM Microserver_Minedu N_microserver costo_microserver_1 costo_microserver_2 costo_total_microservers 

*sort cod_local_2 
*quietly by cod_local_2: gen dup = cond(_N==1,0,_n)
*save "$root\Output\basefinal.dta", replace
	 
	 *Exportar base de datos 
	  ************************
	  export excel "$root\Output\BaseFinal_BrechaDigital.xlsx", firstrow(varlabels) replace
