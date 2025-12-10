# Guía Paso a Paso: Instalación y Configuración del AWS CLI

## 📑 Índice

1. [Preparación del Laboratorio](#1-preparación-del-laboratorio)
2. [Conexión a la Instancia EC2](#2-conexión-a-la-instancia-ec2)
3. [Instalación del AWS CLI](#3-instalación-del-aws-cli)
4. [Observación de IAM en la Consola](#4-observación-de-iam-en-la-consola)
5. [Configuración del AWS CLI](#5-configuración-del-aws-cli)
6. [Uso del AWS CLI con IAM](#6-uso-del-aws-cli-con-iam)
7. [Desafío: Descargar Política IAM](#7-desafío-descargar-política-iam)

---

## 1. Preparación del Laboratorio

### 1.1 Iniciar el Laboratorio

1. En la parte superior de las instrucciones del laboratorio, hacer clic en **Start Lab**
2. Esperar hasta que aparezca el mensaje "Lab status: ready"
3. Hacer clic en **X** para cerrar el panel Start Lab
4. Hacer clic en **AWS** para abrir la Consola de AWS Management en una nueva pestaña

### 1.2 Obtener Credenciales

1. Hacer clic en el menú desplegable **Details** en la parte superior
2. Seleccionar **Show** para ver las credenciales
3. Anotar la siguiente información:
   - **PublicIP**: Dirección IP pública de la instancia EC2
   - **AccessKey**: ID de clave de acceso
   - **SecretKey**: Clave de acceso secreta

---

## 2. Conexión a la Instancia EC2

### Para Usuarios de Windows

1. Descargar el archivo **labsuser.ppk** desde el panel Details
2. Descargar e instalar [PuTTY](https://www.putty.org/)
3. Abrir PuTTY y configurar:
   - **Host Name**: `ec2-user@<PublicIP>`
   - **Connection → SSH → Auth**: Cargar el archivo `labsuser.ppk`
4. Hacer clic en **Open** para conectar

### Para Usuarios de macOS/Linux

1. Descargar el archivo **labsuser.pem** desde el panel Details

2. Abrir una terminal y navegar al directorio de descargas:
   ```bash
   cd ~/Downloads
   ```

3. Cambiar los permisos del archivo de clave:
   ```bash
   chmod 400 labsuser.pem
   ```

4. Conectar a la instancia EC2:
   ```bash
   ssh -i labsuser.pem ec2-user@<PublicIP>
   ```
   
5. Cuando se solicite, escribir `yes` para confirmar la conexión

**✅ Resultado esperado**: Conexión SSH exitosa a la instancia Red Hat EC2

---

## 3. Instalación del AWS CLI

### 3.1 Descargar el Instalador

Ejecutar el siguiente comando para descargar el instalador del AWS CLI:

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

**Explicación**: 
- `curl`: Herramienta para transferir datos desde o hacia un servidor
- `-o "awscliv2.zip"`: Guarda el archivo descargado con este nombre

### 3.2 Descomprimir el Instalador

```bash
unzip -u awscliv2.zip
```

**Explicación**:
- `unzip`: Descomprime archivos ZIP
- `-u`: Actualiza archivos existentes sin preguntar

### 3.3 Ejecutar la Instalación

```bash
sudo ./aws/install
```

**Explicación**:
- `sudo`: Ejecuta el comando con privilegios de administrador
- `./aws/install`: Ejecuta el script de instalación

### 3.4 Verificar la Instalación

```bash
aws --version
```

**Salida esperada**:
```
aws-cli/2.7.24 Python/3.8.8 Linux/4.14.133-113.105.amzn2.x86_64 botocore/2.4.5
```

> **Nota**: Los números de versión pueden variar según la fecha de instalación

### 3.5 Probar el Comando de Ayuda

```bash
aws help
```

Para salir de la ayuda, presionar `q`

**✅ Resultado**: AWS CLI instalado correctamente en la instancia Red Hat

---

## 4. Observación de IAM en la Consola

### 4.1 Acceder a IAM

1. En la Consola de AWS, buscar **IAM** en la barra de búsqueda
2. Hacer clic en **IAM** para abrir la consola de IAM

> **Nota**: Pueden aparecer mensajes indicando que no tienes permiso para ver algunos detalles. Esto es normal.

### 4.2 Revisar el Usuario IAM

1. En el panel de navegación, hacer clic en **Users**
2. Seleccionar el usuario **awsstudent**
3. En la pestaña **Permissions**, localizar `lab_policy`
4. Hacer clic en la flecha junto a `lab_policy`
5. Hacer clic en el botón **{} JSON**

**Observación**: Este documento de política IAM en formato JSON otorga al usuario `awsstudent` acceso a servicios específicos de AWS.

### 4.3 Revisar las Credenciales de Seguridad

1. Hacer clic en la pestaña **Security credentials**
2. En la sección **Access keys**, localizar el **Access key ID** del usuario

> **Importante**: La clave de acceso secreta solo se puede ver al momento de crear la clave. Para este laboratorio, las credenciales están disponibles en el menú Details.

**✅ Resultado**: Comprensión de la configuración IAM en la consola

---

## 5. Configuración del AWS CLI

### 5.1 Ejecutar el Comando de Configuración

En la terminal SSH, ejecutar:

```bash
aws configure
```

### 5.2 Ingresar las Credenciales

El comando solicitará la siguiente información:

```
AWS Access Key ID [None]: <Pegar AccessKey desde Details>
AWS Secret Access Key [None]: <Pegar SecretKey desde Details>
Default region name [None]: us-west-2
Default output format [None]: json
```

**Explicación de cada campo**:
- **Access Key ID**: Identificador único para autenticación
- **Secret Access Key**: Clave secreta para autenticación
- **Region**: Región de AWS donde se ejecutarán los comandos por defecto
- **Output format**: Formato de salida de los comandos (json, yaml, text, table)

**✅ Resultado**: AWS CLI configurado y conectado a la cuenta de AWS

---

## 6. Uso del AWS CLI con IAM

### 6.1 Listar Usuarios IAM

Ejecutar el siguiente comando para probar la configuración:

```bash
aws iam list-users
```

**Salida esperada** (formato JSON):

```json
{
    "Users": [
        {
            "Path": "/",
            "UserName": "awsstudent",
            "UserId": "AIDAXXXXXXXXXXXXXXXXX",
            "Arn": "arn:aws:iam::123456789012:user/awsstudent",
            "CreateDate": "2024-01-15T10:30:00Z"
        }
    ]
}
```

**✅ Resultado**: Conexión exitosa entre AWS CLI y la cuenta de AWS

---

## 7. Desafío: Descargar Política IAM

### 🎯 Objetivo del Desafío

Usar el AWS CLI y la documentación de referencia para descargar el documento de política `lab_policy` en formato JSON.

### 7.1 Listar Políticas Locales

Primero, listar todas las políticas gestionadas por el cliente:

```bash
aws iam list-policies --scope Local
```

**Explicación**:
- `list-policies`: Lista las políticas IAM
- `--scope Local`: Filtra solo políticas gestionadas por el cliente (no de AWS)

**Salida relevante**:
```json
{
    "Policies": [
        {
            "PolicyName": "lab_policy",
            "PolicyId": "ANPAXXXXXXXXXXXXXXXXX",
            "Arn": "arn:aws:iam::038946776283:policy/lab_policy",
            "Path": "/",
            "DefaultVersionId": "v1",
            "AttachmentCount": 1,
            "CreateDate": "2024-01-15T10:00:00Z",
            "UpdateDate": "2024-01-15T10:00:00Z"
        }
    ]
}
```

**Información clave obtenida**:
- **Arn**: `arn:aws:iam::038946776283:policy/lab_policy`
- **DefaultVersionId**: `v1`

### 7.2 Obtener la Versión de la Política

Usar el ARN y el ID de versión para obtener el documento JSON:

```bash
aws iam get-policy-version \
  --policy-arn arn:aws:iam::038946776283:policy/lab_policy \
  --version-id v1 > lab_policy.json
```

**Explicación**:
- `get-policy-version`: Obtiene una versión específica de una política
- `--policy-arn`: ARN de la política a obtener
- `--version-id`: ID de la versión de la política
- `> lab_policy.json`: Redirige la salida a un archivo

### 7.3 Verificar el Archivo Descargado

```bash
cat lab_policy.json
```

**Contenido esperado**:
```json
{
    "PolicyVersion": {
        "Document": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": [
                        "iam:Get*",
                        "iam:List*"
                    ],
                    "Resource": "*"
                }
            ]
        },
        "VersionId": "v1",
        "IsDefaultVersion": true,
        "CreateDate": "2024-01-15T10:00:00Z"
    }
}
```

**✅ Desafío completado**: Política IAM descargada exitosamente usando AWS CLI

---

## 📊 Resumen de Comandos Utilizados

| Comando | Propósito |
|---------|-----------|
| `aws --version` | Verificar la versión instalada del AWS CLI |
| `aws configure` | Configurar credenciales y región |
| `aws iam list-users` | Listar usuarios IAM |
| `aws iam list-policies --scope Local` | Listar políticas gestionadas por el cliente |
| `aws iam get-policy-version` | Obtener el documento JSON de una política |

---

## 🎓 Conclusiones Clave

1. **Instalación**: El AWS CLI se puede instalar fácilmente en instancias Linux usando curl y scripts de instalación
2. **Autenticación**: El AWS CLI usa Access Keys (ID + Secret) mientras que la consola usa usuario/contraseña
3. **Comandos**: Los comandos del AWS CLI siguen el patrón: `aws <servicio> <acción> [opciones]`
4. **Documentación**: La documentación de AWS CLI es esencial para descubrir comandos y opciones
5. **Automatización**: El AWS CLI permite automatizar tareas que normalmente se harían manualmente en la consola

---

## 🔗 Recursos Útiles

- [IAM AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/iam/)
- [AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/)
- [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

---

**Laboratorio completado exitosamente** ✅
