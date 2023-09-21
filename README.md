# 🚀 Creando la infraestructura necesaria

## Requerimientos:

Es necesario instalarlos antes de comenzar con el proyecto:

| Herramienta | Enlaces                                                                                              | Guias                                                              |
|-------------|------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| Git         | [↗️ git-scm](https://git-scm.com/downloads)                                                          |                                                                    |
| AWS CLI     | [↗️ amazon](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)           | [📝Guia AWS](guia-instalacion/guia-instalacion-aws.md)             |
| GCP CLI     | [↗️ google](https://cloud.google.com/sdk/docs/install)                                               | [📝Guia GCP](guia-instalacion/guia-instalacion-gcp.md)             |
| Terraform   | [↗️ hashicorp](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)         | [📝Guia Terraform](guia-instalacion/guia-instalacion-terraform.md) |
| Make        | Se puede instalar usando los gestores de paquetes de SO basados en UNIX como apt, yum, pacman, brew. |                                                                    |

---

## 🏗️ Workspace

- Clonar este proyecto en el directorio `tf-create-infra`.
- Recomendamos trabajar con esta aplicación nodeJS, por favor acceder
  a [este link](https://github.com/GlisseLisbeth/workshop_docker_Ayacucho_001/tree/main/02-demo-app-nodejs-docker).
- Finalmente, tendremos este ambiente de trabajo:

```
.
├── tf-create-infra
│  ├── README.md
│  ├── aws
│  ├── docker
│  ├── gcp
│  └── sa.json
└── workshop_docker_Ayacucho_001
    ├── 01-demo-nginx-docker
    ├── 02-demo-app-nodejs-docker
    ├── 03-demo-data-mysql
    ├── README.md
    └── recursos
```

---

## 🌳 Preparación de las variables de ambiente

- Una vez clonado este proyecto, ingresar al directorio `tf-create-infra`.
- Luego, crear el archivo `.env`, puede usar el comando: `touch .env` para crearlo.
- En seguida, muestro que es lo que se va a poner dentro del archivo `.env`:

    - `ID`: es un uuid que se tiene que generar desde [este enlace 🔗](https://www.uuidgenerator.net/)
      ⚠️ **ATENCIÓN: este código tiene que ser diferente entre cada participante**, es el código que identificará todo
      el deployment.
    - `DOCKER_USER_NAME`: nombre de usuario para hacer Login de docker.
    - `DOCKER_IMAGE_NAME`: es el nombre de la imagen que se encuentra en el docker hub, para AWS tiene que ser una
      imagen pública.
    - `DOCKER_IMAGE_TAG`: es la version de la imagen que se encuentra en el docker hub.
    - `CONTAINER_NAME`: es el nombre del contenedor el cual será desplegado en AWS Fargate.
    - `CONTAINER_PORT`: es la puerta donde se va a exponer el servicio, pueden ser usadas solamente las puertas: 8080,
      8088, 3000 y 80.
      ```sh
      # Se sugiere no cambiar estas variables
      export AWS_PROFILE=ecs
      export AWS_REGION=us-east-1
      
      export GOOGLE_PROJECT=dockerayacucho
      export GOOGLE_CREDENTIALS=../sa.json
      export GOOGLE_ZONE=us-central1
      
      # Estas variables e pueden cambiar a conveniencia
      # Este ID tiene que ser cambiado:
      export ID=000000-00000-0000-0000-000000000
      export DOCKER_USER_NAME=kenesparta
      export DOCKER_IMAGE_NAME=kenesparta/nodejs-ip
      export DOCKER_IMAGE_TAG=0.0.1
      export CONTAINER_NAME=nodejs-ip
      export CONTAINER_PORT=3000
      ```

> 💡 **Nota:** Usa el comando `vim .env` o `nano .env` para editar el fichero `.env`.

---

## 🐳 Docker Hub

- Una vez creada la cuenta, crear un repositorio y un token de acceso.
- Ejecutar el comando `source ./tf-create-infra/.env`. Para cargar las variables de ambiente configuradas
- Ingresar al directorio `./workshop_docker_Ayacucho_001/02-demo-app-nodejs-docker`.
- Ejecutar este comando para hacer el build en la máquina local.

```shell
docker build -t "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}" .
```

- Luego ejecutar el docker login y poner el token de acceso como password:

```shell
docker login -u ${DOCKER_USER_NAME}
```

- Finalmente, hacer el docker push:

```shell
docker push "${DOCKER_IMAGE_NAME}":"${DOCKER_IMAGE_TAG}"
```

---

## ☁️ Proveedor: AWS

### 🔐 Configurando credenciales

- Crear el archivo `~/.aws/config` o si ya lo tiene creado, adicionar al final del mismo estas líneas de código:
  ```sh
  [profile ecs]
  region = us-east-1
  output = json
  ```
- Seguidamente, crear el archivo `~/.aws/credentials` o si ya lo tiene creado, adicionar al final del mismo estas líneas
  de código: (_las credenciales se les proporcionará al momento del evento con el nombre de `aws-keys`_)
  ```sh
   [ecs]
   aws_access_key_id = AKI****
   aws_secret_access_key = Bvr****
  ```

### 🚀 Creación y despliegue

- Estando en el directorio del repositorio **tf-create-infra**, ingresar a la carpeta `aws` con `cd ./aws` y ejecutar
  este comando `make dev`.
- Después de hacer el despliegue de la infraestructura, puedes ver la IP pública ejecutando el
  archivo `./public_ip.sh`. El resultado será algo asi como:
  ```shell
    TASK: arn:aws:ecs:us-east-1:603374375148:task/cluster_f49951cf-96e9-4095-a768-2c6282f345a9/4e5efc75630d42da85f1dc7759b6bf54
    ENI: eni-0a279628702d865f7
    IP: http://52.87.184.143:3000/
  ```
- Acceder a esta dirección: http://52.87.184.143:3000/ ⚠️ **La IP/Puerta deberá ser de la salida del comando anterior,
  esta es solamente un ejemplo**.

### 🧨 Destrucción

Para destruir toda la infraestructura, ejecutar el comando `make dev/destroy` dentro del directorio `./aws`.

---

## ☁️ Proveedor: GCP

### 🔐 Configurando credenciales

- Una vez clonado este proyecto, ingresar al directorio `tf-create-infra`.
- Copie el archivo `sa.json` desde la carpeta compartida que **se va a proporcionar durante el evento** al directorio
  principal del proyecto.
- El archivo `sa.json` contiene las credenciales necesarias que permiten autenticarse y asi poder ejecutar comandos en
  el google cloud CLI.

### 🧪 Creación

#### 👩‍🍳 Preparación

- Estando en el directorio del repositorio **tf-create-infra**, ingresar a la carpeta `gcp` con `cd ./gcp` y ejecutar
  este comando `make dev`. Esto creará el registry privado en GCP.

#### 💽 Envío de la imagen al registry privado

- Regresar al directorio del repositorio **tf-create-infra** con `cd ..` y luego ejecutar el comando `source ./.env`.
  Para cargar las variables de ambiente configuradas anteriormente.
- Se ejecutan los siguientes comandos para crear un repositorio privado en el Artifact Registry de Google:
  ```shell
  gcloud auth activate-service-account --key-file=sa.json
  ````
  ````shell
  gcloud auth configure-docker us-central1-docker.pkg.dev
  ````
  ````shell
  docker tag "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" us-central1-docker.pkg.dev/dockerayacucho/"${CONTAINER_NAME}-${ID}"/"${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
  ````
  ```shell
  docker push us-central1-docker.pkg.dev/dockerayacucho/"${CONTAINER_NAME}-${ID}"/"${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
  ```

### 🚀 Despliegue

- Ejecutar el comando `source ./.env`. Para cargar las variables de ambiente configuradas anteriormente.
- Para hacer el despliegue se requiere ejecutar los siguientes comandos:

```shell
  gcloud auth activate-service-account --key-file=sa.json
  
  gcloud run deploy "${CONTAINER_NAME}-${ID}" \
    --image us-central1-docker.pkg.dev/dockerayacucho/"${CONTAINER_NAME}-${ID}"/"${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" \
    --region us-central1 \
    --project dockerayacucho \
    --allow-unauthenticated \
    --platform managed
```

- Se puede ingresar a la dirección mostrada en el
  terminal: https://cont-name-f49951cf-96e9-4095-a768-2c62-2lj6ihiliq-uc.a.run.app

```shell
✓ Deploying new service... Done.
✓ Creating Revision...
✓ Routing traffic...
✓ Setting IAM Policy...
Done.
Service [cont-name-f49951cf-96e9-4095-a768-2c6282f345a9] revision [cont-name-f49951cf-96e9-4095-a768-2c6282f3-00001-52f] has been deployed and is serving 100 percent of traffic.
Service URL: https://cont-name-f49951cf-96e9-4095-a768-2c62-2lj6ihiliq-uc.a.run.app
```

- (Opcional) Si es que no ve el resultado en la URL ejecutar este comando

```shell
  gcloud run services add-iam-policy-binding "${CONTAINER_NAME}-${ID}" \
    --region=us-central1 \
    --member=allUsers \
    --role=roles/run.invoker \
    --project dockerayacucho
```

- Se puede ingresar a la dirección mostrada en el
  terminal: https://cont-name-f49951cf-96e9-4095-a768-2c62-2lj6ihiliq-uc.a.run.app

```shell
✓ Deploying new service... Done.
✓ Creating Revision...
✓ Routing traffic...
✓ Setting IAM Policy...
Done.
Service [cont-name-f49951cf-96e9-4095-a768-2c6282f345a9] revision [cont-name-f49951cf-96e9-4095-a768-2c6282f3-00001-52f] has been deployed and is serving 100 percent of traffic.
Service URL: https://cont-name-f49951cf-96e9-4095-a768-2c62-2lj6ihiliq-uc.a.run.app
```

### 🧨 Destrucción

- En primer lugar, tenemos que destruir el servicio de Cloud Run, ejecutando el comando (puede ser ejecutado desde
  cualquier directorio):

```shell
gcloud run services delete "${CONTAINER_NAME}-${ID}" \
  --region=us-central1 \
  --project dockerayacucho
```

- Finalmente, ingresar al directorio del proyecto **tf-create-infra**, después al directorio `./gcp` y ejecutar el
  comando `make dev/destroy`.
