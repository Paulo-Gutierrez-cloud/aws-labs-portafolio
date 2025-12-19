# Working with AWS Lambda

![Lambda](https://img.shields.io/badge/AWS-Lambda-orange?style=for-the-badge&logo=aws-lambda)
![Serverless](https://img.shields.io/badge/Serverless-Computing-blue?style=for-the-badge)
![Python](https://img.shields.io/badge/Python-3.9-green?style=for-the-badge&logo=python)

## 📋 Descripción del Laboratorio

Este laboratorio proporciona experiencia práctica en el despliegue y configuración de soluciones serverless basadas en AWS Lambda. Aprenderás a crear funciones Lambda, configurar layers, implementar triggers programados, integrar con SNS para notificaciones, y usar CloudWatch para troubleshooting.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Reconocer permisos IAM necesarios para funciones Lambda
- ✅ Crear Lambda layers para dependencias externas
- ✅ Crear funciones Lambda que extraen datos de bases de datos
- ✅ Implementar funciones Lambda con triggers programados
- ✅ Integrar Lambda con SNS para notificaciones
- ✅ Usar CloudWatch logs para troubleshooting
- ✅ Configurar funciones Lambda en VPC

## 🏗️ Arquitectura

```
┌────────────────────────────────────────────────────────────────┐
│                    CloudWatch Events                           │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Cron: 8 PM Mon-Sat                                      │  │
│  └──────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────┘
                          │ (1) Trigger
                          ▼
┌────────────────────────────────────────────────────────────────┐
│              Lambda: salesAnalysisReport                       │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  - Retrieves DB connection from Parameter Store          │  │
│  │  - Invokes data extractor function                       │  │
│  │  - Formats and publishes report                          │  │
│  └──────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────┘
                          │ (2) Invoke
                          ▼
┌────────────────────────────────────────────────────────────────┐
│        Lambda: salesAnalysisReportDataExtractor                │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  - Uses PyMySQL layer                                    │  │
│  │  - Connects to café database                             │  │
│  │  - Runs analytical query                                 │  │
│  └──────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────┘
                          │ (3) Query
                          ▼
┌────────────────────────────────────────────────────────────────┐
│              EC2 Instance (LAMP Stack)                         │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  MySQL Database: cafe_db                                 │  │
│  └──────────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────────┘
                          │ (4) Return data
                          ▼
┌────────────────────────────────────────────────────────────────┐
│              Lambda: salesAnalysisReport                       │
│                      │ (5) Publish                             │
│                      ▼                                          │
│              SNS Topic: salesAnalysisReportTopic               │
│                      │ (6) Email                               │
│                      ▼                                          │
│              Administrator Email                               │
└────────────────────────────────────────────────────────────────┘
```

## 📁 Estructura del Proyecto

```
10-lambda-functions/
├── README.md                              # Este archivo
├── docs/
│   ├── step-by-step-guide.md             # Guía detallada
│   ├── commands-reference.md              # Comandos y configuraciones
│   └── results.md                         # Resultados
├── scripts/
│   ├── salesAnalysisReport.py            # Función principal
│   ├── salesAnalysisReportDataExtractor.py # Extractor de datos
│   └── cron-examples.txt                  # Ejemplos de Cron
└── assets/
    └── architecture.txt                   # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab)
- Base de datos MySQL en EC2
- Conocimientos básicos de Python
- AWS CLI configurado

### Pasos Principales

1. **Observar configuración IAM**
   - Revisar salesAnalysisReportRole
   - Revisar salesAnalysisReportDERole

2. **Crear Lambda Layer**
   - Subir pymysql-v3.zip
   - Configurar runtime Python 3.9

3. **Crear función Data Extractor**
   - Importar código Python
   - Agregar Lambda layer
   - Configurar VPC y security group

4. **Configurar SNS**
   - Crear topic salesAnalysisReportTopic
   - Suscribir email

5. **Crear función principal**
   - Usar AWS CLI
   - Configurar variables de entorno
   - Agregar trigger CloudWatch Events

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones detalladas
- **[Referencia de Comandos](./docs/commands-reference.md)**: AWS CLI y configuraciones
- **[Resultados](./docs/results.md)**: Resultados y análisis

## 🔑 Conceptos Clave Aprendidos

- **Serverless Computing**: Ejecución sin gestión de servidores
- **Lambda Layers**: Reutilización de código y librerías
- **IAM Roles**: Permisos para funciones Lambda
- **VPC Integration**: Acceso a recursos privados
- **CloudWatch Events**: Triggers programados
- **SNS Integration**: Notificaciones automáticas
- **Parameter Store**: Gestión de configuración
- **CloudWatch Logs**: Troubleshooting y monitoreo

## 🛠️ Tecnologías Utilizadas

- **AWS Lambda**: Funciones serverless
- **Amazon SNS**: Notificaciones
- **CloudWatch Events**: Programación de eventos
- **AWS Systems Manager**: Parameter Store
- **Amazon EC2**: Base de datos MySQL
- **Python 3.9**: Lenguaje de programación
- **PyMySQL**: Cliente MySQL para Python
- **AWS CLI**: Automatización

## 📊 Resultados

- ✅ Lambda layer creado con PyMySQL
- ✅ Función data extractor desplegada
- ✅ Función principal configurada
- ✅ SNS topic con suscripción email
- ✅ Trigger CloudWatch Events programado
- ✅ Reportes automáticos funcionando

## 🔧 Configuración de Lambda

### IAM Roles

**salesAnalysisReportRole**:
- AmazonSNSFullAccess
- AmazonSSMReadOnlyAccess
- AWSLambdaBasicExecutionRole
- AWSLambdaRole

**salesAnalysisReportDERole**:
- AWSLambdaBasicExecutionRole
- AWSLambdaVPCAccessExecutionRole

### Lambda Layer
```
pymysqlLibrary/
└── python/
    └── pymysql/
        └── [library files]
```

### CloudWatch Events Cron
```
# 8 PM Mon-Sat (UTC)
cron(0 20 ? * MON-SAT *)

# 8 PM Mon-Sat (EST = UTC-5)
cron(0 1 ? * TUE-SUN *)
```

## 🎓 Recursos Adicionales

- [Using AWS Lambda with Scheduled Events](https://docs.aws.amazon.com/lambda/latest/dg/with-scheduled-events.html)
- [Accessing CloudWatch Logs for Lambda](https://docs.aws.amazon.com/lambda/latest/dg/monitoring-cloudwatchlogs.html)
- [Lambda Layers](https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html)
- [Lambda VPC Configuration](https://docs.aws.amazon.com/lambda/latest/dg/configuration-vpc.html)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
