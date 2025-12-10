# Referencia de Comandos - AWS Systems Manager

## 📑 Índice

1. [Comandos de AWS CLI](#comandos-de-aws-cli)
2. [Comandos de Session Manager](#comandos-de-session-manager)
3. [Comandos de Systems Manager](#comandos-de-systems-manager)
4. [Comandos de Linux](#comandos-de-linux)

---

## Comandos de AWS CLI

### Listar Instancias EC2

```bash
aws ec2 describe-instances
```

**Descripción**: Lista todas las instancias EC2 en la región configurada con información detallada en formato JSON.

**Parámetros comunes:**
- `--instance-ids`: Filtrar por IDs de instancia específicos
- `--filters`: Aplicar filtros personalizados
- `--query`: Consultar campos específicos del JSON

**Ejemplo con filtros:**
```bash
aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=running" \
  --query "Reservations[].Instances[].{ID:InstanceId,Type:InstanceType,State:State.Name}"
```

---

### Obtener Metadatos de la Instancia

```bash
# Obtener zona de disponibilidad
curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone

# Obtener ID de instancia
curl -s http://169.254.169.254/latest/meta-data/instance-id

# Obtener tipo de instancia
curl -s http://169.254.169.254/latest/meta-data/instance-type

# Obtener IP pública
curl -s http://169.254.169.254/latest/meta-data/public-ipv4

# Obtener IP privada
curl -s http://169.254.169.254/latest/meta-data/local-ipv4
```

**Descripción**: El servicio de metadatos de instancia (IMDS) proporciona información sobre la instancia EC2 en ejecución.

**Endpoint**: `http://169.254.169.254/latest/meta-data/`

---

### Configurar Región AWS

```bash
# Método 1: Obtener región desde metadatos
AZ=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFAULT_REGION=${AZ::-1}

# Método 2: Configurar manualmente
export AWS_DEFAULT_REGION=us-west-2
```

**Explicación**:
- `${AZ::-1}`: Elimina el último carácter de la zona de disponibilidad para obtener la región
- Ejemplo: `us-west-2a` → `us-west-2`

---

## Comandos de Systems Manager

### Fleet Manager - Configurar Inventario

**Desde la consola:**
1. Systems Manager → Fleet Manager
2. Account management → Set up inventory
3. Configurar nombre y objetivos
4. Setup Inventory

**Equivalente en CLI:**
```bash
aws ssm create-association \
  --name "AWS-GatherSoftwareInventory" \
  --targets "Key=instanceids,Values=i-1234567890abcdef0" \
  --schedule-expression "rate(30 minutes)" \
  --parameters '{
    "applications": ["Enabled"],
    "awsComponents": ["Enabled"],
    "networkConfig": ["Enabled"],
    "instanceDetailedInformation": ["Enabled"]
  }'
```

---

### Run Command - Ejecutar Comandos

**Ejecutar un documento personalizado:**
```bash
aws ssm send-command \
  --document-name "Install-Dashboard-App" \
  --instance-ids "i-1234567890abcdef0" \
  --region us-west-2
```

**Ejecutar un comando shell:**
```bash
aws ssm send-command \
  --document-name "AWS-RunShellScript" \
  --instance-ids "i-1234567890abcdef0" \
  --parameters 'commands=["sudo yum update -y","sudo yum install -y httpd","sudo systemctl start httpd"]' \
  --region us-west-2
```

**Verificar el estado del comando:**
```bash
aws ssm list-commands \
  --command-id "12345678-1234-1234-1234-123456789012"
```

**Obtener la salida del comando:**
```bash
aws ssm get-command-invocation \
  --command-id "12345678-1234-1234-1234-123456789012" \
  --instance-id "i-1234567890abcdef0"
```

---

### Parameter Store - Gestión de Parámetros

**Crear un parámetro:**
```bash
aws ssm put-parameter \
  --name "/dashboard/show-beta-features" \
  --value "True" \
  --type "String" \
  --description "Display beta features"
```

**Leer un parámetro:**
```bash
aws ssm get-parameter \
  --name "/dashboard/show-beta-features"
```

**Leer un parámetro con desencriptación:**
```bash
aws ssm get-parameter \
  --name "/database/password" \
  --with-decryption
```

**Listar parámetros:**
```bash
aws ssm describe-parameters
```

**Listar parámetros por ruta:**
```bash
aws ssm get-parameters-by-path \
  --path "/dashboard" \
  --recursive
```

**Actualizar un parámetro:**
```bash
aws ssm put-parameter \
  --name "/dashboard/show-beta-features" \
  --value "False" \
  --type "String" \
  --overwrite
```

**Eliminar un parámetro:**
```bash
aws ssm delete-parameter \
  --name "/dashboard/show-beta-features"
```

---

### Session Manager - Iniciar Sesión

**Iniciar sesión desde CLI:**
```bash
aws ssm start-session \
  --target "i-1234567890abcdef0"
```

**Requisitos previos:**
- Instalar el plugin de Session Manager:
  ```bash
  # Para Linux/macOS
  curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "session-manager-plugin.deb"
  sudo dpkg -i session-manager-plugin.deb
  
  # Para Windows
  # Descargar e instalar desde:
  # https://s3.amazonaws.com/session-manager-downloads/plugin/latest/windows/SessionManagerPluginSetup.exe
  ```

**Terminar sesión:**
```bash
# Desde la sesión activa, presionar Ctrl+D o escribir:
exit
```

---

### Inventario - Consultar Datos

**Obtener inventario de una instancia:**
```bash
aws ssm list-inventory-entries \
  --instance-id "i-1234567890abcdef0" \
  --type-name "AWS:Application"
```

**Tipos de inventario disponibles:**
- `AWS:Application`: Aplicaciones instaladas
- `AWS:AWSComponent`: Componentes de AWS
- `AWS:InstanceInformation`: Información de la instancia
- `AWS:Network`: Configuración de red
- `AWS:WindowsUpdate`: Actualizaciones de Windows

**Consultar inventario con filtros:**
```bash
aws ssm get-inventory \
  --filters "Key=AWS:InstanceInformation.InstanceStatus,Values=Active"
```

---

## Comandos de Linux

### Navegación y Archivos

**Listar archivos:**
```bash
ls /var/www/html
```

**Listar archivos con detalles:**
```bash
ls -la /var/www/html
```

**Ver contenido de un archivo:**
```bash
cat /var/www/html/index.php
```

**Buscar archivos:**
```bash
find /var/www/html -name "*.php"
```

---

### Gestión de Servicios

**Verificar estado de Apache:**
```bash
sudo systemctl status httpd
```

**Iniciar Apache:**
```bash
sudo systemctl start httpd
```

**Detener Apache:**
```bash
sudo systemctl stop httpd
```

**Reiniciar Apache:**
```bash
sudo systemctl restart httpd
```

**Habilitar Apache al inicio:**
```bash
sudo systemctl enable httpd
```

---

### Información del Sistema

**Ver información del sistema operativo:**
```bash
cat /etc/os-release
```

**Ver uso de memoria:**
```bash
free -h
```

**Ver uso de disco:**
```bash
df -h
```

**Ver procesos en ejecución:**
```bash
ps aux
```

**Ver información de red:**
```bash
ip addr show
```

---

## Scripts de Instalación

### Script de Instalación del Dashboard

```bash
#!/bin/bash

# Actualizar el sistema
sudo yum update -y

# Instalar Apache
sudo yum install -y httpd

# Instalar PHP y módulos
sudo yum install -y php php-mysql php-gd php-xml php-mbstring

# Instalar AWS SDK para PHP
cd /var/www/html
sudo wget https://github.com/aws/aws-sdk-php/releases/download/3.x/aws.phar

# Descargar la aplicación Widget Manufacturing Dashboard
sudo wget https://aws-tc-largeobjects.s3.amazonaws.com/CUR-TF-100-RESTRT-1/dashboard-app.zip
sudo unzip dashboard-app.zip
sudo rm dashboard-app.zip

# Configurar permisos
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Iniciar y habilitar Apache
sudo systemctl start httpd
sudo systemctl enable httpd

echo "Dashboard instalado exitosamente"
```

---

## Comandos de Troubleshooting

### Verificar Conectividad

**Verificar conectividad a Internet:**
```bash
ping -c 4 8.8.8.8
```

**Verificar resolución DNS:**
```bash
nslookup aws.amazon.com
```

**Verificar puertos abiertos:**
```bash
sudo netstat -tuln | grep LISTEN
```

---

### Logs del Sistema

**Ver logs de Apache:**
```bash
sudo tail -f /var/log/httpd/access_log
sudo tail -f /var/log/httpd/error_log
```

**Ver logs del sistema:**
```bash
sudo journalctl -u httpd -f
```

**Ver logs de Systems Manager Agent:**
```bash
sudo tail -f /var/log/amazon/ssm/amazon-ssm-agent.log
```

---

### Verificar Agente de Systems Manager

**Verificar estado del agente:**
```bash
sudo systemctl status amazon-ssm-agent
```

**Reiniciar el agente:**
```bash
sudo systemctl restart amazon-ssm-agent
```

**Ver versión del agente:**
```bash
sudo yum info amazon-ssm-agent
```

---

## Resumen de Comandos por Tarea

### Tarea 1: Fleet Manager
```bash
# Desde la consola web - no hay comandos CLI directos
# Configuración: Systems Manager → Fleet Manager → Set up inventory
```

### Tarea 2: Run Command
```bash
# Ejecutar documento personalizado
aws ssm send-command \
  --document-name "Install-Dashboard-App" \
  --instance-ids "i-1234567890abcdef0"

# Verificar instalación
curl http://<ServerIP>
```

### Tarea 3: Parameter Store
```bash
# Crear parámetro
aws ssm put-parameter \
  --name "/dashboard/show-beta-features" \
  --value "True" \
  --type "String"

# Leer parámetro
aws ssm get-parameter --name "/dashboard/show-beta-features"

# Eliminar parámetro
aws ssm delete-parameter --name "/dashboard/show-beta-features"
```

### Tarea 4: Session Manager
```bash
# Listar archivos de la aplicación
ls /var/www/html

# Obtener región
AZ=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFAULT_REGION=${AZ::-1}

# Listar instancias EC2
aws ec2 describe-instances
```

---

## 🎓 Mejores Prácticas

### Parameter Store
- Usar rutas jerárquicas: `/aplicacion/entorno/parametro`
- Usar SecureString para datos sensibles
- Implementar versionado de parámetros
- Usar etiquetas para organización

### Run Command
- Usar documentos personalizados para tareas repetitivas
- Implementar manejo de errores en scripts
- Usar S3 para almacenar salidas de comandos largos
- Aplicar comandos a grupos de instancias usando tags

### Session Manager
- Configurar logging de sesiones en S3
- Usar políticas IAM para controlar acceso
- Implementar tiempo de espera de sesión
- Auditar sesiones con CloudTrail

---

## 📚 Recursos Adicionales

- [AWS CLI Command Reference - SSM](https://docs.aws.amazon.com/cli/latest/reference/ssm/)
- [AWS CLI Command Reference - EC2](https://docs.aws.amazon.com/cli/latest/reference/ec2/)
- [Systems Manager API Reference](https://docs.aws.amazon.com/systems-manager/latest/APIReference/)
- [AWS SDK for PHP](https://aws.amazon.com/sdk-for-php/)

---

**Última actualización**: Diciembre 2025
