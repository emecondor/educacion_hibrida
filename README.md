# Repositorio del proyecto de Educación Híbrida

Este repositorio contiene los informes del proyecto de Educación Híbrida y el código para replicar el costeo. El proyecto de educación híbrida tiene como objetivo...

## Contenido del repositorio

- [Resumen Brecha Digital](https://raw.githubusercontent.com/emecondor/educacion_hibrida/main/documentacion/Resumen-Brecha-Digital.txt)
- [Revisión de Literatura - Brecha Digital](https://github.com/emecondor/educacion_hibrida/blob/main/documentacion/Revision_Literatura-Brecha-Digital.txt)
- [Código y costeo del Proyecto](https://github.com/emecondor/educacion_hibrida/tree/main/scripts)
- [Base final y diccionario de variables](https://github.com/emecondor/educacion_hibrida/tree/main/output)


## Reproducción de resultados

Si encuentras algún problema para correr el código o reproducir los resultados, por favor [crea un `Informe de problemas`](https://github.com/emecondor/educacion_hibrida/issues/new) en este repositorio.

### Requerimientos de software

- Stata (código se corrió con la versión 16)

### Requerimientos de memoria y tiempo de ejecución

- El código de corrió en la PC de Minedu con **Windows 10 y 16GB de RAM**
- El código en Stata toma aproximadamente 5 minutos en correr.

Instrucciones para replicar
---------------------------

### En una PC personal

1. Ya tienes una cuenta en GitHub.com? Si no, [ve a GitHub.com](https://github.com/join)  e inscríbete.
2. Descarga e instala [GitHub Desktop](https://desktop.github.com) en tu PC.
3. Inicia sesión en GitHub Desktop con tu usuario Github.
5. Haz click en el botón verde `Code` que se muestra arriba de la lista de archivos en este repositorio, haz click en la opción `Open with GitHub Desktop`.
6. Abre la ruta del repositorio clonado y navega a `data/raw`.
7. La data utilizada se encuentra en la Unidad B de Minedu. Ve a `B:\OneDrive - Ministerio de Educación\unidad_B\2022\1. Estudios Data\educ_hibrida\data\raw` utilizando el VPN. Copia esta data en el folder `data/raw` del repositorio clonado.
8. En el folder `scripts` encontrarás un script llamado `00_master.do`.
9. Para correr el código abre `00_master.do` y copia la ruta del repositorio clonado en la sección `Ruta`.
10. Los outputs se guardarán en la carpeta `output`.

