# 1. Creando la infraestructura necesaria 🚀

## 1.1 AWS provider ☁️

- Necesitas tener instalado el [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
- Una vez instalado, copiar las credenciales que se les van a proporcionar en los archivos:

  - ~/.aws/config
    ```sh
    [profile ecs]
    region = us-east-1
    output = json
    ```
  - ~/.aws/credentials
    ```sh
    [ecs]
    aws_access_key_id = AKI****
    aws_secret_access_key = Bvr****
    ```

- Después de ello, necesitas instalar el terraform CLI desde [este enlace 🔗](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
- Luego, necesitas crear el archivo `.env` en la raíz del proyecto, como ejemplo puedes copiarlos de aquí:

  - `.env`: Donde se tienen que poner el nombre de las variables:

    - `CLUSTER_NAME`: es un uuid que se puede generar de [este enlace 🔗](https://www.uuidgenerator.net/)
      este código tiene que ser diferente entre cada participante, es el codigo que indentificara todo el deployment.
    - `DOCKER_IMAGE`: es el nombre de la imagen que se encuentra en el docker hub, tiene que ser pública.
    - `CONTAINER_NAME`: es el nombre del contenedor el cual será desplegado en AWS Fargate.
    - `CONTAINER_PORT`: es la puerta donde se va a exponer el servicio, pueden ser usadas solamente las puertas: 8080, 8088, 443 y 80.

      ```sh
      export AWS_PROFILE=ecs
      export AWS_REGION=us-east-1

      export GOOGLE_PROJECT=dockerayacucho
      export GOOGLE_CREDENTIALS=./sa.json
      export GOOGLE_ZONE=us-central1

      export CLUSTER_NAME=f49951cf-96e9-4095-a768-2c6282f345a9
      export DOCKER_IMAGE=kenesparta/fibonacci-wasm-front:0.0.2
      export CONTAINER_NAME=fibonacci-wasm
      export CONTAINER_PORT=8080
      ```

- Finalmente, ingresar en la carpeta `./aws` y ejecutar los comandos en el orden establecido
  ```shell
  make dev/init
  make dev/plan
  make dev/apply
  ```
- Después de hacer el despliegue de la infraestructura, puedes ver la IP pública ejecutando el archivo `cd aws && ./public_ip.sh`

> 🚨 Cuidado!
>
> Para eliminar la infraestructura creada se puede ejecutar el comando `make dev/destroy`
