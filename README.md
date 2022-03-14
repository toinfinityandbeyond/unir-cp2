# Caso práctico 2. Automatización de despliegues en entornos Cloud

## Introducción
En esta práctica desplegaremos un Jenkins en la nube. Para ello se ha automatizado el proceso con Terraform, Ansible y Kubernetes.


## Variables a editar

Antes de desplegar, en el directorio terraform, tenemos dos archivos con variables que tendremos que cambiar a lo que corresponda en nuestro caso.

 - correccion_vars.tf
	 - location : Que será la localización donde se alojará nuestras máquinas (West Europe, East US...)
	 - storage_account : Que será el nombre de la storage account a desplegar, debemos intentar que sea un nombre único.
	 - public_key_path : Ruta para la clave pública de acceso a las instancias
	 - ssh_user: Usuario para hacer ssh
 - vars.tf
	 - vms : Que serán las máquinas virtuales a crear, al menos una de ellas se tiene que llamar master si queremos que se le asigne una instancia de tamaño más grande.
	 - environment : Tag de entorno de cada uno de los recursos de terraform
	 - private_key_path : Ruta para la clave privada de acceso a las instancias

Además, se deberá crear un archivo llamado credentials.tf con el contenido especificado en [el repositorio de devopslabs](https://github.com/jadebustos/devopslabs/blob/master/estructura-practica/terraform/credentials.tf)


## Despliegue

Una vez que hemos modificado los archivos de variables a lo que corresponde en nuestro caso, podemos proceder al despliegue.
Para desplegar todo (tanto infraestructura como aplicación) lo único que debemos hacer es

    git clone git@github.com:toinfinityandbeyond/unir-cp2.git # copiamos el repositorio
    [cambiamos las variables pertinentes explicadas más arriba a lo que necesitemos]
    cd unir-cp2/terraform # nos vamos a la carpeta terraform del repositorio
    terraform init # inicializamos terraform
    terraform plan # generamos plan de terraform
    terraform apply # desplegamos el plan

Y voilá! Con eso ya deberíamos tener nuestro Jenkins desplegado :)
Al final del todo nos saldrá un mensaje como el siguiente:

    ¡ENHORABUENA! ¡Aplicación desplegada! Accede a estas urls, en alguna está la aplicación (depende de que nodo haya cogido, quizá tarde un poco):
    20.224.241.111:32000
    20.126.61.94:32000
    20.229.111.150:32000
Las IPs mostradas variarán en cada despliegue, así que debemos fijarnos en el mensaje final al hacer el terraform apply.

Si queremos destruir todos los recursos sólo tendremos que hacer:

    terraform destroy



