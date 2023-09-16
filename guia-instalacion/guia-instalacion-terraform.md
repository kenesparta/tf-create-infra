# 1. Instalación de Terraform 🚀

Para instalar Terraform en tu sistema, sigue estos pasos generales. Ten en cuenta que los pasos pueden variar según tu sistema operativo:

### Para sistemas Unix (Linux y macOS):

- Abre una terminal en tu sistema.

- Visita la página de descargas de Terraform en el sitio web oficial: https://www.terraform.io/downloads.html

- Descarga la versión de Terraform que corresponda a tu sistema operativo. Por ejemplo, para Linux, puedes ejecutar el siguiente comando en la terminal:

    ```sh
    wget https://releases.hashicorp.com/terraform/<VERSION>/terraform_<VERSION>_linux_amd64.zip
    ```

- Asegúrate de reemplazar <VERSION> con la versión de Terraform que deseas instalar, que puedes encontrar en el sitio web.

- Descomprime el archivo descargado utilizando el comando unzip. Por ejemplo:

    ```sh
    unzip terraform_<VERSION>_linux_amd64.zip
    ```
- Mueve el ejecutable de Terraform a un directorio incluido en tu variable de entorno PATH para que puedas ejecutarlo desde cualquier ubicación. Puedes usar el siguiente comando para hacerlo:

    ```sh
    sudo mv terraform /usr/local/bin/
    ```
- Verifica que Terraform se haya instalado correctamente ejecutando:

    ```sh
    terraform --version
    ```
### Para Windows:

- Visita la página de descargas de Terraform en el sitio web oficial: https://www.terraform.io/downloads.html

- Descarga la versión de Terraform para Windows en formato ZIP.

- Descomprime el archivo ZIP descargado en una ubicación de tu elección.

- Agrega la ubicación de la carpeta donde descomprimiste Terraform a tu variable de entorno PATH. Puedes hacerlo siguiendo estos pasos:

    - Haz clic derecho en "Este equipo" o "Mi PC" en el menú Inicio.
    - Selecciona "Propiedades" y luego "Configuración avanzada del sistema" en el panel izquierdo.
    - En la pestaña "Opciones avanzadas", haz clic en "Variables de entorno".
    - En la sección "Variables del sistema", busca la variable PATH y haz clic en "Editar".
    - Agrega la ruta completa de la carpeta de Terraform que descomprimiste, por ejemplo "C:\ruta\a\la\carpeta\terraform", al final de la lista de valores separados por punto y coma (;).
    - Haz clic en "Aceptar" para guardar los cambios.
- Abre una nueva ventana de PowerShell o Command Prompt y verifica que Terraform se haya instalado correctamente ejecutando:

    ```sh
    terraform --version
    ```
    Ahora, Terraform debería estar instalado y listo para su uso en tu sistema. Puedes comenzar a crear y gestionar infraestructuras como código utilizando Terraform.
