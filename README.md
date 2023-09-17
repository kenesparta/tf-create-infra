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

### 🌳 Preparación de las variables de ambiente

- Una vez clonado este proyecto, ingresar al directorio `tf-create-infra`.
- Luego, crear el archivo `.env`, puede usar el comando: `touch .env` para crearlo.
- En seguida, muestro que es lo que se va a poner dentro del archivo `.env`:

    - `ID`: es un uuid que se tiene que generar desde [este enlace 🔗](https://www.uuidgenerator.net/)
      ⚠️ **ATENCIÓN: este código tiene que ser diferente entre cada participante**, es el código que identificará todo
      el deployment.
    - `DOCKER_IMAGE`: es el nombre de la imagen que se encuentra en el docker hub, tiene que ser pública.
    - `CONTAINER_NAME`: es el nombre del contenedor el cual será desplegado en AWS Fargate.
    - `CONTAINER_PORT`: es la puerta donde se va a exponer el servicio, pueden ser usadas solamente las puertas: 8080,
      8088, 443 y 80.
      ```sh
      # se sugiere no cambiar estas variables
      export AWS_PROFILE=ecs
      export AWS_REGION=us-east-1
      
      export GOOGLE_PROJECT=dockerayacucho
      export GOOGLE_CREDENTIALS=./sa.json
      export GOOGLE_ZONE=us-central1
      
      # Estas variables e pueden cambiar a conveniencia
      # Este ID tiene que ser cambiado:
      export ID=f49951cf-96e9-4095-a768-2c6282f345a9
      export DOCKER_IMAGE=kenesparta/fibonacci-wasm-front:0.0.2
      export CONTAINER_NAME=fibonacci-wasm
      export CONTAINER_PORT=8080
      
      # Variables para local
      export DOCKER_IMAGE_LOCAL=kenesparta/fibonacci-wasm-front
      export VERSION=0.0.1
      ```

> 💡 **Nota:** Usa el comando `vim .env` o `nano .env` para editar el fichero `.env`.

### 🧪 Creación y despliegue

- Estando en el directorio del repositorio **tf-create-infra**, ingresar a la carpeta `aws` con `cd ./aws` y ejecutar
  este comando `make dev`.
- Después de hacer el despliegue de la infraestructura, puedes ver la IP pública ejecutando el
  archivo `./public_ip.sh`. El resultado será algo asi como:
  ```shell
    TASK: arn:aws:ecs:us-east-1:603374375148:task/cluster_f49951cf-96e9-4095-a768-2c6282f345a9/4e5efc75630d42da85f1dc7759b6bf54
    ENI: eni-0a279628702d865f7
    IP: 52.87.184.143
  ```
- Acceder a esta dirección: http://52.87.184.143:8080/ (la IP deberá ser de la salida del comando anterior).

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

### 🌳 Preparación de las variables de ambiente

Este paso no es necesario porque ya se configuraron las variables de ambiente.

### 🧪 Creación

- Estando en el directorio del repositorio **tf-create-infra**, ingresar a la carpeta `gcp` con `cd ./gcp` y ejecutar
  este comando `make dev`.
- Una vez creado el registry, se procede a hacer push de la imagen local al registry privado de GCP, para ello debemos
  clonar el [siguiente repositorio 🦀](https://github.com/kenesparta/fibonacci-wasm)
  **fuera del directorio del proyecto.** (`cd ../../.`).
- Una vez clonado el proyecto, entrar a la carpeta del mismo: `cd ./fibonacci-wasm`.
- Copiar el archivo `sa.json` (credenciales) dentro de la carpeta del proyecto `./fibonacci-wasm`.
- Ejecutar el comando `source ./tf-create-infra/.env`. Para cargar las variables de ambiente.
- Ejecutar este comando para hacer el build en la máquina local, recuerde que puede cambiar el
  nombre `${DOCKER_IMAGE_LOCAL}` por el que puso en la variable `DOCKER_IMAGE_LOCAL` dentro del archivo `.env`.
  ```shell
  docker build \
    -t "${DOCKER_IMAGE_LOCAL}":"${VERSION}" \
    -f DockerfileFrontend .
  ```

- Una vez haya terminado la creación de la imagen de docker en local, se ejecutan los siguientes comandos para crear un
  repositorio privado en el Artifact Registry de Google (asegúrese que la variable `"${ID}"` sea el ID que ha colocado
  en
  el archivo `.env`)
  ```shell
  gcloud auth activate-service-account --key-file=sa.json
  
  gcloud auth configure-docker us-central1-docker.pkg.dev
  
  docker tag "${DOCKER_IMAGE_LOCAL}":"${VERSION}" us-central1-docker.pkg.dev/dockerayacucho/fibo-wasm-"${ID}"/fibonacci-wasm-front:${VERSION}
  
  docker push us-central1-docker.pkg.dev/dockerayacucho/fibo-wasm-"${ID}"/fibonacci-wasm-front:"${VERSION}"
  ```

### 🚀 Despliegue

- Para hacer el despliegue se requiere ejecutar los siguientes comandos:

```shell
  gcloud auth activate-service-account --key-file=sa.json
  
  gcloud run deploy fibonacci-wasm-front-"${ID}" \
    --image us-central1-docker.pkg.dev/dockerayacucho/fibo-wasm-"${ID}"/fibonacci-wasm-front:"${VERSION}" \
    --region us-central1 \
    --project dockerayacucho \
    --allow-unauthenticated \
    --platform managed
  
  gcloud run services add-iam-policy-binding fibonacci-wasm-front-"${ID}" \
    --region=us-central1 \
    --member=allUsers \
    --role=roles/run.invoker \
    --project dockerayacucho
```

- Se puede ingresar a la dirección mostrada en el
  terminal: https://fibonacci-wasm-front-f49951cf-96e9-4095-a768-2c62-2lj6ihiliq-uc.a.run.app

```shell
✓ Deploying new service... Done.
✓ Creating Revision...
✓ Routing traffic...
✓ Setting IAM Policy...
Done.
Service [fibonacci-wasm-front-f49951cf-96e9-4095-a768-2c6282f345a9] revision [fibonacci-wasm-front-f49951cf-96e9-4095-a768-2c6282f3-00001-52f] has been deployed and is serving 100 percent of traffic.
Service URL: https://fibonacci-wasm-front-f49951cf-96e9-4095-a768-2c62-2lj6ihiliq-uc.a.run.app
```

### 🧨 Destrucción

- En primer lugar, tenemos que destruir el servicio de Cloud Run, ejecutando el comando (puede ser ejecutado desde
  cualquier directorio):

```shell
gcloud run services delete fibonacci-wasm-front-$(id) \
  --region=us-central1 \
  --project dockerayacucho
```

- Finalmente, ingresar al directorio del proyecto **tf-create-infra**, después al directorio `./gcp` y ejecutar el
  comando `make dev/destroy`.
