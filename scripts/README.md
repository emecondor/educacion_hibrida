# Código y Costeo
Esta carpeta contiene el código y metodología de costeo del proyecto de Educación Híbrida. 

## Lista de scripts utilizados

| Script | Descripción |
|--------|-------------|
| 00_master.do | Corre el código desde un script centralizado | 
| 01_limpiar_data.do | Limpia las bases de datos utilizadas en el proyecto | 
| 02_construir_data.do | Construye/Une las base de datos para realizar el costeo | 
| 03_costeo.do | Realiza el costeo del proyecto de educación híbrida  | 
| 04_labels.do | Incluye los labels a las variables de la Base Final  |

## Metodología de estimación de costos de Internet 2022

A continuación se presenta la metodología utilizada para estimar los costos de Internet 2022 del do file `03_costeo.do`.

### Paso I: Determinar bajo que modalidad va a ser atendido el local educativo 

En la variable tipo_internet_costeo_2, se consideraron tres opciones bajo los cuales los locales educativos pueden recibir internet, mediante (i) Operador, (ii) Microservers y (iii) Satelital. Sin embargo, esta última opción no será atendida.  A continuación, se detallan los criterios considerados para determinar bajo que modalidad iba a ser atendido el local educativo

**Criterios para cada modalidad de atención**
| **Modalidad de atención** | **Criterio** | 
| ------------------------- | ------------ |
| Operador                  | Se considera que se va a utilizar operador si: <div> - En el código ubigeo que se encuentra el local educativo hay por lo menos un operador disponible que ofrece servicio móvil 4G o Internet Fijo. <div> - Asimismo, se considera aquellos locales educativos que actualmente ya tienen un contrato de internet por el cual reciben internet mediante ADSL, fibra óptica, red móvil o Wifi |
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

**Monto mensual y anual de costos fijos de Operador para cada IIEE**
|**Costos fijos**|   |   |
|----------------|---|---|
|Tipo de Internet|Costo Mensual   |Costo Anual     |
|Operador        |S/ 898.73       |S/ 10,784.71    |


**Detalle de los costos fijos de Operador para cada IIEE**
|**Detalle de costos fijos. Tipo: Operador**|  **Costo mensual** |
|-------------------------------------------|---------------------|
| Accesorios para cableado estructurado incluye faceplate 1 puerto rj45, jack, roseta, patch cord, cinta | S/ 2.70 |
| Implementación y puesta en Operatividad del servicio para enlaces con Fibra Óptica | S/ 190.00 |
| Pozos a tierra | S/ 50.00 |
| Sistema de pozo a tierra a 05 ohmios | S/ 40.00 |
| Suministro de Access Point que Incluye inyector Poe, kit de montaje, cable de poder, licencias para gestión de nube, kit de candado | S/ 169.90 |
| Suministro de gabinete de comunicaciones que incluyen ventilados, power bar, bandeja, tablero eléctrico adosado con ITM, soporte para piso de 30cm de altura, tuercas | S/ 32.60 |
| Accesorio para canaletas | S/ 4.72 |
| Access Point (kit de reposición en caso de Robo) | S/ 5.99 |
| Canaletas con certificación UL.5A | S/ 10.36 |
| Canalización para Cableado de Telecomunicaciones | S/ 40.00 |
| Capacitación de Monitoreo | S/ 2.00 |
| Capacitación en IIEE | S/ 25.00 |
| Capacitación Personal MINEDU Filtro WEB | S/ 5.24 |
| Coordinado Residente (Ingeniero Onsite) | S/ 3.00 |
| Estabilizador en caso corresponda (kit de reposición en caso de Robo) | S/ 3.00 |
| Estabilizador RF de la solución satelital (kit de reposición en caso de Robo) | S/ 58.24 |
| Gestión de servicio | S/ 8.54 |
| Gestor de la Operación | S/ 0.78 |
| implementación y puesta en Operatividad del servicio para infraestructura interna | S/ 31.88 |
| Ingenieros NOC | S/ 3.66 |
| Instalación de Router, configuración y otros equipos de conectividad para la operatividad del servicio | S/ 35.00 |
| Jefe de Proyecto | S/ 4.16 |
| Patch Cord y transever última milla | S/ 22.00 |
| Plataforma de Monitoreo | S/ 13.35 |
| Router (kit de reposición en caso de Robo) | S/ 3.33 |
| Solución de Filtrado Web Centralizado | S/ 39.93 |
| Solución técnica de Filtrado | S/ 27.80 |
| Soporte Técnico | S/ 13.01 |
| Soporte Técnico para Access Point estabilizador, Gabinete y accesorios | S/ 6.74 |
| Suministro de cableado eléctrico 4mmm2 para cometida eléctrica, cable 6mm2 para aterramiento | S/ 12.48 |
| Suministro de computadora para monitoreo de red con monitos y licencias Windows 10 incluyendo licencias de Microsoft | S/ 0.30 |
| Suministro de ferretería que incluye cajas de montaje, tomacorrientes, terminales, tornillos, tarugos autorrsacantes, tirafones, cinta aislante, vulcanizante, maskintape, cintillo, espirales, tarugos | S/ 2.97 |
| Suministro de tuberías de PVS SAP que incluyen accesorios como conectores, curvas, uniones, abrazaderas, caja de paso | S/ 5.95 |
| Transporte de materiales/fleta/viáticos | S/ 20.63 |
| UPS (kit de reposición en caso de Robo) | S/ 3.49 |
| **Total, general** | **S/ 898.73** |

Los costos variables van a depender los Mbps que necesite el instituto educativo. En el cuadro que se muestra a continuación, se detallan los costos mensuales y anuales dependiendo del requerimiento de Mbps del local educativo:

**Detalle de los costos variables de Operador para cada IIEE**
|**Mbps**          |**Costo mensual**|**Costo anual**|
|------------------|-----------------|---------------|
|Mbps>0 & Mbps<4   |S/ 45            |S/ 540         |
|Mbps>=4 & Mbps<6  |S/ 167           |S/ 2,004       |
|Mbps>=6 & Mbps<8  |S/ 177           |S/ 2,124       |
|Mbps>=8 & Mbps<10 |S/ 197           |S/ 2,364       |
|Mbps>=10 & Mbps<15|S/ 217           |S/ 2,604       |
|Mbps>=15 & Mbps<20|S/ 267           |S/ 3,204       |
|Mbps>=20          |S/ 327           |S/ 3,924       |

2.	Costos por Tipo de internet: Satelital

**Monto mensual y anual de costos fijos de Satelital para cada IIEE**
|**Costos fijos**| - | - |
|----------------|---|---|
|Tipo de Internet|Costo Mensual   |Costo Anual     |
|Satelital       |S/ 868.53       |S/ 10,422.31    |

Los costos variables van a depender los Mbps que necesite el instituto educativo. 

**Detalle de los costos fijos de Satelital para cada IIEE**
|**Detalle de costos fijos. Tipo: Satelital**|  **Costo mensual*** | 
|--------------------------------------------|---------------------|
|Cable UTP categoría 6 LSZH-3 cumple con normal 568. c.2|S/ 15.00|
|Equipamiento Satelital por IIEE (Antena, modem, equipo, rf)|S/ 90.00|
|Implementación y puesta en Operatividad del servicio para enlaces Satelitales|S/ 350.00|
|Accesorio para canaletas|S/ 4.72|
|Access Point (kit de reposición en caso de Robo)|S/ 5.99|
|Canaletas con certificación UL.5A|S/ 10.36|
|Canalización para Cableado de Telecomunicaciones|S/ 40.00|
|Capacitación de Monitoreo|S/ 2.00|
|Capacitación en IIEE|S/ 25.00|
|Capacitación Personal MINEDU Filtro WEB|S/ 5.24|
|Coordinado Residente (Ingeniero Onsite)|S/ 3.00|
|Estabilizador en caso corresponda (kit de reposición en caso de Robo)|S/ 3.00|
|Estabilizador RF de la solución satelital (kit de reposición en caso de Robo)|S/ 58.24|
|Gestión de servicio|S/ 8.54|
|Gestor de la Operación|S/ 0.78|
|implementación y puesta en Operatividad del servicio para infraestructura interna|S/ 31.88|
|Ingenieros NOC|S/ 3.66|
|Instalación de Router, configuración y otros equipos de conectividad para la operatividad del servicio|S/ 35.00|
|Jefe de Proyecto|S/ 4.16|
|Patch Cord y transever última milla|S/ 22.00|
|Plataforma de Monitoreo|S/ 13.35|
|Router (kit de reposición en caso de Robo)|S/ 3.33|
|Solución de Filtrado Web Centralizado|S/ 39.93|
|Solución técnica de Filtrado|S/ 27.80|
|Soporte Técnico|S/ 13.01|
|Soporte Técnico para Access Point estabilizador, Gabinete y accesorios|S/ 6.74|
|Suministro de cableado eléctrico 4mmm2 para cometida eléctrica, cable 6mm2 para aterramiento|S/ 12.48|
|Suministro de computadora para monitoreo de red con monitos y licencias Windows 10 incluyendo licencias de Microsoft|S/ 0.30|
|Suministro de ferretería que incluye cajas de montaje, tomacorrientes, terminales, tornillos, tarugos autorrsacantes, tirafones, cinta aislante, vulcanizante, maskintape, cintillo, espirales, tarugos|S/ 2.97|
|Suministro de tuberías de PVS SAP que incluyen accesorios como conectores, curvas, uniones, abrazaderas, caja de paso|S/ 5.95|
|Transporte de materiales/fleta/viáticos|S/ 20.63|
|UPS (kit de reposición en caso de Robo)|S/ 3.49|
|**Total general**|**S/ 868.53**|

Los costos variables van a depender los Mbps que necesite el instituto educativo. 

**Detalle de los costos variables de Satelital para cada IIEE**
|**Mbps**        |**Costo mensual**|**Costo anual**|
|----------------|-------------|-----------|
|Mbps>0 & Mbps<4 |S/ 645       |S/ 7,740   |
|Mbps>=4 & Mbps<6|S/ 3,205     |S/ 38,460  |

###	Paso IV: Calcular el costo de la asignación de Microservers (no aplica para los locales educativos que serán atendidos por internet de operadores)
La estructura de costos de los microservers, se considera lo siguiente en base a los costos unitarios brindados por DITE. 

|                     |**Costo Microserver**|**Costo Cargador**|**Costo modelaje y trasporte unitario**|**Costo total unitario**|
|---------------------|---------------------|------------------|---------------------------------------|------------------------|
|Zona con electricidad|S/ 2,600             |S/0               |S/ 21.29                               |S/ 2,621.29             |
|Zona sin electricidad|S/ 2,600             |S/ 1000           |S/ 21.29                               |S/ 3,621.29             |
