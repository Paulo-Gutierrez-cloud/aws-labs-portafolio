# Referencia de Comandos - S3 Static Website

## 📑 Índice

1. [Comandos de AWS CLI - S3](#comandos-de-aws-cli---s3)
2. [Comandos de AWS CLI - IAM](#comandos-de-aws-cli---iam)
3. [Comandos de Linux](#comandos-de-linux)
4. [Scripts de Automatización](#scripts-de-automatización)

---

## Comandos de AWS CLI - S3

### Crear Bucket

```bash
aws s3api create-bucket --bucket <bucket-name> --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2
```

**Parámetros**:
- `--bucket`: Nombre único del bucket
- `--region`: Región AWS
- `--create-bucket-configuration`: Configuración de ubicación (requerido fuera de us-east-1)

---

### Configurar Website Hosting

```bash
aws s3 website s3://<bucket-name>/ --index-document index.html
```

**Parámetros**:
- `--index-document`: Archivo principal del sitio (generalmente index.html)
- `--error-document`: (Opcional) Página de error personalizada

---

### Subir Archivos (Copy)

```bash
aws s3 cp <source> s3://<bucket-name>/ --recursive --acl public-read
```

**Parámetros**:
- `<source>`: Ruta local de archivos
- `--recursive`: Incluir subdirectorios
- `--acl public-read`: Permisos de lectura pública

**Ejemplo**:
```bash
aws s3 cp /home/ec2-user/website/ s3://my-bucket/ --recursive --acl public-read
```

---

### Sincronizar Archivos (Sync)

```bash
aws s3 sync <source> s3://<bucket-name>/ --acl public-read
```

**Ventajas sobre cp**:
- Solo sube archivos modificados
- Más rápido para actualizaciones
- Menor uso de ancho de banda

**Opciones adicionales**:
```bash
aws s3 sync <source> s3://<bucket-name>/ \
  --acl public-read \
  --delete \
  --exclude "*.tmp"
```

- `--delete`: Elimina archivos en S3 que no existen localmente
- `--exclude`: Excluye archivos que coincidan con el patrón

---

### Listar Contenido del Bucket

```bash
aws s3 ls s3://<bucket-name>/
```

**Con detalles**:
```bash
aws s3 ls s3://<bucket-name>/ --recursive --human-readable --summarize
```

---

### Eliminar Archivos

```bash
# Eliminar un archivo
aws s3 rm s3://<bucket-name>/file.html

# Eliminar todos los archivos
aws s3 rm s3://<bucket-name>/ --recursive
```

---

### Obtener URL del Website

```bash
aws s3api get-bucket-website --bucket <bucket-name>
```

---

### Configurar Política del Bucket

```bash
aws s3api put-bucket-policy --bucket <bucket-name> --policy file://policy.json
```

**Ejemplo de policy.json**:
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": "*",
    "Action": ["s3:GetObject"],
    "Resource": ["arn:aws:s3:::<bucket-name>/*"]
  }]
}
```

---

## Comandos de AWS CLI - IAM

### Crear Usuario

```bash
aws iam create-user --user-name <username>
```

**Ejemplo**:
```bash
aws iam create-user --user-name awsS3user
```

---

### Crear Login Profile

```bash
aws iam create-login-profile --user-name <username> --password <password>
```

**Ejemplo**:
```bash
aws iam create-login-profile --user-name awsS3user --password Training123!
```

---

### Listar Políticas

```bash
# Todas las políticas
aws iam list-policies

# Filtrar por nombre
aws iam list-policies --query "Policies[?contains(PolicyName,'S3')]"

# Solo políticas de AWS
aws iam list-policies --scope AWS

# Solo políticas locales
aws iam list-policies --scope Local
```

---

### Adjuntar Política a Usuario

```bash
aws iam attach-user-policy \
  --policy-arn arn:aws:iam::aws:policy/<PolicyName> \
  --user-name <username>
```

**Ejemplo**:
```bash
aws iam attach-user-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess \
  --user-name awsS3user
```

---

### Listar Políticas de un Usuario

```bash
aws iam list-attached-user-policies --user-name <username>
```

---

### Crear Access Key

```bash
aws iam create-access-key --user-name <username>
```

---

### Eliminar Usuario

```bash
# Primero, desadjuntar políticas
aws iam detach-user-policy \
  --user-name <username> \
  --policy-arn <policy-arn>

# Eliminar login profile
aws iam delete-login-profile --user-name <username>

# Eliminar usuario
aws iam delete-user --user-name <username>
```

---

## Comandos de Linux

### Navegación y Archivos

```bash
# Cambiar directorio
cd ~/sysops-activity-files

# Listar archivos
ls
ls -la

# Ver contenido de archivo
cat index.html

# Crear archivo vacío
touch update-website.sh

# Hacer archivo ejecutable
chmod +x update-website.sh
```

---

### Extracción de Archivos

```bash
# Extraer tar.gz
tar xvzf static-website-v2.tar.gz

# Opciones:
# x: extraer
# v: verbose (mostrar progreso)
# z: descomprimir gzip
# f: archivo
```

---

### Editor VI

```bash
# Abrir archivo
vi filename.sh

# Modo de edición
i  # Insertar

# Guardar y salir
Esc  # Salir del modo edición
:wq  # Escribir y salir
:q!  # Salir sin guardar
```

---

### Cambiar Usuario

```bash
# Cambiar a ec2-user
sudo su -l ec2-user

# Verificar directorio actual
pwd

# Verificar usuario actual
whoami
```

---

## Scripts de Automatización

### Script Básico de Actualización

**Archivo**: `update-website.sh`

```bash
#!/bin/bash

# Script para actualizar sitio web en S3
# Uso: ./update-website.sh

BUCKET_NAME="my-bucket"
SOURCE_DIR="/home/ec2-user/sysops-activity-files/static-website/"

echo "Actualizando sitio web en S3..."

aws s3 cp $SOURCE_DIR s3://$BUCKET_NAME/ \
  --recursive \
  --acl public-read

echo "Actualización completada!"
```

---

### Script Optimizado con Sync

```bash
#!/bin/bash

# Script optimizado para actualizar sitio web en S3
# Solo sube archivos modificados

BUCKET_NAME="my-bucket"
SOURCE_DIR="/home/ec2-user/sysops-activity-files/static-website/"

echo "Sincronizando archivos con S3..."

aws s3 sync $SOURCE_DIR s3://$BUCKET_NAME/ \
  --acl public-read \
  --delete

echo "Sincronización completada!"
```

---

### Script Avanzado con Validación

```bash
#!/bin/bash

# Script avanzado de despliegue con validación

BUCKET_NAME="my-bucket"
SOURCE_DIR="/home/ec2-user/sysops-activity-files/static-website/"

# Colores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar que el directorio existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Error: Directorio $SOURCE_DIR no existe${NC}"
    exit 1
fi

# Verificar que el bucket existe
aws s3 ls s3://$BUCKET_NAME/ > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Bucket $BUCKET_NAME no existe o no es accesible${NC}"
    exit 1
fi

echo "Sincronizando archivos con S3..."

# Sincronizar archivos
aws s3 sync $SOURCE_DIR s3://$BUCKET_NAME/ \
  --acl public-read \
  --delete

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Sincronización completada exitosamente!${NC}"
    
    # Mostrar URL del sitio
    REGION=$(aws configure get region)
    echo -e "${GREEN}URL del sitio: http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com${NC}"
else
    echo -e "${RED}✗ Error durante la sincronización${NC}"
    exit 1
fi
```

---

### Script con Invalidación de CloudFront (Opcional)

```bash
#!/bin/bash

# Script con invalidación de caché de CloudFront

BUCKET_NAME="my-bucket"
SOURCE_DIR="/home/ec2-user/sysops-activity-files/static-website/"
DISTRIBUTION_ID="E1234567890ABC"  # ID de distribución CloudFront

echo "Sincronizando archivos con S3..."

aws s3 sync $SOURCE_DIR s3://$BUCKET_NAME/ \
  --acl public-read \
  --cache-control "max-age=3600"

echo "Invalidando caché de CloudFront..."

aws cloudfront create-invalidation \
  --distribution-id $DISTRIBUTION_ID \
  --paths "/*"

echo "Despliegue completado!"
```

---

## Comandos de Troubleshooting

### Verificar Configuración de Website

```bash
aws s3api get-bucket-website --bucket <bucket-name>
```

---

### Verificar Permisos del Bucket

```bash
aws s3api get-bucket-acl --bucket <bucket-name>
```

---

### Verificar Política del Bucket

```bash
aws s3api get-bucket-policy --bucket <bucket-name>
```

---

### Verificar Bloqueo de Acceso Público

```bash
aws s3api get-public-access-block --bucket <bucket-name>
```

---

### Probar Acceso al Sitio

```bash
# Obtener región del bucket
REGION=$(aws s3api get-bucket-location --bucket <bucket-name> --query LocationConstraint --output text)

# Construir URL
echo "http://<bucket-name>.s3-website-$REGION.amazonaws.com"

# Probar con curl
curl http://<bucket-name>.s3-website-$REGION.amazonaws.com
```

---

## Mejores Prácticas

### 1. Nombres de Bucket
- Usar minúsculas
- Evitar puntos (.) para compatibilidad SSL
- Hacer nombres únicos y descriptivos

### 2. Seguridad
- Usar políticas de bucket en lugar de ACLs cuando sea posible
- Habilitar versionado para protección de datos
- Configurar logging para auditoría

### 3. Performance
- Usar `sync` en lugar de `cp` para actualizaciones
- Configurar cache-control headers
- Considerar CloudFront para distribución global

### 4. Costos
- Eliminar versiones antiguas regularmente
- Usar lifecycle policies para archivos temporales
- Monitorear uso con CloudWatch

---

## Resumen de Comandos por Tarea

### Tarea 3: Crear Bucket
```bash
aws s3api create-bucket --bucket <my-bucket> --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2
```

### Tarea 4: Crear Usuario IAM
```bash
aws iam create-user --user-name awsS3user
aws iam create-login-profile --user-name awsS3user --password Training123!
aws iam attach-user-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess \
  --user-name awsS3user
```

### Tarea 7: Extraer Archivos
```bash
cd ~/sysops-activity-files
tar xvzf static-website-v2.tar.gz
cd static-website
```

### Tarea 8: Subir a S3
```bash
aws s3 website s3://<my-bucket>/ --index-document index.html
aws s3 cp /home/ec2-user/sysops-activity-files/static-website/ \
  s3://<my-bucket>/ --recursive --acl public-read
```

### Tarea 9: Script de Actualización
```bash
#!/bin/bash
aws s3 cp /home/ec2-user/sysops-activity-files/static-website/ \
  s3://<my-bucket>/ --recursive --acl public-read
```

### Tarea 10: Optimizar con Sync
```bash
aws s3 sync /home/ec2-user/sysops-activity-files/static-website/ \
  s3://<my-bucket>/ --acl public-read
```

---

## 📚 Recursos Adicionales

- [AWS CLI S3 Reference](https://docs.aws.amazon.com/cli/latest/reference/s3/)
- [AWS CLI S3API Reference](https://docs.aws.amazon.com/cli/latest/reference/s3api/)
- [S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)

---

**Última actualización**: Diciembre 2025
