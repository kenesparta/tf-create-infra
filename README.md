# 1. Creando la infraestructura necesaria 🚀

## 1.1 Requerimientos:
- Git
- AWS CLI
- GCP CLI
- Terraform CLI


## 1.2 AWS provider ☁️ 
- Necesitas tener instalado el AWS CLI.
- Una vez instalado, copiar las credenciales que se les van a proporcionar en los archivos, si es que esos archivos
  ya tiene algún contenido, agrégalos al final de los mismos:
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
- Una vez clonado este proyecto, ingresar al directorio: `cd tf-create-infra`.
- Luego, crear el archivo `.env`, puede usar el comando: `touch .env` para crearlo.
- En seguida, muestro que es lo que se va a poner dentro del archivo `.env`:
  - `ID`: es un uuid que se puede generar de [este enlace 🔗](https://www.uuidgenerator.net/)
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
    
    export ID=f49951cf-96e9-4095-a768-2c6282f345a9
    export DOCKER_IMAGE=kenesparta/fibonacci-wasm-front:0.0.2
    export CONTAINER_NAME=fibonacci-wasm
    export CONTAINER_PORT=8080
    ```

- Ingresar en la carpeta `./aws` y ejecutar este comando `make dev`
- Después de hacer el despliegue de la infraestructura, puedes ver la IP pública ejecutando el archivo `cd ./aws && ./public_ip.sh`.
  El resultado será algo asi como:
  ```shell
    TASK: arn:aws:ecs:us-east-1:603374375148:task/cluster_/4e5efc75630d42da85f1dc7759b6bf54
    ENI: eni-0a279628702d865f7
    IP: 52.87.184.143
  ```
- Acceder a esta dirección: http://52.87.184.143:8080/ (la IP deberá ser de la salida del comando anterior)
- 🚨 Para destruir toda la infraestructura, ejecutar el comando `make dev/destroy` 


## 1.3 GCP provider ☁️ 
