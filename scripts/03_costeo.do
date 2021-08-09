**********************************************************************************************************************************************************	
*5. Costos del requerimiento de Mgbs para cubrir los dispositivos actuales (2020) y 2021; según tipo de internet (operador, satelital)
**********************************************************************************************************************************************************
				use "$data_clean/base_construida.dta", clear 

	
			     *a. Internet para cubrir los dispositivos actuales (2020)
			     *********************************************************
		
				 *Requerimiento de Megabytes, lo minimo por dispositivo en la escuela
				
				 gen Mgbs_E0 = round(0.55 * dispositivos_2020,1)  // le damos el 100% de la demanda de Mgbs por dispositivo disponible
				 replace Mgbs_E0 = max(Mgbs_E0 - Mgbs_total,0) if internet_OTIC=="si" //si tiene internet le damos solo lo que requiere de la demanda
		         gen cost_uniE0=.
				
				 *Internet de operador cuando es urbano o el MTC ha indicado que hay internet fijo o movil en la zona
				 replace cost_uniE0=Mgbs_E0*45 if  tipo_internet_costeo_2 == "operador" & Mgbs_E0>0 & Mgbs_E0<4 
				 replace cost_uniE0=167 if tipo_internet_costeo_2 == "operador" & Mgbs_E0>=4  & Mgbs_E0<6
				 replace cost_uniE0=177 if tipo_internet_costeo_2 == "operador" & Mgbs_E0>=6 & Mgbs_E0< 8
				 replace cost_uniE0=197 if tipo_internet_costeo_2 == "operador" & Mgbs_E0>=8 & Mgbs_E0<10
				 replace cost_uniE0=217 if tipo_internet_costeo_2 == "operador" & Mgbs_E0>=10 & Mgbs_E0<15
				 replace cost_uniE0=267 if tipo_internet_costeo_2 == "operador" & Mgbs_E0>=15 & Mgbs_E0<20
				 replace cost_uniE0=327 if tipo_internet_costeo_2 == "operador" & Mgbs_E0>=20
				
				 *Internet satelital cuando es rural
				 replace cost_uniE0= 645*Mgbs_E0 if Mgbs_E0>0 & Mgbs_E0<4 &  tipo_internet_costeo_2 == "satelital"
				 replace cost_uniE0= 2560+645*(Mgbs_E0-5) if Mgbs_E0>=4  & tipo_internet_costeo_2 == "satelital"
				 recode cost_uniE0 (.=0)
				
				
				*Generar el costo unitario anual
				 gen cost_anualE0= 12*cost_uniE0
				

			    *b. Internet para cubrir los dipositivos 2021- 1:1 a todos los alumnos
			    **********************************************************************
				 gen Mgbs_E1 = round(0.55 * dispositivos_2021,1)
				 replace Mgbs_E1 = max(Mgbs_E1 - Mgbs_total ,0) if internet_OTIC=="si" //si tiene internet le damos solo lo que requiere de la demanda
				
				 gen cost_uniE1=.
			
				*Internet de operador cuando es urbano o el MTC ha indicado que hay internet fijo o movil en la zona
				 replace cost_uniE1=Mgbs_E1*45 if tipo_internet_costeo_2 == "operador" & Mgbs_E1>0 & Mgbs_E1<4 
				 replace cost_uniE1=167 if tipo_internet_costeo_2 == "operador" & Mgbs_E1>=4  & Mgbs_E1<6
				 replace cost_uniE1=177 if tipo_internet_costeo_2 == "operador" & Mgbs_E1>=6 & Mgbs_E1<8
				 replace cost_uniE1=197 if tipo_internet_costeo_2 == "operador" & Mgbs_E1>=8 & Mgbs_E1<10
				 replace cost_uniE1=217 if tipo_internet_costeo_2 == "operador" & Mgbs_E1>=10 & Mgbs_E1<15
				 replace cost_uniE1=267 if tipo_internet_costeo_2 == "operador" & Mgbs_E1>=15 & Mgbs_E1<20
				 replace cost_uniE1=327 if tipo_internet_costeo_2 == "operador" & Mgbs_E1>=20
				
				 *Internet satelital cuando es rural
				 replace cost_uniE1=645*Mgbs_E1 if Mgbs_E1>0 & Mgbs_E1<4 &  tipo_internet_costeo_2 == "satelital"
				 replace cost_uniE1=2560+645*(Mgbs_E1-5) if Mgbs_E1>=4  & tipo_internet_costeo_2 == "satelital"
				 recode cost_uniE1 (.=0)
				
				 *Generar el costo unitario anual
				 gen cost_anualE1= 12*cost_uniE1

				 
				 *Costos fijos del tipo de internet (operador, satelital)- para el calculo se utilizó formatos de contratos
                 **************************************************************************************************************
                 gen costo_ope_sat= 10784.70 if tipo_internet_costeo== "operador"
                 replace costo_ope_sat= 10422.31 if tipo_internet_costeo== "satelital"
				 
				 *Crear la variable "Estandar de internet 2021"
				 gen estandar_internet_2021= "No tiene internet" if Mgbs_total== 0
				 replace estandar_internet_2021= Mgbs_calidad if Mgbs_total!= 0
				 
				 *Crear la variable "Estandar de internet 2022"
				 gen estandar_internet_2022= "Se compra microserver" if tipo_internet_costeo_2== "microserver" 
				 
                 replace estandar_internet_2022= "Ya no se requiere más internet" if tipo_internet_costeo_2== "operador" & Mgbs_E1== 0
				 
				 replace estandar_internet_2022= "Se compra más internet" if tipo_internet_costeo_2== "operador" & Mgbs_E1!= 0
				 
				 replace estandar_internet_2022= "No se atiende" if tipo_internet_costeo_2== "satelital" 
				 
		  
				 *br tipo_internet_costeo_2 estandar_internet_2022 Mgbs_E1
				 
				 *br Mgbs_total estandar_internet_2021
				 
	             *Costo de compra de tablets
	             *****************************
		         gen tablet_E1 = 724 * dispositivos_2021	
				 
				 		
**********************************************************************
*6. Costos de microservers
**********************************************************************
		
		     *a. Crear la variable para llenar los espacios de electricidad y sin electricidad 
			 
		      gen nueva_cobertura_electricidad= cobertura_electricidad 
		      replace nueva_cobertura_electricidad= "CON ELECTRICIDAD" if cobertura_electricidad=="" & (GRADIENTE=="Rural 1" | GRADIENTE=="Rural 2" | GRADIENTE=="Urbano")
		      replace nueva_cobertura_electricidad= "SIN ELECTRICIDAD" if cobertura_electricidad=="" & GRADIENTE=="Rural 3"

			 *b. Hallar costo variable de microserver (costo_microserver_1)
			 
			 *si tiene electricidad sin cargador =2600
		     *no tiene electricidad con cargador = 3600
		
		     gen costo_microserver_1=. 
		
		     replace costo_microserver_1= 2600 if nueva_cobertura_electricidad== "CON ELECTRICIDAD"
		     replace costo_microserver_1= 3600 if nueva_cobertura_electricidad== "SIN ELECTRICIDAD"
		     replace costo_microserver_1= 2600 if nueva_cobertura_electricidad=="" & (GRADIENTE=="Rural 1"| GRADIENTE=="Rural 2" | GRADIENTE=="Urbano")		
		     replace costo_microserver_1= 3600 if nueva_cobertura_electricidad=="" & GRADIENTE=="Rural 3"
		
	         *c. Hallar costo fijo de microserver (costo_microserver_2)
			 gen costo_microserver_2= 21.29 
		
		     *d. Hallar costo total de microservers 
		     gen costo_total_microservers= N_microserver *(costo_microserver_1 + costo_microserver_2) + 1.03 


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
			label variable Mgbs_total "Total Mbps actualmente en la escuela"
			label variable Mgbs_total_rango "Rango - Total Mgbs actualmente en la escuela"
			label variable Mgbs_Xdisp "Mbps por dispositivo en la escuela"	
			label variable Mgbs_calidad "Internet de la escuela cumple con el estandar de calidad"
	
			label variable Mgbs_E0 "Demanda de Mbps 2020"
			label variable cost_uniE0 "Costo unitario de la demanda de Mbps 2020"
			label variable cost_anualE0 "Costo variable anual de los Mbps 2020"
			label variable Mgbs_E1 "Demanda de Mbps 2021"
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
			
			
			 order cod_local_2 D_COD_CAR D_DPTO D_PROV D_DIST D_REGION D_DREUGEL VRAEM VRAEM_INTERV FRONTERA COAR GRADIENTE QUINTIL_FINAL DAREACENSO TotalMatricula  total_mat4to TDOCENTE_CE2020 TOTAL_PROVE TOTAL_ESTADO TOTAL_MEDIO_TRANS2 TOTAL_BAJADA TOTAL_SUBIDA TOTAL_GARANTIZADO TOTAL_ACCESOS PRONATEL_1 PRONATEL_2 PRONATEL_3 PRONATEL_4 OTIC_1 OTIC_2 num_operadores_SM_T num_operadores_SM_2G num_operadores_SM_3G num_operadores_SM_4G num_operadores_IF internet_OTIC internet_UE internet_OTICyUE CALIDAD_COBERTURA_FIJO_3T2019 CALIDAD_COBERTURA_2T2020 FASE1 FASE2 FASE1o2 F1o2_Estudiantes F1o2_Estudiantes_Internet F1o2_Estudiantes_Ncargador F1o2_Docentes F102_Docentes_Internet F1o2_Docentes_Ncargador INCLUYE_CHIP dispositivos_2021 nueva_cobertura_electricidad electricidad_local tipo_internet_costeo tipo_internet_costeo_2 estandar_internet_2021 estandar_internet_2022 Mgbs_total Mgbs_total_rango Mgbs_Xdisp Mgbs_calidad Mgbs_E0 cost_uniE0 cost_anualE0 Mgbs_E1 cost_uniE1 cost_anualE1 costo_ope_sat Microserver_BM Microserver_Minedu N_microserver costo_microserver_1 costo_microserver_2 costo_total_microservers 

*sort cod_local_2 
*quietly by cod_local_2: gen dup = cond(_N==1,0,_n)
	 
	 
	 save "$output/basefinal.dta", replace
	 
	 
	 *Exportar base de datos 
	  ************************
	  export excel "$output/BaseFinal_BrechaDigital.xlsx", firstrow(varlabels) replace
	  
