# Scaling and Load Balancing Your Architecture

![ELB](https://img.shields.io/badge/AWS-ELB-orange?style=for-the-badge&logo=amazon-aws)
![Auto Scaling](https://img.shields.io/badge/AWS-Auto%20Scaling-orange?style=for-the-badge&logo=amazon-aws)
![CloudWatch](https://img.shields.io/badge/AWS-CloudWatch-orange?style=for-the-badge&logo=amazon-aws)

## 📋 Descripción del Laboratorio

Este laboratorio demuestra cómo usar Elastic Load Balancing (ELB) y Amazon EC2 Auto Scaling para balancear carga y escalar automáticamente tu infraestructura. Aprenderás a crear AMIs, configurar load balancers, implementar Auto Scaling groups, y monitorear el rendimiento con CloudWatch.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Crear un AMI desde una instancia EC2
- ✅ Crear y configurar un Application Load Balancer
- ✅ Crear un launch template para Auto Scaling
- ✅ Configurar un Auto Scaling group en subnets privadas
- ✅ Implementar políticas de escalado basadas en métricas
- ✅ Usar CloudWatch alarms para monitorear infraestructura
- ✅ Verificar alta disponibilidad y escalabilidad automática

## 🏗️ Arquitectura

### Arquitectura Inicial
```
┌─────────────────────────────────────┐
│           Lab VPC                   │
│  ┌───────────────────────────────┐  │
│  │     Public Subnet 1           │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │   Web Server 1          │  │  │
│  │  └─────────────────────────┘  │  │
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘
```

### Arquitectura Final
```
┌──────────────────────────────────────────────────────────────┐
│                        Lab VPC                               │
│  ┌────────────────────────────────────────────────────────┐  │
│  │              Public Subnets                            │  │
│  │  ┌──────────────────────────────────────────────────┐  │  │
│  │  │    Application Load Balancer (LabELB)           │  │  │
│  │  └──────────────────────────────────────────────────┘  │  │
│  └────────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌────────────────────────────────────────────────────────┐  │
│  │         Auto Scaling Group (2-4 instances)            │  │
│  │  ┌──────────────────┐    ┌──────────────────┐        │  │
│  │  │ Private Subnet 1 │    │ Private Subnet 2 │        │  │
│  │  │  ┌────────────┐  │    │  ┌────────────┐  │        │  │
│  │  │  │ Lab        │  │    │  │ Lab        │  │        │  │
│  │  │  │ Instance   │  │    │  │ Instance   │  │        │  │
│  │  │  └────────────┘  │    │  └────────────┘  │        │  │
│  │  │  AZ 1            │    │  AZ 2            │        │  │
│  │  └──────────────────┘    └──────────────────┘        │  │
│  └────────────────────────────────────────────────────────┘  │
│                                                              │
│  CloudWatch Alarms: AlarmHigh (CPU > 50%) | AlarmLow       │
└──────────────────────────────────────────────────────────────┘
```

## 📁 Estructura del Proyecto

```
06-auto-scaling-load-balancing/
├── README.md                      # Este archivo
├── docs/
│   ├── step-by-step-guide.md     # Guía detallada paso a paso
│   ├── commands-reference.md      # Comandos y configuraciones
│   └── results.md                 # Resultados y análisis
├── scripts/
│   └── create-ami-cli.sh         # Script para crear AMI con CLI
└── assets/
    ├── architecture-before.txt    # Diagrama arquitectura inicial
    └── architecture-after.txt     # Diagrama arquitectura final
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab o cuenta personal)
- VPC configurada con subnets públicas y privadas
- Instancia EC2 existente (Web Server 1)

### Pasos Principales

1. **Crear AMI desde instancia existente**
   - Seleccionar Web Server 1
   - Actions → Image and templates → Create image

2. **Crear Application Load Balancer**
   - Configurar en subnets públicas
   - Crear target group
   - Configurar health checks

3. **Crear Launch Template**
   - Usar AMI creada
   - Configurar instance type (t3.micro)
   - Asignar security group

4. **Crear Auto Scaling Group**
   - Desired: 2, Min: 2, Max: 4
   - Distribuir en subnets privadas
   - Configurar target tracking (CPU 50%)

5. **Verificar y Probar**
   - Verificar health checks
   - Ejecutar load test
   - Monitorear CloudWatch alarms

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones detalladas de cada tarea
- **[Referencia de Comandos](./docs/commands-reference.md)**: Comandos AWS CLI y configuraciones
- **[Resultados](./docs/results.md)**: Resultados y lecciones aprendidas

## 🔑 Conceptos Clave Aprendidos

- **Elastic Load Balancing**: Distribución automática de tráfico
- **Auto Scaling**: Escalado automático basado en demanda
- **High Availability**: Distribución en múltiples AZs
- **Launch Templates**: Plantillas reutilizables para instancias
- **Target Tracking**: Políticas de escalado basadas en métricas
- **CloudWatch Alarms**: Monitoreo y alertas automáticas
- **AMI Creation**: Captura de configuraciones de instancias

## 🛠️ Tecnologías Utilizadas

- **Application Load Balancer**: Balanceo de carga capa 7
- **EC2 Auto Scaling**: Escalado automático de instancias
- **Amazon CloudWatch**: Monitoreo y alarmas
- **Amazon EC2**: Instancias de computación
- **AMI**: Amazon Machine Images
- **Target Groups**: Agrupación de instancias

## 📊 Resultados

- ✅ AMI creada desde Web Server 1
- ✅ Application Load Balancer configurado
- ✅ Auto Scaling Group desplegado (2-4 instancias)
- ✅ Instancias distribuidas en 2 AZs
- ✅ Escalado automático verificado
- ✅ Alta disponibilidad demostrada
- ✅ CloudWatch alarms funcionando

## 🔧 Configuración de Auto Scaling

### Políticas de Escalado
- **Target Tracking**: CPU Utilization 50%
- **Scale Out**: Cuando CPU > 50% por 3 minutos
- **Scale In**: Cuando CPU < 50% por 3 minutos

### Capacidad
- **Desired**: 2 instancias
- **Minimum**: 2 instancias
- **Maximum**: 4 instancias

## 🎓 Recursos Adicionales

- [Amazon EC2 Auto Scaling Getting Started](https://docs.aws.amazon.com/autoscaling/ec2/userguide/GettingStartedTutorial.html)
- [Getting Started with Elastic Load Balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-getting-started.html)
- [Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/)
- [Target Tracking Scaling Policies](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-target-tracking.html)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
