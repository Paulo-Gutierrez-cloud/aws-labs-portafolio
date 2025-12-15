# Using Auto Scaling in AWS (Linux)

![Auto Scaling](https://img.shields.io/badge/AWS-Auto%20Scaling-orange?style=for-the-badge&logo=amazon-aws)
![AWS CLI](https://img.shields.io/badge/AWS-CLI-orange?style=for-the-badge&logo=amazon-aws)
![ELB](https://img.shields.io/badge/AWS-ELB-orange?style=for-the-badge&logo=amazon-aws)

## 📋 Descripción del Laboratorio

Este laboratorio demuestra cómo usar AWS CLI para crear instancias EC2, generar AMIs personalizadas, y configurar Auto Scaling con Elastic Load Balancing. Aprenderás a automatizar completamente el despliegue de infraestructura escalable usando comandos de línea.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Crear instancias EC2 usando AWS CLI
- ✅ Crear AMIs personalizadas con AWS CLI
- ✅ Crear launch templates para Auto Scaling
- ✅ Configurar Auto Scaling groups con políticas de escalado
- ✅ Implementar Application Load Balancer
- ✅ Configurar escalado basado en CPU utilization
- ✅ Verificar escalado automático bajo carga

## 🏗️ Arquitectura

### Arquitectura Inicial
```
┌─────────────────────────────────────┐
│           Lab VPC                   │
│  ┌───────────────────────────────┐  │
│  │     Public Subnet             │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │   Command Host          │  │  │
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
│  │  │    Application Load Balancer (WebServerELB)     │  │  │
│  │  └──────────────────────────────────────────────────┘  │  │
│  └────────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌────────────────────────────────────────────────────────┐  │
│  │    Auto Scaling Group (Web App, 2-4 instances)        │  │
│  │  ┌──────────────────┐    ┌──────────────────┐        │  │
│  │  │ Private Subnet 1 │    │ Private Subnet 2 │        │  │
│  │  │  ┌────────────┐  │    │  ┌────────────┐  │        │  │
│  │  │  │ WebApp     │  │    │  │ WebApp     │  │        │  │
│  │  │  │ Instance   │  │    │  │ Instance   │  │        │  │
│  │  │  └────────────┘  │    │  └────────────┘  │        │  │
│  │  │  AZ 1            │    │  AZ 2            │        │  │
│  │  └──────────────────┘    └──────────────────┘        │  │
│  └────────────────────────────────────────────────────────┘  │
│                                                              │
│  Target Tracking: CPU 50% | Scale Out/In Policies          │
└──────────────────────────────────────────────────────────────┘
```

## 📁 Estructura del Proyecto

```
07-auto-scaling-cli/
├── README.md                      # Este archivo
├── docs/
│   ├── step-by-step-guide.md     # Guía detallada
│   ├── commands-reference.md      # Comandos AWS CLI
│   └── results.md                 # Resultados
├── scripts/
│   ├── UserData.txt              # Script de inicialización
│   └── create-instance.sh        # Script de creación de instancia
└── assets/
    └── architecture.txt           # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab)
- Command Host instance configurada
- AWS CLI configurado

### Pasos Principales

1. **Crear instancia EC2 con AWS CLI**
   ```bash
   aws ec2 run-instances --key-name KEYNAME --instance-type t3.micro \
     --image-id AMIID --user-data file:///home/ec2-user/UserData.txt \
     --security-group-ids HTTPACCESS --subnet-id SUBNETID
   ```

2. **Crear AMI personalizada**
   ```bash
   aws ec2 create-image --name WebServerAMI --instance-id INSTANCE-ID
   ```

3. **Crear Application Load Balancer**
   - Configurar en subnets públicas
   - Crear target group
   - Configurar health checks

4. **Crear Launch Template**
   - Usar AMI creada
   - Configurar t3.micro
   - Asignar security group

5. **Crear Auto Scaling Group**
   - Desired: 2, Min: 2, Max: 4
   - Target tracking: CPU 50%
   - Distribuir en private subnets

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones detalladas
- **[Referencia de Comandos](./docs/commands-reference.md)**: Comandos AWS CLI
- **[Resultados](./docs/results.md)**: Resultados y análisis

## 🔑 Conceptos Clave Aprendidos

- **AWS CLI Automation**: Creación de infraestructura vía comandos
- **AMI Creation**: Captura de configuraciones con CLI
- **Launch Templates**: Plantillas para Auto Scaling
- **Auto Scaling Policies**: Escalado basado en métricas
- **Load Balancing**: Distribución de tráfico
- **Target Tracking**: Políticas de escalado automático
- **Multi-AZ Deployment**: Alta disponibilidad

## 🛠️ Tecnologías Utilizadas

- **AWS CLI**: Automatización completa
- **Amazon EC2**: Instancias de computación
- **Auto Scaling**: Escalado automático
- **Application Load Balancer**: Balanceo de carga
- **CloudWatch**: Monitoreo y alarmas
- **AMI**: Amazon Machine Images

## 📊 Resultados

- ✅ Instancia EC2 creada con AWS CLI
- ✅ AMI personalizada generada
- ✅ Load Balancer configurado
- ✅ Auto Scaling Group desplegado
- ✅ Escalado automático verificado
- ✅ Alta disponibilidad implementada

## 🔧 Configuración de Auto Scaling

### Capacidad
- **Desired**: 2 instancias
- **Minimum**: 2 instancias
- **Maximum**: 4 instancias

### Políticas
- **Target Tracking**: CPU Utilization 50%
- **Scale Out**: CPU > 50%
- **Scale In**: CPU < 50%

## 🎓 Recursos Adicionales

- [Amazon EC2 Auto Scaling Getting Started](https://docs.aws.amazon.com/autoscaling/ec2/userguide/GettingStartedTutorial.html)
- [Getting Started with Elastic Load Balancing](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-getting-started.html)
- [AWS CLI EC2 Commands](https://docs.aws.amazon.com/cli/latest/reference/ec2/)
- [AWS CLI Auto Scaling Commands](https://docs.aws.amazon.com/cli/latest/reference/autoscaling/)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
