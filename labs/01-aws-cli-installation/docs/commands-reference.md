# Referencia de Comandos AWS CLI

## 📋 Tabla de Contenidos

1. [Comandos de Instalación](#comandos-de-instalación)
2. [Comandos de Configuración](#comandos-de-configuración)
3. [Comandos IAM](#comandos-iam)
4. [Comandos Útiles Generales](#comandos-útiles-generales)

---

## Comandos de Instalación

### Descargar AWS CLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```

**Descripción**: Descarga el instalador del AWS CLI v2 para Linux x86_64

**Opciones**:
- `-o "awscliv2.zip"`: Especifica el nombre del archivo de salida

---

### Descomprimir Instalador

```bash
unzip -u awscliv2.zip
```

**Descripción**: Descomprime el archivo ZIP del instalador

**Opciones**:
- `-u`: Actualiza archivos existentes sin preguntar

---

### Instalar AWS CLI

```bash
sudo ./aws/install
```

**Descripción**: Ejecuta el script de instalación con privilegios de administrador

**Ubicación de instalación**: `/usr/local/bin/aws`

---

### Verificar Versión

```bash
aws --version
```

**Descripción**: Muestra la versión instalada del AWS CLI

**Salida ejemplo**:
```
aws-cli/2.7.24 Python/3.8.8 Linux/4.14.133-113.105.amzn2.x86_64 botocore/2.4.5
```

---

## Comandos de Configuración

### Configurar AWS CLI

```bash
aws configure
```

**Descripción**: Configura las credenciales y ajustes por defecto del AWS CLI

**Información solicitada**:
- AWS Access Key ID
- AWS Secret Access Key
- Default region name (ej: us-west-2)
- Default output format (json, yaml, text, table)

**Archivos creados**:
- `~/.aws/credentials`: Almacena las credenciales
- `~/.aws/config`: Almacena la configuración

---

### Ver Configuración Actual

```bash
aws configure list
```

**Descripción**: Muestra la configuración actual del AWS CLI

**Salida ejemplo**:
```
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************ABCD shared-credentials-file    
secret_key     ****************WXYZ shared-credentials-file    
    region                us-west-2      config-file    ~/.aws/config
```

---

### Configurar Región Específica

```bash
aws configure set region us-west-2
```

**Descripción**: Establece la región por defecto

---

### Configurar Formato de Salida

```bash
aws configure set output json
```

**Descripción**: Establece el formato de salida por defecto

**Formatos disponibles**:
- `json`: Formato JSON (por defecto)
- `yaml`: Formato YAML
- `text`: Texto plano
- `table`: Tabla formateada

---

## Comandos IAM

### Listar Usuarios

```bash
aws iam list-users
```

**Descripción**: Lista todos los usuarios IAM en la cuenta

**Salida**: JSON con información de usuarios (UserName, UserId, Arn, CreateDate)

---

### Listar Políticas (Scope Local)

```bash
aws iam list-policies --scope Local
```

**Descripción**: Lista las políticas gestionadas por el cliente

**Opciones**:
- `--scope Local`: Solo políticas creadas por el cliente
- `--scope AWS`: Solo políticas gestionadas por AWS
- `--scope All`: Todas las políticas (por defecto)

---

### Obtener Detalles de una Política

```bash
aws iam get-policy --policy-arn <ARN>
```

**Descripción**: Obtiene información sobre una política específica

**Ejemplo**:
```bash
aws iam get-policy --policy-arn arn:aws:iam::123456789012:policy/lab_policy
```

---

### Obtener Versión de una Política

```bash
aws iam get-policy-version --policy-arn <ARN> --version-id <VERSION>
```

**Descripción**: Obtiene el documento JSON de una versión específica de una política

**Ejemplo**:
```bash
aws iam get-policy-version \
  --policy-arn arn:aws:iam::123456789012:policy/lab_policy \
  --version-id v1
```

---

### Guardar Política en Archivo

```bash
aws iam get-policy-version \
  --policy-arn <ARN> \
  --version-id <VERSION> > policy.json
```

**Descripción**: Guarda el documento de política en un archivo JSON

---

### Listar Grupos

```bash
aws iam list-groups
```

**Descripción**: Lista todos los grupos IAM

---

### Listar Roles

```bash
aws iam list-roles
```

**Descripción**: Lista todos los roles IAM

---

### Obtener Usuario Actual

```bash
aws iam get-user
```

**Descripción**: Obtiene información sobre el usuario autenticado actualmente

---

### Listar Políticas Adjuntas a un Usuario

```bash
aws iam list-attached-user-policies --user-name <USERNAME>
```

**Descripción**: Lista las políticas adjuntas a un usuario específico

**Ejemplo**:
```bash
aws iam list-attached-user-policies --user-name awsstudent
```

---

## Comandos Útiles Generales

### Ayuda General

```bash
aws help
```

**Descripción**: Muestra la ayuda general del AWS CLI

**Navegación**:
- Espacio: Avanzar página
- `q`: Salir

---

### Ayuda de un Servicio

```bash
aws <servicio> help
```

**Ejemplo**:
```bash
aws iam help
```

**Descripción**: Muestra la ayuda específica de un servicio

---

### Ayuda de un Comando

```bash
aws <servicio> <comando> help
```

**Ejemplo**:
```bash
aws iam list-users help
```

**Descripción**: Muestra la ayuda detallada de un comando específico

---

### Listar Regiones Disponibles

```bash
aws ec2 describe-regions --output table
```

**Descripción**: Lista todas las regiones de AWS disponibles en formato tabla

---

### Obtener ID de Cuenta

```bash
aws sts get-caller-identity
```

**Descripción**: Obtiene información sobre la identidad del llamador (Account ID, User ID, ARN)

**Salida ejemplo**:
```json
{
    "UserId": "AIDAXXXXXXXXXXXXXXXXX",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/awsstudent"
}
```

---

### Filtrar Salida con --query

```bash
aws iam list-users --query 'Users[*].UserName'
```

**Descripción**: Filtra la salida JSON usando JMESPath

**Ejemplo - Obtener solo nombres de usuarios**:
```bash
aws iam list-users --query 'Users[*].UserName' --output text
```

---

### Salida en Formato Tabla

```bash
aws iam list-users --output table
```

**Descripción**: Muestra la salida en formato de tabla legible

---

## 🔧 Opciones Globales Comunes

| Opción | Descripción | Ejemplo |
|--------|-------------|---------|
| `--region` | Especifica la región AWS | `--region us-east-1` |
| `--output` | Formato de salida | `--output json` |
| `--profile` | Perfil de credenciales | `--profile production` |
| `--query` | Filtro JMESPath | `--query 'Users[0]'` |
| `--debug` | Modo de depuración | `--debug` |
| `--no-cli-pager` | Desactiva el paginador | `--no-cli-pager` |

---

## 📝 Patrones de Comandos

### Estructura General

```bash
aws <servicio> <comando> [opciones]
```

**Ejemplos**:
```bash
aws s3 ls
aws ec2 describe-instances
aws iam list-users
aws lambda list-functions
```

---

### Redirección de Salida

```bash
# Guardar en archivo
aws <comando> > output.json

# Agregar a archivo existente
aws <comando> >> output.json

# Descartar salida
aws <comando> > /dev/null
```

---

### Encadenamiento con Pipes

```bash
# Filtrar con grep
aws iam list-users | grep UserName

# Formatear con jq
aws iam list-users | jq '.Users[].UserName'

# Contar resultados
aws iam list-users | jq '.Users | length'
```

---

## 🎯 Comandos del Laboratorio

### Secuencia Completa del Laboratorio

```bash
# 1. Instalar AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -u awscliv2.zip
sudo ./aws/install
aws --version

# 2. Configurar AWS CLI
aws configure
# Ingresar: Access Key, Secret Key, Region (us-west-2), Format (json)

# 3. Verificar configuración
aws iam list-users

# 4. Listar políticas locales
aws iam list-policies --scope Local

# 5. Descargar política lab_policy
aws iam get-policy-version \
  --policy-arn arn:aws:iam::038946776283:policy/lab_policy \
  --version-id v1 > lab_policy.json

# 6. Verificar archivo descargado
cat lab_policy.json
```

---

## 🔗 Referencias

- [AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/)
- [IAM CLI Reference](https://docs.aws.amazon.com/cli/latest/reference/iam/)
- [JMESPath Tutorial](https://jmespath.org/tutorial.html)
- [AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

---

**Última actualización**: Diciembre 2024
