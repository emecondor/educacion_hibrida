
	use "$data_clean/base_construida.dta", clear 

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


      *****************************************************************************************************************************************	
      *5. Costos del requerimiento de Mpbs para cubrir los dispositivos actuales (2020) y 2021; según tipo de internet (operador, satelital)
      *****************************************************************************************************************************************
  
       ********************
	   *COSTOS VARIABLES*
	   ********************
	
       *a. Internet para cubrir los dispositivos actuales (2020)
       *********************************************************
		gen dispositivos_2021 = dispositivos_2020 + F1o2_Estudiantes
				 
		*Requerimiento de Megabytes, lo minimo por dispositivo en la escuela
		gen Mpbs_E0 = round(0.55 * dispositivos_2020,1)  // le damos el 100% de la demanda de Mpbs por dispositivo disponible
		replace Mpbs_E0 = max(Mpbs_E0 - Mpbs_total,0) if internet_OTIC=="si" //si tiene internet le damos solo lo que requiere de la demanda
		gen cost_uniE0=.
				
		*Internet de operador cuando es urbano o el MTC ha indicado que hay internet fijo o movil en la zona
		replace cost_uniE0=Mpbs_E0*45 if  tipo_internet_costeo_2 == "operador" & Mpbs_E0>0 & Mpbs_E0<4 
		replace cost_uniE0=167 if tipo_internet_costeo_2 == "operador" & Mpbs_E0>=4  & Mpbs_E0<6
		replace cost_uniE0=177 if tipo_internet_costeo_2 == "operador" & Mpbs_E0>=6 & Mpbs_E0< 8
		replace cost_uniE0=197 if tipo_internet_costeo_2 == "operador" & Mpbs_E0>=8 & Mpbs_E0<10
		replace cost_uniE0=217 if tipo_internet_costeo_2 == "operador" & Mpbs_E0>=10 & Mpbs_E0<15
		replace cost_uniE0=267 if tipo_internet_costeo_2 == "operador" & Mpbs_E0>=15 & Mpbs_E0<20
		replace cost_uniE0=327 if tipo_internet_costeo_2 == "operador" & Mpbs_E0>=20
				
		*Internet satelital cuando es rural
		replace cost_uniE0= 645*Mpbs_E0 if Mpbs_E0>0 & Mpbs_E0<4 &  tipo_internet_costeo_2 == "satelital"
		replace cost_uniE0= 2560+645*(Mpbs_E0-5) if Mpbs_E0>=4  & tipo_internet_costeo_2 == "satelital"
		recode cost_uniE0 (.=0)
				
		*Generar el costo unitario anual
		gen cost_anualE0= 12*cost_uniE0         
				

	     *b. Internet para cubrir los dipositivos 2021- 1:1 a todos los alumnos
	    ***********************************************************************
		gen Mpbs_E1 = round(0.55 * dispositivos_2021,1)
		replace Mpbs_E1 = max(Mpbs_E1 - Mpbs_total ,0) if internet_OTIC=="si" //si tiene internet le damos solo lo que requiere de la demanda
		
		gen cost_uniE1=.
			
		*Internet de operador cuando es urbano o el MTC ha indicado que hay internet fijo o movil en la zona
		replace cost_uniE1=Mpbs_E1*45 if tipo_internet_costeo_2 == "operador" & Mpbs_E1>0 & Mpbs_E1<4 
		replace cost_uniE1=167 if tipo_internet_costeo_2 == "operador" & Mpbs_E1>=4  & Mpbs_E1<6
		replace cost_uniE1=177 if tipo_internet_costeo_2 == "operador" & Mpbs_E1>=6 & Mpbs_E1<8
		replace cost_uniE1=197 if tipo_internet_costeo_2 == "operador" & Mpbs_E1>=8 & Mpbs_E1<10
		replace cost_uniE1=217 if tipo_internet_costeo_2 == "operador" & Mpbs_E1>=10 & Mpbs_E1<15
		replace cost_uniE1=267 if tipo_internet_costeo_2 == "operador" & Mpbs_E1>=15 & Mpbs_E1<20
		replace cost_uniE1=327 if tipo_internet_costeo_2 == "operador" & Mpbs_E1>=20
				
		*Internet satelital cuando es rural
		replace cost_uniE1=645*Mpbs_E1 if Mpbs_E1>0 & Mpbs_E1<4 &  tipo_internet_costeo_2 == "satelital"
		replace cost_uniE1=2560+645*(Mpbs_E1-5) if Mpbs_E1>=4  & tipo_internet_costeo_2 == "satelital"
		recode cost_uniE1 (.=0)
				
		*Generar el costo unitario anual
		gen cost_anualE1= 12*cost_uniE1

				 
		********************
	    *COSTOS FIJOS*
	    ********************
				 
		*a. Tipo de internet (operador, satelital)- para el calculo se utilizó formatos de contratos
        *********************************************************************************************
         gen costo_ope_sat= 10784.70 if tipo_internet_costeo== "operador"
         replace costo_ope_sat= 10422.31 if tipo_internet_costeo== "satelital"
				 
		 *Crear la variable "Estandar de internet 2021"
		 gen estandar_internet_2021= "No tiene internet" if Mpbs_total== 0
		 replace estandar_internet_2021= Mpbs_calidad if Mpbs_total!= 0
				 
		 *Crear la variable "Estandar de internet 2022"
		 gen estandar_internet_2022= "Se compra microserver" if tipo_internet_costeo_2== "microserver" 			 
         replace estandar_internet_2022= "Ya no se requiere más internet" if tipo_internet_costeo_2== "operador" & Mpbs_E1== 0
		 replace estandar_internet_2022= "Se compra más internet" if tipo_internet_costeo_2== "operador" & Mpbs_E1!= 0
		 replace estandar_internet_2022= "No se atiende" if tipo_internet_costeo_2== "satelital" 
		  
		 *br tipo_internet_costeo_2 estandar_internet_2022 Mgbs_E1 
		 *br Mgbs_total estandar_internet_2021
				 
		  ****************************
	      *Costo de compra de tablets
	      ****************************
		  gen tablet_E1 = 724 * dispositivos_2021	
				 
				 		
        ********************************
        *6. Costos de microservers
        ********************************
		
	    *a. Crear la variable para llenar los espacios de electricidad y sin electricidad 
	    *********************************************************************************
	    gen nueva_cobertura_electricidad= cobertura_electricidad 
        replace nueva_cobertura_electricidad= "CON ELECTRICIDAD" if cobertura_electricidad=="" & (GRADIENTE=="Rural 1" | GRADIENTE=="Rural 2" | GRADIENTE=="Urbano")
        replace nueva_cobertura_electricidad= "SIN ELECTRICIDAD" if cobertura_electricidad=="" & GRADIENTE=="Rural 3"

	    *b. Costo variable de microserver (costo_microserver_1) 
	    ****************************************************************		 
	     *si tiene electricidad sin cargador =2600
	     *no tiene electricidad con cargador = 3600
		
	    gen costo_microserver_1=. 
	    replace costo_microserver_1= 2600 if nueva_cobertura_electricidad== "CON ELECTRICIDAD"
        replace costo_microserver_1= 3600 if nueva_cobertura_electricidad== "SIN ELECTRICIDAD"
        replace costo_microserver_1= 2600 if nueva_cobertura_electricidad=="" & (GRADIENTE=="Rural 1"| GRADIENTE=="Rural 2" | GRADIENTE=="Urbano")		
        replace costo_microserver_1= 3600 if nueva_cobertura_electricidad=="" & GRADIENTE=="Rural 3"
		
	    *c. Costo fijo de microserver (costo_microserver_2)
		*********************************************************	
		gen costo_microserver_2= 21.29 
		
		*d. Costo total de microservers 
		*********************************************************	
		gen costo_total_microservers= N_microserver *(costo_microserver_1 + costo_microserver_2) + 1.03 
	 
	 
	    save "$data_clean/base_costeo.dta", replace
	 
	
