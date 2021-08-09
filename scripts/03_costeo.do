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
	 
	 
	 save "$data_clean/base_costeo.dta", replace
	 
	
