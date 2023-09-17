# 1. Creación de cuenta de AWS e instalación de AWS Cli 🚀

## 1.1. Creación de cuenta de AWS

- Accede al sitio web de Amazon Web Services (AWS): Visita el sitio web oficial de AWS en https://aws.amazon.com/.

- Clic en "Crear una cuenta gratuita": Busca el botón o enlace que dice "Crear una cuenta gratuita" y haz clic en él.

- Inicia sesión o crea una cuenta de Amazon: Si ya tienes una cuenta de Amazon, puedes usarla para iniciar sesión. Si no tienes una cuenta de Amazon, deberás crear una.

- Completa la información de registro: Proporciona la información requerida, que generalmente incluye detalles de contacto y métodos de pago. Durante este proceso, AWS puede solicitar información de tarjeta de crédito, pero no se te cobrará automáticamente por los servicios gratuitos.

- Verificación de identidad: AWS puede requerir que verifiques tu identidad mediante un proceso de llamada telefónica o mensaje de texto.

- Configura tus preferencias: Configura tus preferencias de cuenta, como la región de AWS que deseas utilizar y las notificaciones por correo electrónico.

- Acepta los términos y condiciones: Lee y acepta los términos y condiciones de AWS.

- Listo para usar: Una vez que hayas completado todos los pasos anteriores, tu cuenta de AWS gratuita estará lista para usar. Puedes comenzar a explorar los servicios gratuitos de AWS y comenzar a crear recursos en la nube.

## 1.2. Instalación de AWS Cli

Para instalar la AWS Command Line Interface (CLI), puedes seguir estos pasos generales. Ten en cuenta que los pasos específicos pueden variar según tu sistema operativo. A continuación, te proporciono instrucciones para sistemas basados en Unix (como Linux y macOS) y para Windows.

### Para sistemas Unix (Linux y macOS):

1. Abre una terminal en tu sistema.
2. Asegúrate de que tengas Python instalado en tu sistema. Puedes verificarlo escribiendo el siguiente comando:
    ```sh
    python --version
    ```
3. Debería mostrarte la versión de Python instalada. AWS CLI requiere Python 2.7 o 3.4+.

4. Si no tienes Python instalado, puedes descargarlo e instalarlo desde el sitio web oficial de Python (https://www.python.org/).

5. Luego, puedes instalar AWS CLI utilizando el administrador de paquetes pip. Ejecuta el siguiente comando:

    ```sh
    pip install awscli
    ```
6. Una vez que la instalación esté completa, puedes verificar si AWS CLI se instaló correctamente ejecutando:

    ```sh
    aws --version
    ```
7. Esto debería mostrar la versión de AWS CLI que se instaló.

### Para Windows:

1. Descarga el instalador de AWS CLI para Windows desde el sitio web oficial de AWS en el siguiente enlace: https://aws.amazon.com/cli/.

2. Ejecuta el instalador descargado y sigue las instrucciones en pantalla. Puedes elegir la ubicación de instalación y otras opciones según tus preferencias.

3. Una vez que la instalación esté completa, abre el símbolo del sistema (Command Prompt) o PowerShell y ejecuta:

    ```sh
    aws --version
    ```

Después de instalar AWS CLI, deberás configurar las credenciales de AWS para que puedas autenticarte y utilizar los servicios de AWS. Puedes configurar las credenciales utilizando el comando aws configure, que te solicitará tu clave de acceso y clave secreta de AWS, así como la región predeterminada y el formato de salida. Asegúrate de configurar adecuadamente tus credenciales antes de comenzar a utilizar AWS CLI.