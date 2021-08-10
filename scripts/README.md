# Código y Costeo
Esta carpeta contiene el código y metodología de costeo del proyecto de Educación Híbrida. 

## Lista de scripts utilizados

| Script | Descripción |
|--------|-------------|
| 00_master.do | Corre el código desde un script centralizado | 
| 01_limpiar_data.do | Limpia las bases de datos utilizadas en el proyecto | 
| 02_construir_data.do | Construye/Une las base de datos para realizar el costeo | 
| 03_costeo.do | Realiza el costeo del proyecto de educación híbrida  | 
| 04_labels.do | Incluye los labels a las variables de la Base Final | 

## Metodología de estimación de costos de Internet 2022

A continuación se presenta la metodología utilizada para estimar los costos de Internet 2022, el do file `03_costeo.do` contiene el código empleado.

### Paso I: Determinar bajo que modalidad va a ser atendido el local educativo 

En la variable tipo_internet_costeo_2, se consideraron tres opciones bajo los cuales los locales educativos pueden recibir internet, mediante (i) Operador, (ii) Microservers y (iii) Satelital. Sin embargo, esta última opción no será atendida.  A continuación, se detallan los criterios considerados para determinar bajo que modalidad iba a ser atendido el local educativo

| **Modalidad de atención** | **Criterio** | 
| ------------------------- | ------------ |
| Operador                  | Se considera que se va a utilizar operador si: ·En el código ubigeo que se encuentra el local educativo hay por lo menos un operador disponible que ofrece servicio móvil 4G o Internet Fijo. ·Asimismo, se considera aquellos locales educativos que actualmente ya tienen un contrato de internet por el cual reciben internet mediante ADSL, fibra óptica, red móvil o Wifi |
| Microserver | Locales educativos sin internet. Se identifica aquellos locales sin internet, como aquellos en los que el docente no recibió un plan de datos. |
| Satelital   | Locales educativos que no son tipo de internet ni de operador ni microserver. |

###	Paso II: Calcular el requerimiento de Mbps (Solo aplica para el caso de las modalidades de atención por Operador)

1.	Determinar el número de dispositivos electrónicos del local educativo: Se calcula el número de dispositivos electrónicos del local educativo utilizando la información del Censo 2020 que indica la cantidad de dispositivos electrónicos en uso en un local educativo, así como el número de tabletas que el local educativo recibiría en la Fase I y II.
2.	Determinar el requerimiento de Mbps del local educativo: De acuerdo al informe 01418-2020-MINEDU/VMGP-DITE se establece que el requerimiento mínimo de internet por dispositivo electrónico es de 0.55 Mbps. Por lo tanto, para determinar el requerimiento de Mbps de cada local educativo se multiplica el numero obtenido en el punto (1) por 0.55. 
3.	Determinar la disponibilidad actual de Mbps del local educativo:  Se utiliza la información proporcionada por la OTIC  en la cual se detalla los Mbps disponibles de acuerdo a los contratos vigentes. Ello permite saber con cuanto Mbps dispone la escuela. 
4.	Determinar la demanda de Mbps para el 2022: se obtiene de la resta del requerimiento de Mbps del local educativo (calculado en el punto 2) con la disponibilidad actual de Mbps del local educativo (calculado en el punto 3).

###	Paso III: Calcular el costo anual del requerimiento de Mbps (Solo aplica para el caso de las modalidades de atención por Operador o Satelital)
Para el caso del tipo de internet operador y satelital, en lo que respecta a costos fijos y variables, se utilizó el modelo de estructura de costos del contrato de Bitel (N 0004-2018-MINEDU/UE 026). A continuación de detalla los costos unitarios considerados para cada uno de los casos:

**1)	Costos por Tipo de internet: Operador**

Utilizando la información del contrato Bitel N 0004-2018-MINEDU/UE 026 se estimó que el costo fijo anual del tipo de internet “Operador” para cada IIEE asciende a S/ 10,784.71.

Monto mensual y anual de costos fijos de Operador para cada IIEE.
|**Costos fijos**|
|----------------|
|Tipo de Internet|Costo Mensual   |Costo Anual     |
|Operador        |S/ 898.73       |S/ 10,784.71    |


Los costos variables van a depender los Mbps que necesite el instituto educativo. En el cuadro que se muestra a continuación, se detallan los costos mensuales y anuales dependiendo del requerimiento de Mbps del local educativo:


b)	Costos por Tipo de internet: Satelital

Monto mensual y anual de costos fijos de Satelital para cada IIEE

Los costos variables van a depender los Mbps que necesite el instituto educativo. 

###	Paso IV: Calcular el costo de la asignación de Microservers (no aplica para los locales educativos que serán atendidos por internet de operadores)
La estructura de costos de los microservers, se considera lo siguiente en base a los costos unitarios brindados por DITE. 

