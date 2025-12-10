# Guía Paso a Paso: AWS Systems Manager

## 📑 Índice

1. [Preparación del Laboratorio](#1-preparación-del-laboratorio)
2. [Generar Inventarios con Fleet Manager](#2-generar-inventarios-con-fleet-manager)
3. [Instalar Aplicación con Run Command](#3-instalar-aplicación-con-run-command)
4. [Gestionar Configuraciones con Parameter Store](#4-gestionar-configuraciones-con-parameter-store)
5. [Acceder a Instancias con Session Manager](#5-acceder-a-instancias-con-session-manager)

---

## 1. Preparación del Laboratorio

### 1.1 Iniciar el Laboratorio

1. En la parte superior de las instrucciones del laboratorio, hacer clic en **Start Lab**
2. Esperar hasta que aparezca el mensaje "Lab status: ready"
3. Hacer clic en **X** para cerrar el panel Start Lab
4. Hacer clic en **AWS** para abrir la Consola de AWS Management en una nueva pestaña

### 1.2 Acceder a Systems Manager

1. En la Consola de AWS, en la barra de búsqueda, escribir **Systems Manager**
2. Presionar Enter para acceder a la consola de Systems Manager

> **Nota**: Asegúrate de estar en la región correcta (generalmente us-west-2 para AWS Academy Labs)

**✅ Resultado esperado**: Acceso exitoso a la consola de AWS Systems Manager

---

## 2. Generar Inventarios con Fleet Manager

### 2.1 Descripción de la Tarea

Fleet Manager permite recopilar información del sistema operativo, aplicaciones y metadatos de instancias EC2, servidores on-premises o máquinas virtuales en un entorno híbrido. Esto permite consultar qué instancias ejecutan software específico y cuáles necesitan actualizaciones.

### 2.2 Acceder a Fleet Manager

1. En el panel de navegación izquierdo de Systems Manager, expandir **Node Management**
2. Hacer clic en **Fleet Manager**

### 2.3 Configurar el Inventario

1. Hacer clic en el menú desplegable **Account management**
2. Seleccionar **Set up inventory**

### 2.4 Crear la Asociación de Inventario

Configurar los siguientes parámetros:

**En la sección "Provide inventory details":**
- **Name**: `Inventory-Association`

**En la sección "Targets":**
- **Specify targets by**: Seleccionar `Manually selecting instances`
- Seleccionar la casilla de **Managed Instance**

**Otras opciones:**
- Dejar todas las demás opciones con sus valores predeterminados

### 2.5 Finalizar la Configuración

1. Hacer clic en **Setup Inventory**
2. Aparecerá un banner con el mensaje "Setup inventory request succeeded"

> **Explicación**: Se ha creado una asociación que recopilará regularmente información sobre las propiedades seleccionadas de la instancia.

### 2.6 Revisar el Inventario

1. En la página de Fleet Manager, hacer clic en el enlace **Node ID** de la instancia
2. Esto te dirigirá a la página **Node overview**
3. Hacer clic en la pestaña **Inventory**

**Observaciones:**
- Esta pestaña lista todas las aplicaciones instaladas en la instancia
- Revisar las aplicaciones instaladas
- Explorar las diferentes opciones en el menú desplegable **Inventory type**:
  - AWS Components
  - Applications
  - Instance Information
  - Network Configuration
  - Windows Updates
  - Custom Inventory

**✅ Resultado**: Inventario de la instancia configurado exitosamente sin necesidad de conectarse por SSH

---

## 3. Instalar Aplicación con Run Command

### 3.1 Descripción de la Tarea

En esta tarea, se instalará una aplicación web personalizada (Widget Manufacturing Dashboard) usando Run Command. Run Command ejecutará un script que instalará:
- Servidor web Apache
- PHP
- AWS SDK
- La aplicación web
- Iniciará el servidor web

### 3.2 Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────┐
│                  AWS Cloud                      │
│  ┌───────────────────────────────────────────┐  │
│  │              VPC                          │  │
│  │  ┌─────────────────────────────────────┐  │  │
│  │  │      EC2 Instance                   │  │  │
│  │  │  ┌──────────────────────────────┐   │  │  │
│  │  │  │  Widget Manufacturing App    │   │  │  │
│  │  │  │  Apache + PHP + AWS SDK      │   │  │  │
│  │  │  └──────────────────────────────┘   │  │  │
│  │  └─────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
         ▲
         │ Run Command
         │
    ┌────┴─────┐
    │  Usuario │
    └──────────┘
```

### 3.3 Acceder a Run Command

1. En la esquina superior izquierda, expandir el menú de navegación
2. En **Node Management**, hacer clic en **Run Command**
3. Hacer clic en **Run command**

### 3.4 Seleccionar el Documento

1. Hacer clic en el icono de búsqueda 🔍 en el cuadro de búsqueda
2. Aparecerá un menú desplegable, seleccionar:
   - **Owner**: `Owned by me`

> **Importante**: No escribir "Owner" o "Owned by me" en el cuadro de búsqueda. Usar el menú desplegable.

3. Aparecerá un documento personalizado
4. Si no está seleccionado, seleccionar el botón del documento

**Información del documento:**
- **Description**: Install Dashboard App
- **Document version**: 1 (Default)

5. Dejar **Document version** en el valor predeterminado

### 3.5 Configurar los Objetivos

**Target selection:**
- Seleccionar **Choose instances manually**

**En la sección "Instances":**
- Seleccionar **Managed Instance**

> **Nota**: La instancia administrada tiene el agente de Systems Manager instalado, lo que permite que sea seleccionada para Run Command. También es posible identificar instancias objetivo usando etiquetas (tags) para ejecutar comandos en toda una flota de instancias.

### 3.6 Configurar las Opciones de Salida

**En la sección "Output options":**
- Desmarcar **Enable an S3 bucket**

### 3.7 Revisar el Comando CLI (Opcional)

1. Expandir la sección **AWS command line interface command**
2. Esta sección muestra el comando CLI que inicia Run Command
3. Puedes copiar este comando para usarlo en scripts futuros

**Ejemplo:**
```bash
aws ssm send-command \
  --document-name "Install-Dashboard-App" \
  --instance-ids "i-1234567890abcdef0" \
  --region us-west-2
```

### 3.8 Ejecutar el Comando

1. Hacer clic en **Run**
2. Aparecerá un banner con el **Command ID** indicando que se envió exitosamente
3. Esperar 1-2 minutos
4. El **Overall status** debería cambiar a **Success**
5. Si no cambia, hacer clic en el icono de actualización 🔄

**✅ Resultado**: Aplicación instalada exitosamente usando Run Command sin acceso SSH

### 3.9 Validar la Aplicación Instalada

1. En la consola de Vocareum, hacer clic en el menú desplegable **Details**
2. Seleccionar **Show**
3. Copiar el valor de **ServerIP** (dirección IP pública)
4. Abrir una nueva pestaña del navegador
5. Pegar la dirección IP y presionar Enter

**Resultado esperado:**
- Se mostrará el **Widget Manufacturing Dashboard**
- La aplicación muestra gráficos de manufactura de widgets

---

## 4. Gestionar Configuraciones con Parameter Store

### 4.1 Descripción de Parameter Store

Parameter Store proporciona almacenamiento jerárquico y seguro para:
- Datos de configuración
- Gestión de secretos
- Contraseñas
- Cadenas de conexión a bases de datos
- Códigos de licencia

Los valores se pueden almacenar como:
- Texto plano
- Datos cifrados

### 4.2 Acceder a Parameter Store

1. Mantener abierta la pestaña del navegador con Widget Manufacturing Dashboard
2. Volver a la pestaña de AWS Systems Manager
3. En el panel de navegación izquierdo, en **Application Management**, hacer clic en **Parameter Store**

### 4.3 Crear un Parámetro

1. Hacer clic en **Create parameter**

Configurar los siguientes valores:

**Detalles del parámetro:**
- **Name**: `/dashboard/show-beta-features`
- **Description**: `Display beta features`
- **Tier**: Dejar el valor predeterminado (Standard)
- **Type**: Dejar el valor predeterminado (String)
- **Value**: `True`

2. Hacer clic en **Create parameter**

3. Aparecerá un banner: "Create parameter request succeeded"

**Explicación:**
- El parámetro se especifica como una ruta jerárquica: `/dashboard/<opción>`
- La aplicación en EC2 verifica automáticamente este parámetro
- Si encuentra el parámetro, muestra funciones adicionales

### 4.4 Verificar el Efecto del Parámetro

1. Volver a la pestaña del navegador con la aplicación
2. Refrescar la página web (F5 o Ctrl+R)

**Resultado esperado:**
- Ahora se muestran **tres gráficos** en lugar de dos
- El tercer gráfico es una función beta activada por el parámetro

> **Concepto**: Es común configurar aplicaciones para mostrar "dark features" (funciones instaladas pero no activadas) que se pueden habilitar dinámicamente.

### 4.5 Experimento Opcional

**Para verificar el comportamiento:**
1. Volver a Parameter Store
2. Eliminar el parámetro `/dashboard/show-beta-features`
3. Refrescar la pestaña de la aplicación
4. El tercer gráfico desaparecerá nuevamente

**✅ Resultado**: Configuración de aplicación gestionada dinámicamente con Parameter Store

---

## 5. Acceder a Instancias con Session Manager

### 5.1 Descripción de Session Manager

Session Manager permite gestionar instancias EC2 a través de:
- Shell interactivo basado en navegador
- AWS Command Line Interface (AWS CLI)

**Ventajas de Session Manager:**
- ✅ No requiere puertos de entrada abiertos
- ✅ No necesita bastion hosts
- ✅ No requiere gestión de claves SSH
- ✅ Acceso controlado mediante políticas IAM
- ✅ Registros de auditoría completos en CloudTrail
- ✅ Acceso multiplataforma con un solo paso

### 5.2 Diagrama de Arquitectura

```
┌─────────────────────────────────────────────────┐
│                  AWS Cloud                      │
│  ┌───────────────────────────────────────────┐  │
│  │              VPC                          │  │
│  │  ┌─────────────────────────────────────┐  │  │
│  │  │      EC2 Instance                   │  │  │
│  │  │  (Sin puertos SSH abiertos)         │  │  │
│  │  └─────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────┘  │
└─────────────────────────────────────────────────┘
         ▲
         │ Session Manager
         │ (Conexión segura sin SSH)
         │
    ┌────┴─────┐
    │  Usuario │
    └──────────┘
```

### 5.3 Acceder a Session Manager

1. En el panel de navegación izquierdo, en **Node Management**, hacer clic en **Session Manager**
2. Hacer clic en **Start session**
3. Seleccionar **Managed Instance**
4. Hacer clic en **Start session**

**Resultado:**
- Se abrirá una nueva pestaña de sesión en el navegador
- Aparecerá una terminal de línea de comandos

### 5.4 Activar el Cursor

1. Hacer clic en cualquier lugar de la ventana de sesión para activar el cursor
2. El cursor debería estar parpadeando y listo para recibir comandos

### 5.5 Listar Archivos de la Aplicación

Ejecutar el siguiente comando:

```bash
ls /var/www/html
```

**Salida esperada:**
```
dblogger.php  getmetrics.php  graph.html  index.php
```

**Explicación:**
- Este comando lista los archivos de la aplicación instalados en la instancia
- Confirma que la instalación de Run Command fue exitosa

### 5.6 Obtener Información de la Instancia EC2

Ejecutar los siguientes comandos:

```bash
# Obtener la región
AZ=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFAULT_REGION=${AZ::-1}

# Listar información sobre instancias EC2
aws ec2 describe-instances
```

**Explicación del comando:**
1. **Primera línea**: Obtiene la zona de disponibilidad desde los metadatos de la instancia
2. **Segunda línea**: Extrae la región eliminando el último carácter (la zona)
3. **Tercera línea**: Lista detalles de las instancias EC2 en formato JSON

**Salida esperada:**
```json
{
    "Reservations": [
        {
            "Groups": [],
            "Instances": [
                {
                    "AmiLaunchIndex": 0,
                    "ImageId": "ami-0c55b159cbfafe1f0",
                    "InstanceId": "i-1234567890abcdef0",
                    "InstanceType": "t2.micro",
                    "State": {
                        "Code": 16,
                        "Name": "running"
                    },
                    "PrivateIpAddress": "10.0.1.100",
                    "PublicIpAddress": "54.123.45.67",
                    ...
                }
            ]
        }
    ]
}
```

### 5.7 Verificar Seguridad (Opcional)

**Para confirmar que SSH está cerrado:**
1. Ir a la consola de EC2
2. Seleccionar la instancia administrada
3. Revisar el grupo de seguridad
4. Verificar que el puerto 22 (SSH) NO está abierto

**Ventajas de Session Manager:**
- ✅ Acceso sin SSH tradicional
- ✅ Acceso restringido mediante políticas IAM
- ✅ Registros de uso en AWS CloudTrail
- ✅ Mejor seguridad y auditoría que SSH tradicional

### 5.8 Cerrar la Sesión

1. Para salir de la sesión, hacer clic en **Terminate**
2. Confirmar la terminación de la sesión

**✅ Resultado**: Acceso exitoso a la instancia mediante Session Manager sin usar SSH

---

## 📊 Resumen de Tareas Completadas

| Tarea | Herramienta | Resultado |
|-------|-------------|-----------|
| Inventario de instancias | Fleet Manager | Recopilación automática de software y configuraciones |
| Instalación de aplicación | Run Command | Widget Manufacturing Dashboard instalado sin SSH |
| Gestión de configuraciones | Parameter Store | Activación dinámica de funciones beta |
| Acceso a línea de comandos | Session Manager | Acceso seguro sin puertos SSH abiertos |

---

## 🎓 Conclusiones Clave

1. **Fleet Manager**: Permite obtener inventarios completos de instancias sin conectarse individualmente
2. **Run Command**: Ejecuta scripts y comandos en múltiples instancias simultáneamente sin SSH
3. **Parameter Store**: Gestiona configuraciones de aplicaciones de forma centralizada y dinámica
4. **Session Manager**: Proporciona acceso seguro y auditable sin necesidad de SSH tradicional
5. **Automatización**: Systems Manager permite gestionar infraestructura a escala de manera eficiente

---

## 🔗 Recursos Útiles

- [AWS Systems Manager User Guide](https://docs.aws.amazon.com/systems-manager/latest/userguide/)
- [Fleet Manager Documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/fleet.html)
- [Run Command Documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/execute-remote-commands.html)
- [Parameter Store Documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html)
- [Session Manager Documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html)

---

**Laboratorio completado exitosamente** ✅
