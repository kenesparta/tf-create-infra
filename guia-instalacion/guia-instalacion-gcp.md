# 1. Instalación de Google Cloud Cli 🚀

Para instalar la Google Cloud CLI (Command Line Interface), también conocida como gcloud, puedes seguir estos pasos generales. Ten en cuenta que los pasos pueden variar ligeramente según tu sistema operativo:

### Para sistemas Unix (Linux y macOS):

1. Abre una terminal en tu sistema.

2. Actualiza el índice de paquetes local ejecutando el siguiente comando (esto es opcional, pero es una buena práctica):
    ```sh
    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo
    ```
    
3. A continuación, instala la CLI de Google Cloud utilizando curl y el siguiente comando:

    ```sh
   echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    ```

4. Importa la clave pública de Google Cloud:

    ```sh
   curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    ```
    
5. Instala y actualiza la CLI de gcloud:
    ```sh
    sudo apt-get update && sudo apt-get install google-cloud-cli
    ```
    
6. Ejecuta gcloud init para comenzar:

    ```sh
    gcloud init
    ```
    
7. Una vez que la instalación esté completa, puedes verificar si gcloud se instaló correctamente ejecutando:

    ```sh
    gcloud --version
    ```

### Para Windows:

1. Descarga el instalador de Google Cloud SDK para Windows desde el sitio web oficial de Google Cloud en el siguiente enlace: https://cloud.google.com/sdk/docs/install#windows.

2. Ejecuta el instalador descargado y sigue las instrucciones en pantalla. Puedes elegir la ubicación de instalación y otras opciones según tus preferencias.

3. Una vez que la instalación esté completa, abre una nueva ventana de Command Prompt o PowerShell y ejecuta:
    ```sh
    gcloud --version
    ```
    
4. Esto debería mostrar la versión de Google Cloud SDK que se instaló.

Después de instalar Google Cloud CLI, deberás autenticarte con tu cuenta de Google Cloud utilizando el comando gcloud auth login para comenzar a utilizar los servicios de Google Cloud desde la línea de comandos.
