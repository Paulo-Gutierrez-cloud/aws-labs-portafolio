# Guía Paso a Paso: Creating a Website on S3

## 📑 Índice

1. [Preparación del Laboratorio](#1-preparación-del-laboratorio)
2. [Conectar a Instancia EC2 usando SSM](#2-conectar-a-instancia-ec2-usando-ssm)
3. [Configurar AWS CLI](#3-configurar-aws-cli)
4. [Crear Bucket de S3](#4-crear-bucket-de-s3)
5. [Crear Usuario IAM con Acceso a S3](#5-crear-usuario-iam-con-acceso-a-s3)
6. [Ajustar Permisos del Bucket](#6-ajustar-permisos-del-bucket)
7. [Extraer Archivos del Sitio Web](#7-extraer-archivos-del-sitio-web)
8. [Subir Archivos a S3](#8-subir-archivos-a-s3)
9. [Crear Script de Actualización](#9-crear-script-de-actualización)
10. [Desafío Opcional: Optimizar con S3 Sync](#10-desafío-opcional-optimizar-con-s3-sync)

---

## 1. Preparación del Laboratorio

### 1.1 Iniciar el Laboratorio

1. En la parte superior de las instrucciones, hacer clic en **Start Lab**
2. Esperar hasta que aparezca "Lab status: ready"
3. Hacer clic en **X** para cerrar el panel
4. Hacer clic en **AWS** para abrir la consola

---

## 2. Conectar a Instancia EC2 usando SSM

### 2.1 Obtener URL de Sesión

1. Hacer clic en el botón **Details** en la parte superior
2. Seleccionar **Show**
3. Copiar el valor de **InstanceSessionUrl**
4. Pegar la URL en una nueva pestaña del navegador

**Resultado**: Se abrirá una consola de Session Manager conectada a la instancia

### 2.2 Cambiar a Usuario ec2-user

Ejecutar los siguientes comandos:

```bash
sudo su -l ec2-user
pwd
```

**Salida esperada**:
```
/home/ec2-user
```

**✅ Resultado**: Terminal SSH listo para ejecutar comandos

---

## 3. Configurar AWS CLI

### 3.1 Ejecutar Configuración

```bash
aws configure
```

### 3.2 Ingresar Credenciales

Cuando se solicite, ingresar:

```
AWS Access Key ID: <Copiar AccessKey desde Details>
AWS Secret Access Key: <Copiar SecretKey desde Details>
Default region name: us-west-2
Default output format: json
```

**✅ Resultado**: AWS CLI configurado con credenciales

---

## 4. Crear Bucket de S3

### 4.1 Elegir Nombre del Bucket

El nombre del bucket debe ser **único globalmente**. 

**Formato sugerido**: `<inicial><apellido><números>`

**Ejemplo**: `twhitlock256`

### 4.2 Crear el Bucket

Reemplazar `<my-bucket>` con tu nombre de bucket:

```bash
aws s3api create-bucket --bucket <my-bucket> --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2
```

**Ejemplo**:
```bash
aws s3api create-bucket --bucket twhitlock256 --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2
```

**Salida esperada**:
```json
{
    "Location": "http://twhitlock256.s3.amazonaws.com/"
}
```

**Explicación**:
- `--bucket`: Nombre del bucket
- `--region us-west-2`: Región donde se crea
- `--create-bucket-configuration LocationConstraint=us-west-2`: Requerido para regiones fuera de us-east-1

**✅ Resultado**: Bucket de S3 creado exitosamente

---

## 5. Crear Usuario IAM con Acceso a S3

### 5.1 Crear el Usuario IAM

```bash
aws iam create-user --user-name awsS3user
```

**Salida esperada**:
```json
{
    "User": {
        "Path": "/",
        "UserName": "awsS3user",
        "UserId": "AIDAXXXXXXXXXXXXXXXXX",
        "Arn": "arn:aws:iam::123456789012:user/awsS3user",
        "CreateDate": "2025-12-11T13:15:00Z"
    }
}
```

### 5.2 Crear Perfil de Login

```bash
aws iam create-login-profile --user-name awsS3user --password Training123!
```

### 5.3 Obtener Account ID

1. En la consola de AWS, hacer clic en el menú **VocLabsUser...** (esquina superior derecha)
2. Copiar el **Account ID** (12 dígitos)
3. Seleccionar **Sign Out**

### 5.4 Iniciar Sesión como awsS3user

1. Hacer clic en **Log back in** o **Sign in to the Console**
2. Seleccionar el radio button **IAM user**
3. Pegar el Account ID (sin guiones)
4. Hacer clic en **Next**
5. Ingresar:
   - **IAM user name**: `awsS3user`
   - **Password**: `Training123!`
6. Hacer clic en **Sign In**

### 5.5 Verificar Acceso a S3

1. En la consola, buscar **S3** y seleccionarlo
2. **Nota**: El bucket puede no ser visible inicialmente
3. Refrescar la página
4. Puede aparecer error "Access to this bucket" (normal, aún no tiene permisos)

### 5.6 Encontrar Política de S3

Volver a la terminal y ejecutar:

```bash
aws iam list-policies --query "Policies[?contains(PolicyName,'S3')]"
```

**Buscar en la salida**: `AmazonS3FullAccess`

### 5.7 Adjuntar Política al Usuario

```bash
aws iam attach-user-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess \
  --user-name awsS3user
```

### 5.8 Verificar Acceso

1. Volver a la consola de AWS (sesión de awsS3user)
2. Refrescar la página de S3
3. Ahora deberías ver el bucket

**✅ Resultado**: Usuario IAM creado con acceso completo a S3

---

## 6. Ajustar Permisos del Bucket

### 6.1 Desbloquear Acceso Público

1. En la consola de S3, hacer clic en el nombre de tu bucket
2. Ir a la pestaña **Permissions**
3. En **Block public access (bucket settings)**, hacer clic en **Edit**
4. **Desmarcar** "Block all public access"
5. Hacer clic en **Save changes**
6. Confirmar en el prompt

### 6.2 Habilitar ACLs

1. En la pestaña **Permissions**, en **Object Ownership**, hacer clic en **Edit**
2. Seleccionar **ACLs enabled**
3. Marcar **I acknowledge that ACLs will be restored**
4. Hacer clic en **Save changes**

**✅ Resultado**: Bucket configurado para permitir acceso público

---

## 7. Extraer Archivos del Sitio Web

### 7.1 Navegar al Directorio

```bash
cd ~/sysops-activity-files
```

### 7.2 Extraer Archivos

```bash
tar xvzf static-website-v2.tar.gz
cd static-website
```

### 7.3 Verificar Contenido

```bash
ls
```

**Salida esperada**:
```
css  images  index.html
```

**✅ Resultado**: Archivos del sitio web extraídos correctamente

---

## 8. Subir Archivos a S3

### 8.1 Configurar Bucket para Website Hosting

Reemplazar `<my-bucket>` con tu nombre de bucket:

```bash
aws s3 website s3://<my-bucket>/ --index-document index.html
```

**Explicación**: Este comando habilita el hosting de sitios web estáticos y define `index.html` como documento índice.

### 8.2 Subir Archivos

```bash
aws s3 cp /home/ec2-user/sysops-activity-files/static-website/ \
  s3://<my-bucket>/ --recursive --acl public-read
```

**Explicación**:
- `cp`: Comando de copia
- `--recursive`: Copia todos los archivos y subdirectorios
- `--acl public-read`: Establece permisos de lectura pública

**Salida esperada**:
```
upload: ./index.html to s3://twhitlock256/index.html
upload: ./css/styles.css to s3://twhitlock256/css/styles.css
upload: ./images/logo.png to s3://twhitlock256/images/logo.png
...
```

### 8.3 Verificar Archivos Subidos

```bash
aws s3 ls <my-bucket>
```

**Salida esperada**:
```
                           PRE css/
                           PRE images/
2025-12-11 13:20:00       1234 index.html
```

### 8.4 Verificar en la Consola

1. En la consola de S3, hacer clic en tu bucket
2. Ir a la pestaña **Properties**
3. Desplazarse hasta **Static website hosting**
4. Verificar que esté **Enabled**
5. Copiar el **Bucket website endpoint URL**

### 8.5 Abrir el Sitio Web

1. Hacer clic en el **Bucket website endpoint URL**
2. Se abrirá en una nueva pestaña

**Resultado esperado**: Sitio web del Café & Bakery visible

**✅ Resultado**: Sitio web estático desplegado y accesible públicamente

---

## 9. Crear Script de Actualización

### 9.1 Ver Historial de Comandos

```bash
history
```

Localizar la línea con el comando `aws s3 cp`

### 9.2 Crear Archivo de Script

```bash
cd ~
touch update-website.sh
```

### 9.3 Editar el Script

```bash
vi update-website.sh
```

1. Presionar `i` para entrar en modo de edición
2. Copiar y pegar (reemplazar `<my-bucket>`):

```bash
#!/bin/bash
aws s3 cp /home/ec2-user/sysops-activity-files/static-website/ \
  s3://<my-bucket>/ --recursive --acl public-read
```

3. Presionar `Esc`
4. Escribir `:wq` y presionar `Enter`

### 9.4 Hacer el Script Ejecutable

```bash
chmod +x update-website.sh
```

### 9.5 Modificar el Sitio Web

```bash
vi sysops-activity-files/static-website/index.html
```

1. Presionar `i` para editar
2. Buscar `bgcolor="aquamarine"` (primera línea) → cambiar a `bgcolor="gainsboro"`
3. Buscar `bgcolor="orange"` → cambiar a `bgcolor="cornsilk"`
4. Buscar `bgcolor="aquamarine"` (segunda línea) → cambiar a `bgcolor="gainsboro"`
5. Presionar `Esc`, escribir `:wq`, presionar `Enter`

### 9.6 Ejecutar el Script

```bash
./update-website.sh
```

**Salida esperada**:
```
upload: ./index.html to s3://twhitlock256/index.html
upload: ./css/styles.css to s3://twhitlock256/css/styles.css
...
```

### 9.7 Verificar Cambios

1. Volver al navegador con el sitio web
2. Refrescar la página (F5)
3. Los colores deberían haber cambiado

**✅ Resultado**: Script de actualización creado y funcionando

---

## 10. Desafío Opcional: Optimizar con S3 Sync

### 10.1 Problema con `aws s3 cp`

El comando `aws s3 cp --recursive` sube **todos los archivos** cada vez, incluso si no han cambiado.

### 10.2 Solución: `aws s3 sync`

El comando `sync` solo sube archivos que han cambiado.

### 10.3 Hacer un Cambio Pequeño

```bash
vi sysops-activity-files/static-website/index.html
```

1. Presionar `i`
2. Cambiar un color (por ejemplo, `gainsboro` → `lightblue`)
3. Presionar `Esc`, `:wq`, `Enter`

### 10.4 Actualizar el Script

```bash
vi update-website.sh
```

1. Presionar `i`
2. Reemplazar el contenido con:

```bash
#!/bin/bash
aws s3 sync /home/ec2-user/sysops-activity-files/static-website/ \
  s3://<my-bucket>/ --acl public-read
```

3. Presionar `Esc`, `:wq`, `Enter`

### 10.5 Ejecutar el Script Optimizado

```bash
./update-website.sh
```

**Salida esperada**:
```
upload: index.html to s3://twhitlock256/index.html
```

**Observación**: Solo se subió `index.html`, no todos los archivos

### 10.6 Verificar Cambios

Refrescar el sitio web en el navegador

**✅ Resultado**: Script optimizado que solo sube archivos modificados

---

## 📊 Comparación: cp vs sync

| Característica | `aws s3 cp --recursive` | `aws s3 sync` |
|----------------|-------------------------|---------------|
| Archivos subidos | Todos los archivos | Solo archivos modificados |
| Velocidad | Más lento | Más rápido |
| Eficiencia | Baja | Alta |
| Uso de ancho de banda | Alto | Bajo |
| Mejor para | Primera subida | Actualizaciones |

---

## 🎓 Conclusiones Clave

1. **S3 Static Hosting**: Forma simple y económica de hospedar sitios web estáticos
2. **IAM Policies**: Control granular de permisos para usuarios
3. **ACLs**: Permisos a nivel de objeto para acceso público
4. **Automatización**: Scripts bash simplifican despliegues repetitivos
5. **Optimización**: `sync` es más eficiente que `cp` para actualizaciones

---

## 🔗 Recursos Útiles

- [S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [AWS CLI S3 Commands](https://docs.aws.amazon.com/cli/latest/reference/s3/)
- [AWS CLI S3 Sync](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html)

---

**Laboratorio completado exitosamente** ✅
