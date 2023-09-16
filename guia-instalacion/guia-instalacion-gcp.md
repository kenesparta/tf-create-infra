# 1. Creación de cuenta de Google Cloud e instalación de Google Cloud Cli 🚀

## 1.1. Creación de cuenta de Google Cloud
- Para crear una cuenta en Google Cloud, sigue estos pasos:

- Accede al sitio web de Google Cloud: Abre tu navegador web y visita el sitio web de Google Cloud en https://cloud.google.com/.

- Haz clic en "Empezar gratis": En la página principal de Google Cloud, verás un botón o enlace que dice "Empezar gratis" o "Get started for free". Haz clic en él.

- Inicia sesión en tu cuenta de Google: Si ya tienes una cuenta de Google (por ejemplo, una cuenta de Gmail), puedes usarla para iniciar sesión. Simplemente proporciona tu dirección de correo electrónico y contraseña y luego haz clic en "Siguiente" o "Sign in".

- Completa la información de registro: Si no tienes una cuenta de Google, deberás crear una. Para ello, proporciona la información requerida, como tu nombre, dirección de correo electrónico, número de teléfono y crea una contraseña.

- Acepta los términos y condiciones: Lee los términos y condiciones de Google Cloud y, si estás de acuerdo, marca la casilla para aceptarlos.

- Configura la facturación: Google Cloud puede solicitar información de facturación, como los datos de tu tarjeta de crédito, incluso si estás registrándote para una cuenta gratuita. Esto es para verificar tu identidad y para que puedas utilizar servicios que tienen costos asociados una vez que se agote el crédito gratuito. Proporciona la información requerida y luego haz clic en "Siguiente".

- Verifica tu identidad: En algunos casos, Google Cloud puede solicitar que verifiques tu identidad mediante un código que te enviarán por correo electrónico o mensaje de texto. Ingresa el código de verificación cuando lo recibas.

- Configura la cuenta: Después de verificar tu identidad, podrás configurar algunos detalles adicionales de tu cuenta, como la región y la zona horaria.

- Completar el registro: Una vez que hayas completado todos los pasos anteriores, habrás creado tu cuenta en Google Cloud. A partir de este momento, puedes acceder al panel de control de Google Cloud y comenzar a utilizar sus servicios.

Es importante tener en cuenta que Google Cloud ofrece un período de prueba gratuito con un crédito inicial, pero algunos servicios pueden incurrir en costos después de que se agote este crédito. Asegúrate de comprender los términos y condiciones, así como la estructura de precios de Google Cloud antes de utilizar servicios que puedan generar cargos.

## 1.2. Instalación de Google Cloud Cli

Para instalar la Google Cloud CLI (Command Line Interface), también conocida como gcloud, puedes seguir estos pasos generales. Ten en cuenta que los pasos pueden variar ligeramente según tu sistema operativo:

### Para sistemas Unix (Linux y macOS):

1. Abre una terminal en tu sistema.

2. Actualiza el índice de paquetes local ejecutando el siguiente comando (esto es opcional, pero es una buena práctica):
    ```sh
    sudo apt-get update
    sudo yum update
    ```
3. A continuación, instala la CLI de Google Cloud utilizando curl y el siguiente comando:

    ```sh
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-<VERSION>-<OS>-<ARCH>.tar.gz
    ```
    Asegúrate de reemplazar <VERSION>, <OS>, y <ARCH> con la versión correcta de la CLI, tu sistema operativo y la arquitectura de tu CPU. Puedes encontrar esta información actualizada en el sitio web de Google Cloud.

4. Descomprime el archivo descargado con un comando como el siguiente:

    ```sh
    tar -xzvf google-cloud-sdk-<VERSION>-<OS>-<ARCH>.tar.gz
    ```
5. Luego, cambia al directorio de la CLI de Google Cloud que se creó:

    ```sh
    cd google-cloud-sdk
    ```
6. Ejecuta el script de instalación:

    ```sh
    ./install.sh
    ```
7. Durante la instalación, te pedirán que configurezcas ciertas opciones, como la ubicación de instalación y si deseas actualizar tu perfil de shell para incluir las rutas necesarias.

8. Una vez que la instalación esté completa, puedes verificar si gcloud se instaló correctamente ejecutando:

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