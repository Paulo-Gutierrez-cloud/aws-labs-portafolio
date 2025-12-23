# Supervisión de la Infraestructura

![CloudWatch](https://img.shields.io/badge/AWS-CloudWatch-orange?style=for-the-badge&logo=amazon-aws)
![Config](https://img.shields.io/badge/AWS-Config-blue?style=for-the-badge)
![SNS](https://img.shields.io/badge/SNS-Notifications-green?style=for-the-badge)
![Monitoring](https://img.shields.io/badge/Monitoring-Complete-yellow?style=for-the-badge)

## 📋 Descripción del Laboratorio

Este laboratorio integral proporciona experiencia práctica en la supervisión completa de infraestructura AWS. Aprenderás a utilizar Amazon CloudWatch (métricas, logs y eventos), AWS Systems Manager, Amazon SNS y AWS Config para monitorear aplicaciones, detectar problemas en tiempo real y garantizar el cumplimiento de políticas organizacionales.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Instalar CloudWatch Agent usando AWS Systems Manager
- ✅ Supervisar logs de aplicaciones con CloudWatch Logs
- ✅ Monitorear métricas del sistema con CloudWatch Metrics
- ✅ Crear notificaciones en tiempo real con EventBridge
- ✅ Rastrear cumplimiento con AWS Config
- ✅ Configurar alarmas basadas en logs y métricas

## 🏗️ Arquitectura

```
┌──────────────────────────────────────────────────────────────────┐
│                    AWS Account - Monitoring                      │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │         AWS Systems Manager                                │  │
│  │  - Run Command                                             │  │
│  │  - Parameter Store (agent config)                          │  │
│  └────────────┬───────────────────────────────────────────────┘  │
│               │                                                  │
│               │ Install & Configure                              │
│               ▼                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │         EC2 Instance: Web Server                           │  │
│  │  ┌──────────────────────────────────────────────────────┐  │  │
│  │  │  CloudWatch Agent                                    │  │  │
│  │  │  - Collects system metrics (CPU, Memory, Disk)       │  │  │
│  │  │  - Collects application logs (Apache)                │  │  │
│  │  └──────────────────────────────────────────────────────┘  │  │
│  │  ┌──────────────────────────────────────────────────────┐  │  │
│  │  │  Apache Web Server                                   │  │  │
│  │  │  - /var/log/httpd/access_log                         │  │  │
│  │  │  - /var/log/httpd/error_log                          │  │  │
│  │  └──────────────────────────────────────────────────────┘  │  │
│  └────────────┬───────────────────────────────────────────────┘  │
│               │                                                  │
│               │ Send Logs & Metrics                              │
│               ▼                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │         Amazon CloudWatch                                  │  │
│  │  ┌──────────────────────────────────────────────────────┐  │  │
│  │  │  CloudWatch Logs                                     │  │  │
│  │  │  - Log Groups: HttpAccessLog, HttpErrorLog           │  │  │
│  │  │  - Metric Filters: 404Errors                         │  │  │
│  │  └──────────────────────────────────────────────────────┘  │  │
│  │  ┌──────────────────────────────────────────────────────┐  │  │
│  │  │  CloudWatch Metrics                                  │  │  │
│  │  │  - CPU, Memory, Disk metrics                         │  │  │
│  │  │  - Custom application metrics                        │  │  │
│  │  └──────────────────────────────────────────────────────┘  │  │
│  │  ┌──────────────────────────────────────────────────────┐  │  │
│  │  │  CloudWatch Alarms                                   │  │  │
│  │  │  - 404 Errors > 5 in 1 minute                        │  │  │
│  │  └──────────────────────────────────────────────────────┘  │  │
│  └────────────┬───────────────────────────────────────────────┘  │
│               │                                                  │
│               │ Trigger Alarms                                   │
│               ▼                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │         Amazon EventBridge                                 │  │
│  │  - EC2 State Change Events                                 │  │
│  │  - Instance Stopped/Terminated notifications               │  │
│  └────────────┬───────────────────────────────────────────────┘  │
│               │                                                  │
│               │ Send Notifications                               │
│               ▼                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │         Amazon SNS                                         │  │
│  │  - Topic: Default_CloudWatch_Alarms_Topic                  │  │
│  │  - Email subscriptions                                     │  │
│  └────────────┬───────────────────────────────────────────────┘  │
│               │                                                  │
│               │ Email Notifications                              │
│               ▼                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │         Administrator Email                                │  │
│  │  - Alarm notifications                                     │  │
│  │  - State change notifications                              │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │         AWS Config                                         │  │
│  │  - Compliance Rules:                                       │  │
│  │    • required-tags (project tag)                           │  │
│  │    • ec2-volume-inuse-check                                │  │
│  │  - Configuration History                                   │  │
│  │  - Compliance Dashboard                                    │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘

Monitoring Flow:
1. Systems Manager installs CloudWatch Agent
2. Agent collects logs and metrics from EC2
3. CloudWatch processes and stores data
4. Metric filters detect patterns (404 errors)
5. Alarms trigger on thresholds
6. EventBridge captures state changes
7. SNS sends email notifications
8. AWS Config tracks compliance
```

## 📁 Estructura del Proyecto

```
17-infrastructure-monitoring/
├── README.md                              # Este archivo
├── scripts/
│   ├── cloudwatch-agent-config.json      # Configuración del agente
│   ├── metric-filter-pattern.txt         # Patrón de filtro de métricas
│   ├── eventbridge-rule.json             # Regla de EventBridge
│   └── config-rules-reference.md          # Referencia de reglas Config
├── docs/
│   ├── cloudwatch-guide.md                # Guía de CloudWatch
│   └── compliance-monitoring.md           # Guía de cumplimiento
└── assets/
    └── architecture.txt                   # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab)
- EC2 instance con Apache instalado
- AWS Systems Manager configurado
- Acceso a email para SNS

### Flujo Principal

#### 1. Instalar CloudWatch Agent
```bash
# Usar Systems Manager Run Command
# Documento: AWS-ConfigureAWSPackage
# Acción: Install
# Nombre: AmazonCloudWatchAgent
# Versión: latest
```

#### 2. Configurar CloudWatch Agent
```json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "log_group_name": "HttpAccessLog",
            "file_path": "/var/log/httpd/access_log",
            "log_stream_name": "{instance_id}",
            "timestamp_format": "%b %d %H:%M:%S"
          }
        ]
      }
    }
  },
  "metrics": {
    "metrics_collected": {
      "cpu": {
        "measurement": ["cpu_usage_idle", "cpu_usage_user"],
        "metrics_collection_interval": 10
      },
      "mem": {
        "measurement": ["mem_used_percent"],
        "metrics_collection_interval": 10
      }
    }
  }
}
```

#### 3. Crear Metric Filter
```bash
# Patrón de filtro para errores 404
[ip, id, user, timestamp, request, status_code=404, size]

# Crear alarma
# Condición: 404Errors >= 5 en 1 minuto
# Acción: Enviar notificación SNS
```

#### 4. Configurar EventBridge
```json
{
  "source": ["aws.ec2"],
  "detail-type": ["EC2 Instance State-change Notification"],
  "detail": {
    "state": ["stopped", "terminated"]
  }
}
```

#### 5. Activar AWS Config
```bash
# Reglas de cumplimiento:
# 1. required-tags: tag "project" requerida
# 2. ec2-volume-inuse-check: volúmenes deben estar en uso
```

## 📚 Documentación Detallada

### Task 1: Instalar CloudWatch Agent

**1.1 Usar Systems Manager Run Command**

1. Navegar a Systems Manager → Run Command
2. Ejecutar comando: `AWS-ConfigureAWSPackage`
3. Parámetros:
   - **Action**: Install
   - **Name**: AmazonCloudWatchAgent
   - **Version**: latest
4. Target: Web Server instance
5. Verificar instalación exitosa

**1.2 Configurar Agent en Parameter Store**

```json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "log_group_name": "HttpAccessLog",
            "file_path": "/var/log/httpd/access_log",
            "log_stream_name": "{instance_id}",
            "timestamp_format": "%b %d %H:%M:%S"
          },
          {
            "log_group_name": "HttpErrorLog",
            "file_path": "/var/log/httpd/error_log",
            "log_stream_name": "{instance_id}",
            "timestamp_format": "%b %d %H:%M:%S"
          }
        ]
      }
    }
  },
  "metrics": {
    "metrics_collected": {
      "cpu": {
        "measurement": [
          "cpu_usage_idle",
          "cpu_usage_iowait",
          "cpu_usage_user",
          "cpu_usage_system"
        ],
        "metrics_collection_interval": 10,
        "totalcpu": false
      },
      "disk": {
        "measurement": ["used_percent", "inodes_free"],
        "metrics_collection_interval": 10,
        "resources": ["*"]
      },
      "mem": {
        "measurement": ["mem_used_percent"],
        "metrics_collection_interval": 10
      },
      "swap": {
        "measurement": ["swap_used_percent"],
        "metrics_collection_interval": 10
      }
    }
  }
}
```

**1.3 Iniciar CloudWatch Agent**

1. Run Command: `AmazonCloudWatch-ManageAgent`
2. Parámetros:
   - **Action**: configure
   - **Mode**: ec2
   - **Optional Configuration Source**: ssm
   - **Optional Configuration Location**: Monitor-Web-Server
   - **Optional Restart**: yes
3. Target: Web Server instance

### Task 2: Supervisar Logs con CloudWatch

**2.1 Generar Logs**
```bash
# Acceder al servidor web
http://WebServerIP/

# Generar errores 404
http://WebServerIP/nonexistent-page
```

**2.2 Ver Logs en CloudWatch**
1. CloudWatch → Log Groups
2. Seleccionar `HttpAccessLog`
3. Ver log streams por instance ID
4. Expandir entradas para detalles

**2.3 Crear Metric Filter**

Patrón de filtro:
```
[ip, id, user, timestamp, request, status_code=404, size]
```

Configuración:
- **Filter Name**: 404Errors
- **Metric Namespace**: LogMetrics
- **Metric Name**: 404Errors
- **Metric Value**: 1

**2.4 Crear Alarma**

Configuración:
- **Metric**: LogMetrics/404Errors
- **Period**: 1 minute
- **Condition**: >= 5
- **Action**: SNS notification
- **Topic**: Default_CloudWatch_Alarms_Topic
- **Email**: tu-email@example.com

### Task 3: Supervisar Métricas del Sistema

**3.1 Ver Métricas en EC2 Console**
1. EC2 → Instances → Web Server
2. Tab "Monitoring"
3. Ver métricas estándar (CPU, Network, Disk)

**3.2 Ver Métricas del CloudWatch Agent**
1. CloudWatch → Metrics → All Metrics
2. Seleccionar `CWAgent`
3. Explorar métricas:
   - **device, fstype, host, path**: Espacio en disco
   - **host**: Memoria del sistema
   - **CPU metrics**: Uso de CPU detallado

**3.3 Crear Dashboards**
1. CloudWatch → Dashboards → Create dashboard
2. Agregar widgets:
   - Line graph: CPU usage
   - Number: Memory used percent
   - Line graph: Disk used percent

### Task 4: Notificaciones en Tiempo Real

**4.1 Crear EventBridge Rule**

1. EventBridge → Rules → Create rule
2. Event pattern:
```json
{
  "source": ["aws.ec2"],
  "detail-type": ["EC2 Instance State-change Notification"],
  "detail": {
    "state": ["stopped", "terminated"]
  }
}
```

3. Target: SNS Topic (Default_CloudWatch_Alarms_Topic)
4. Name: Instance_Stopped_Terminated

**4.2 Probar Notificación**
```bash
# Detener instancia
aws ec2 stop-instances --instance-ids i-xxxxx

# Verificar email de notificación
```

### Task 5: AWS Config - Cumplimiento

**5.1 Activar AWS Config**
1. Config → Get started
2. Configurar grabación de recursos
3. Seleccionar bucket S3 para almacenamiento

**5.2 Agregar Regla: required-tags**

Configuración:
- **Rule**: required-tags
- **tag1Key**: project
- **Scope**: All resources

Resultado:
- ✅ Recursos con tag "project": Compliant
- ❌ Recursos sin tag "project": Non-compliant

**5.3 Agregar Regla: ec2-volume-inuse-check**

Configuración:
- **Rule**: ec2-volume-inuse-check
- **Scope**: EBS volumes

Resultado:
- ✅ Volúmenes attached: Compliant
- ❌ Volúmenes unattached: Non-compliant

**5.4 Ver Compliance Dashboard**
1. Config → Dashboard
2. Ver recursos por compliance status
3. Drill down en non-compliant resources
4. Ver configuration timeline

## 🔑 Conceptos Clave Aprendidos

### CloudWatch Agent
- **Installation**: Deployment con Systems Manager
- **Configuration**: JSON en Parameter Store
- **Logs Collection**: Application y system logs
- **Metrics Collection**: Custom metrics del sistema

### CloudWatch Logs
- **Log Groups**: Organización de logs
- **Log Streams**: Logs por instancia
- **Metric Filters**: Extracción de métricas de logs
- **Insights**: Queries avanzadas

### CloudWatch Metrics
- **Standard Metrics**: EC2, EBS, etc.
- **Custom Metrics**: Del CloudWatch Agent
- **Dashboards**: Visualización personalizada
- **Alarms**: Notificaciones basadas en umbrales

### EventBridge (CloudWatch Events)
- **Event Patterns**: Filtrado de eventos
- **Rules**: Routing de eventos
- **Targets**: SNS, Lambda, etc.
- **Real-time**: Notificaciones inmediatas

### AWS Config
- **Configuration Recording**: Historial de cambios
- **Compliance Rules**: Managed y custom
- **Remediation**: Acciones automáticas
- **Reporting**: Compliance dashboards

## 🛠️ Tecnologías Utilizadas

- **Amazon CloudWatch**: Monitoring completo
- **AWS Systems Manager**: Gestión de instancias
- **Amazon SNS**: Notificaciones
- **Amazon EventBridge**: Event routing
- **AWS Config**: Compliance tracking
- **Amazon EC2**: Compute instances
- **Apache HTTP Server**: Web server

## 📊 Resultados

### CloudWatch Agent
- ✅ Instalado vía Systems Manager
- ✅ Configurado desde Parameter Store
- ✅ Recopilando logs de Apache
- ✅ Enviando métricas del sistema

### CloudWatch Logs
- ✅ 2 log groups creados
- ✅ Metric filter para 404 errors
- ✅ Alarma configurada (>= 5 errors)
- ✅ Notificaciones por email

### CloudWatch Metrics
- ✅ Métricas estándar de EC2
- ✅ Métricas custom del agent
- ✅ CPU, Memory, Disk monitoreados
- ✅ Dashboards creados

### EventBridge
- ✅ Regla para state changes
- ✅ Notificaciones de stop/terminate
- ✅ Integración con SNS

### AWS Config
- ✅ 2 reglas de compliance
- ✅ Recursos auditados
- ✅ Compliance dashboard activo
- ✅ Non-compliant resources identificados

## 💡 Mejores Prácticas

### Monitoring
1. **Comprehensive**: Monitorear logs, métricas y eventos
2. **Proactive**: Alarmas antes de problemas críticos
3. **Centralized**: Consolidar en CloudWatch
4. **Automated**: Usar Systems Manager para deployment

### Alerting
1. **Thresholds**: Definir umbrales realistas
2. **Escalation**: Múltiples niveles de severidad
3. **Actionable**: Notificaciones con contexto
4. **Testing**: Probar alarmas regularmente

### Compliance
1. **Continuous**: Monitoreo continuo con Config
2. **Automated**: Remediation automática
3. **Documented**: Políticas claras
4. **Auditable**: Historial de cambios

### Cost Optimization
1. **Retention**: Políticas de retención de logs
2. **Sampling**: Métricas con intervalos apropiados
3. **Filtering**: Solo logs necesarios
4. **Dashboards**: Reutilizar en lugar de duplicar

## 🎓 Recursos Adicionales

- [CloudWatch Agent](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Install-CloudWatch-Agent.html)
- [CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/)
- [CloudWatch Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/)
- [Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/)
- [AWS Config](https://docs.aws.amazon.com/config/)
- [AWS Systems Manager](https://docs.aws.amazon.com/systems-manager/)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
