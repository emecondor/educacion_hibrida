// Correr master script

// Seleccionar acciones --------------------------------------------------------

	local limpiar_data				1 // Corre script de limpieza de datos
	local construir_data	      	1 // Corre script de construcción de base de datos
	local costeo					1 // Realiza el Costeo
	local labels					1 // Formato de variables

// Rutas de Usuario ------------------------------------------------------------

    dis        	"`c(hostname)'"
    global     	who "`c(hostname)'"
	
	#d ;
			
	if "$who" == "DESKTOP-RSU0DNP" {; global root "C:\Users\anaso\OneDrive\Documents\Trabajo\10. MINEDU\2. Pilares Brecha Digital\0. Data\Brecha Digital"; }; //Sofia	
	if "$who" == "Windows-SSD" {; global root "C:\Users\eme\OneDrive\10. MINEDU\2. Pilares Brecha Digital\0. Data\Brecha Digital"; }; //Emely
	if "$who" == "bran-macbook.local" {; global root "/Users/bran/Documents/GitHub/educacion_hibrida"; }; // Brandon
					
	#d cr		  
  	   
// Globales --------------------------------------------------------------------

	global scripts				"$root/scripts"
	global data_raw				"$root/data/raw"
	global data_clean			"$root/data/clean"
	global output				"$root/output"
	
// Opciones --------------------------------------------------------------------

	set excelxlsxlargefile on
   
// Correr código ---------------------------------------------------------------	
	
//	Limpiar datos
	if (`limpiar_data' == 1) {
		do "$scripts/01_limpiar_data.do"
	}
	* INPUTS
	* OUTPUTS
	
//	Construir data
	if (`construir_data' == 1) {
		do "$scripts/02_construir_data.do"
	}
	* INPUTS
	* OUTPUTS
	
//	Realizar costeo
	if (`costeo' == 1) {
		do "$scripts/03_costeo.do"
	}
	* INPUTS
	* OUTPUTS

//	Formato de variables
	if (`labels' == 1) {
		do "$scripts/04_labels.do"
	}
	* INPUTS
	* OUTPUTS
