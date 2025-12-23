# 🚀 AWS Labs - Portafolio de Prácticas

![AWS](https://img.shields.io/badge/AWS-Cloud%20Computing-orange?style=for-the-badge&logo=amazon-aws)
![Labs](https://img.shields.io/badge/Labs-En%20Progreso-blue?style=for-the-badge)
![Documentación](https://img.shields.io/badge/Documentaci%C3%B3n-Completa-green?style=for-the-badge)

## 👨‍💻 Sobre Este Portafolio

Este repositorio contiene una colección de laboratorios prácticos de AWS que he completado como parte de mi aprendizaje y desarrollo profesional en Cloud Computing. Cada laboratorio está completamente documentado con guías paso a paso, scripts, diagramas de arquitectura y conclusiones.

## 📚 Laboratorios Completados

### 1. [AWS CLI Installation and Configuration](./labs/01-aws-cli-installation/)
**Nivel**: Principiante | **Duración**: ~45 min | **Servicios**: EC2, IAM, AWS CLI

Instalación y configuración del AWS Command Line Interface en una instancia Red Hat Linux EC2. Incluye autenticación con IAM, gestión de políticas y automatización de comandos.

**Habilidades desarrolladas**:
- ✅ Instalación de AWS CLI en Linux
- ✅ Configuración de credenciales IAM
- ✅ Gestión de usuarios y políticas IAM
- ✅ Automatización con scripts bash
- ✅ Conexión SSH a instancias EC2

**[Ver documentación completa →](./labs/01-aws-cli-installation/)**

---

### 2. [AWS Systems Manager](./labs/02-aws-systems-manager/)
**Nivel**: Intermedio | **Duración**: ~30 min | **Servicios**: Systems Manager, EC2, IAM

Gestión centralizada de instancias EC2 usando AWS Systems Manager. Incluye Fleet Manager para inventarios, Run Command para ejecución remota, Parameter Store para configuraciones y Session Manager para acceso seguro sin SSH.

**Habilidades desarrolladas**:
- ✅ Configuración de Fleet Manager para inventarios
- ✅ Ejecución remota de comandos con Run Command
- ✅ Gestión de parámetros con Parameter Store
- ✅ Acceso seguro con Session Manager
- ✅ Automatización sin SSH tradicional

**[Ver documentación completa →](./labs/02-aws-systems-manager/)**

---

### 3. [Creating a Website on S3](./labs/03-s3-static-website/)
**Nivel**: Intermedio | **Duración**: ~45 min | **Servicios**: S3, IAM, AWS CLI

Creación y despliegue de un sitio web estático en Amazon S3. Incluye configuración de buckets, gestión de permisos IAM, automatización de despliegues con scripts bash, y optimización con aws s3 sync.

**Habilidades desarrolladas**:
- ✅ Creación y configuración de buckets S3
- ✅ Hosting de sitios web estáticos en S3
- ✅ Gestión de usuarios y políticas IAM
- ✅ Automatización de despliegues con scripts
- ✅ Optimización con aws s3 sync

**[Ver documentación completa →](./labs/03-s3-static-website/)**

---

### 4. [Creating Amazon EC2 Instances](./labs/04-ec2-instances/)
**Nivel**: Intermedio | **Duración**: ~45 min | **Servicios**: EC2, IAM, AWS CLI

Lanzamiento de instancias EC2 usando múltiples métodos. Incluye creación desde la consola, uso de bastion hosts, lanzamiento con AWS CLI, configuración con user data, y automatización de despliegues.

**Habilidades desarrolladas**:
- ✅ Lanzamiento de EC2 desde consola y CLI
- ✅ Configuración de bastion hosts
- ✅ Uso de EC2 Instance Connect
- ✅ Automatización con user data scripts
- ✅ Gestión de AMIs y security groups

**[Ver documentación completa →](./labs/04-ec2-instances/)**

---

### 5. [Troubleshooting EC2 Instance Creation](./labs/05-ec2-troubleshooting/)
**Nivel**: Intermedio-Avanzado | **Duración**: ~45 min | **Servicios**: EC2, AWS CLI, Troubleshooting

Troubleshooting y resolución de problemas en la creación de instancias EC2. Incluye identificación de errores, uso de herramientas de diagnóstico (nmap), despliegue de LAMP stack, y verificación de aplicaciones web.

**Habilidades desarrolladas**:
- ✅ Troubleshooting sistemático de AWS CLI
- ✅ Diagnóstico con nmap y logs
- ✅ Resolución de problemas de security groups
- ✅ Despliegue y verificación de LAMP stack
- ✅ Análisis de logs de cloud-init

**[Ver documentación completa →](./labs/05-ec2-troubleshooting/)**

---

### 6. [Scaling and Load Balancing Your Architecture](./labs/06-auto-scaling-load-balancing/)
**Nivel**: Intermedio-Avanzado | **Duración**: ~45 min | **Servicios**: ELB, Auto Scaling, CloudWatch

Implementación de alta disponibilidad y escalabilidad automática usando Elastic Load Balancing y Auto Scaling. Incluye creación de AMIs, configuración de load balancers, launch templates, Auto Scaling groups, y monitoreo con CloudWatch.

**Habilidades desarrolladas**:
- ✅ Creación de AMIs desde instancias
- ✅ Configuración de Application Load Balancer
- ✅ Implementación de Auto Scaling groups
- ✅ Políticas de escalado basadas en métricas
- ✅ Monitoreo con CloudWatch alarms

**[Ver documentación completa →](./labs/06-auto-scaling-load-balancing/)**

---

### 7. [Using Auto Scaling in AWS (Linux)](./labs/07-auto-scaling-cli/)
**Nivel**: Intermedio-Avanzado | **Duración**: ~45 min | **Servicios**: Auto Scaling, ELB, AWS CLI

Implementación completa de Auto Scaling usando AWS CLI. Incluye creación de instancias EC2, generación de AMIs, configuración de load balancers, launch templates, y Auto Scaling groups completamente automatizado vía comandos CLI.

**Habilidades desarrolladas**:
- ✅ Creación de instancias con AWS CLI
- ✅ Generación de AMIs con comandos CLI
- ✅ Automatización completa de Auto Scaling
- ✅ Configuración de load balancers vía CLI
- ✅ Scripting de infraestructura escalable

**[Ver documentación completa →](./labs/07-auto-scaling-cli/)**

---

### 8. [Automation with CloudFormation](./labs/08-cloudformation/)
**Nivel**: Intermedio | **Duración**: ~45 min | **Servicios**: CloudFormation, VPC, EC2, S3

Implementación de Infrastructure as Code usando AWS CloudFormation. Incluye creación de templates YAML, despliegue de stacks, actualización de recursos, uso de parámetros y referencias, y gestión del ciclo de vida completo de infraestructura.

**Habilidades desarrolladas**:
- ✅ Creación de templates CloudFormation en YAML
- ✅ Despliegue y actualización de stacks
- ✅ Uso de parámetros y referencias (!Ref)
- ✅ Infrastructure as Code (IaC)
- ✅ Gestión automática de recursos

**[Ver documentación completa →](./labs/08-cloudformation/)**

---

### 9. [Amazon Route 53 Failover Routing](./labs/09-route53-failover/)
**Nivel**: Intermedio | **Duración**: ~45 min | **Servicios**: Route 53, SNS, EC2

Implementación de alta disponibilidad con Route 53 failover routing. Incluye configuración de health checks, registros DNS de failover, notificaciones SNS, y verificación de failover automático entre Availability Zones.

**Habilidades desarrolladas**:
- ✅ Configuración de Route 53 health checks
- ✅ Implementación de failover routing
- ✅ Configuración de SNS para alertas
- ✅ Alta disponibilidad multi-AZ
- ✅ Gestión de registros DNS

**[Ver documentación completa →](./labs/09-route53-failover/)**

---

### 10. [Working with AWS Lambda](./labs/10-lambda-functions/)
**Nivel**: Intermedio-Avanzado | **Duración**: ~60 min | **Servicios**: Lambda, SNS, CloudWatch, Systems Manager

Implementación de soluciones serverless con AWS Lambda. Incluye creación de Lambda layers, funciones con acceso a VPC, integración con SNS, triggers programados con CloudWatch Events, y troubleshooting con CloudWatch Logs.

**Habilidades desarrolladas**:
- ✅ Creación de Lambda layers
- ✅ Funciones Lambda con VPC
- ✅ Triggers CloudWatch Events (Cron)
- ✅ Integración con SNS
- ✅ Troubleshooting con CloudWatch Logs

**[Ver documentación completa →](./labs/10-lambda-functions/)**

---

### 11. [Migrating to Amazon RDS](./labs/11-rds-migration/)
**Nivel**: Intermedio | **Duración**: ~60 min | **Servicios**: RDS, EC2, Systems Manager, CloudWatch

Migración de base de datos local a Amazon RDS. Incluye creación de instancia RDS con AWS CLI, configuración de subnets privadas y security groups, migración de datos con mysqldump, y monitoreo con CloudWatch metrics.

**Habilidades desarrolladas**:
- ✅ Creación de RDS con AWS CLI
- ✅ Migración de bases de datos
- ✅ Configuración de DB subnet groups
- ✅ Monitoreo con CloudWatch
- ✅ Gestión de Parameter Store

**[Ver documentación completa →](./labs/11-rds-migration/)**

---

### 12. [Configuring a VPC](./labs/12-vpc-configuration/)
**Nivel**: Fundamental | **Duración**: ~45 min | **Servicios**: VPC, EC2, NAT Gateway

Construcción completa de VPC desde cero. Incluye creación de subnets públicas y privadas, configuración de Internet Gateway, NAT Gateway, route tables, y despliegue de bastion server para acceso seguro a recursos privados.

**Habilidades desarrolladas**:
- ✅ Creación y configuración de VPC
- ✅ Subnets públicas y privadas
- ✅ Internet Gateway y NAT Gateway
- ✅ Configuración de route tables
- ✅ Bastion server deployment

**[Ver documentación completa →](./labs/12-vpc-configuration/)**

---

### 13. [Troubleshooting a VPC](./labs/13-vpc-troubleshooting/)
**Nivel**: Intermedio-Avanzado | **Duración**: ~75 min | **Servicios**: VPC, Flow Logs, S3, AWS CLI

Troubleshooting avanzado de VPC. Incluye creación y análisis de VPC Flow Logs, resolución de problemas de security groups, network ACLs, route tables, y análisis de tráfico de red con herramientas Linux.

**Habilidades desarrolladas**:
- ✅ Creación de VPC Flow Logs
- ✅ Troubleshooting de security groups
- ✅ Troubleshooting de network ACLs
- ✅ Análisis de flow logs
- ✅ Diagnóstico de conectividad

**[Ver documentación completa →](./labs/13-vpc-troubleshooting/)**

---

### 14. [Working with Amazon EBS](./labs/14-amazon-ebs/)
**Nivel**: Fundamental | **Duración**: ~45 min | **Servicios**: EBS, EC2, S3

Gestión completa de Amazon Elastic Block Store. Incluye creación de volúmenes EBS, adjuntar y montar volúmenes, crear sistemas de archivos ext3, snapshots para backup, y restauración de volúmenes desde snapshots.

**Habilidades desarrolladas**:
- ✅ Creación y gestión de volúmenes EBS
- ✅ Montaje de filesystems en Linux
- ✅ Creación de snapshots
- ✅ Restauración desde snapshots
- ✅ Gestión de almacenamiento persistente

**[Ver documentación completa →](./labs/14-amazon-ebs/)**

---

### 15. [Managing Storage](./labs/15-managing-storage/)
**Nivel**: Avanzado | **Duración**: ~45 min | **Servicios**: EBS, S3, EC2, IAM

Gestión avanzada de almacenamiento en AWS usando AWS CLI y Python. Incluye automatización de snapshots EBS con cron jobs, scripts Python para retención de snapshots, sincronización de directorios con S3, versionado de objetos, y recuperación de archivos eliminados.

**Habilidades desarrolladas**:
- ✅ Automatización de snapshots con cron
- ✅ Scripts Python con Boto3
- ✅ Sincronización S3 con AWS CLI
- ✅ Versionado y recuperación de objetos
- ✅ Gestión de IAM roles

**[Ver documentación completa →](./labs/15-managing-storage/)**

---

### 16. [Working with Amazon S3](./labs/16-s3-file-sharing/)
**Nivel**: Avanzado | **Duración**: ~90 min | **Servicios**: S3, IAM, SNS, EC2

Configuración completa de S3 para compartir archivos de forma segura con usuarios externos. Incluye creación de buckets con AWS CLI, gestión de permisos IAM granulares, configuración de notificaciones de eventos S3, integración con Amazon SNS, y pruebas de seguridad.

**Habilidades desarrolladas**:
- ✅ Creación de buckets S3 con AWS CLI
- ✅ Configuración de permisos IAM granulares
- ✅ Event notifications S3 → SNS
- ✅ Integración de email notifications
- ✅ Testing de políticas de seguridad

**[Ver documentación completa →](./labs/16-s3-file-sharing/)**

---

### 17. [Supervisión de la Infraestructura](./labs/17-infrastructure-monitoring/)
**Nivel**: Avanzado | **Duración**: ~60 min | **Servicios**: CloudWatch, Config, SNS, Systems Manager

Supervisión integral de infraestructura AWS. Incluye instalación de CloudWatch Agent con Systems Manager, monitoreo de logs y métricas, creación de alarmas basadas en filtros, notificaciones en tiempo real con EventBridge, y tracking de cumplimiento con AWS Config.

**Habilidades desarrolladas**:
- ✅ CloudWatch Agent deployment
- ✅ Logs y métricas monitoring
- ✅ Metric filters y alarmas
- ✅ EventBridge real-time notifications
- ✅ AWS Config compliance tracking

**[Ver documentación completa →](./labs/17-infrastructure-monitoring/)**

---

## 🎯 Objetivos de Aprendizaje

Este portafolio demuestra conocimientos prácticos en:

- **Compute**: EC2, Auto Scaling, Load Balancing
- **Storage**: S3, EBS, EFS
- **Database**: RDS, DynamoDB
- **Networking**: VPC, Route 53, CloudFront
- **Security**: IAM, Security Groups, KMS
- **Management**: CloudWatch, CloudFormation, AWS CLI
- **Serverless**: Lambda, API Gateway

## 📊 Progreso

| Categoría | Labs Completados | En Progreso | Planeados |
|-----------|------------------|-------------|-----------|
| **Fundamentos** | 7 | 0 | 0 |
| **Compute** | 4 | 0 | 0 |
| **Storage** | 4 | 0 | 0 |
| **Networking** | 2 | 0 | 0 |
| **Security** | 1 | 0 | 1 |
| **Monitoring** | 1 | 0 | 0 |
| **Total** | **17** | **0** | **0** |

## 🏗️ Estructura del Repositorio

```
aws-labs-portafolio/
├── README.md                          # Este archivo
├── .gitignore                         # Protección de credenciales
├── labs/
│   ├── 01-aws-cli-installation/       # Lab 1: AWS CLI
│   ├── 02-aws-systems-manager/        # Lab 2: Systems Manager
│   ├── 03-s3-static-website/          # Lab 3: S3 Static Website
│   ├── 04-ec2-instances/              # Lab 4: Creating EC2 Instances
│   ├── 05-ec2-troubleshooting/        # Lab 5: EC2 Troubleshooting
│   ├── 06-auto-scaling-load-balancing/ # Lab 6: Auto Scaling & ELB
│   ├── 07-auto-scaling-cli/           # Lab 7: Auto Scaling CLI
│   ├── 08-cloudformation/             # Lab 8: CloudFormation
│   ├── 09-route53-failover/           # Lab 9: Route 53 Failover
│   ├── 10-lambda-functions/           # Lab 10: AWS Lambda
│   ├── 11-rds-migration/              # Lab 11: RDS Migration
│   ├── 12-vpc-configuration/          # Lab 12: VPC Configuration
│   ├── 13-vpc-troubleshooting/        # Lab 13: VPC Troubleshooting
│   ├── 14-amazon-ebs/                 # Lab 14: Amazon EBS
│   ├── 15-managing-storage/           # Lab 15: Managing Storage
│   ├── 16-s3-file-sharing/            # Lab 16: S3 File Sharing
│   └── 17-infrastructure-monitoring/  # Lab 17: Infrastructure Monitoring
└── resources/
    ├── templates/                     # Plantillas reutilizables
    └── common-scripts/                # Scripts compartidos
```

## 🛠️ Tecnologías y Herramientas

- **Cloud Provider**: Amazon Web Services (AWS)
- **CLI Tools**: AWS CLI, SSH
- **Scripting**: Bash, Python
- **IaC**: CloudFormation, Terraform (próximamente)
- **Containerization**: Docker, ECS (próximamente)
- **CI/CD**: GitHub Actions (próximamente)

## 📖 Cómo Usar Este Repositorio

Cada laboratorio incluye:

1. **README.md**: Descripción general y guía de inicio rápido
2. **docs/**: Documentación detallada paso a paso
3. **scripts/**: Scripts de automatización
4. **assets/**: Diagramas de arquitectura e imágenes
5. **policies/**: Políticas IAM y configuraciones

Para explorar un laboratorio específico, navega a su carpeta en `labs/` y sigue el README.

## 🎓 Certificaciones en Progreso

- [ ] AWS Certified Cloud Practitioner
- [ ] AWS Certified Solutions Architect - Associate
- [ ] AWS Certified Developer - Associate

## 📈 Próximos Labs

1. **VPC Configuration and Networking** - Configuración de redes virtuales
2. **S3 Static Website Hosting** - Hosting de sitios web estáticos
3. **EC2 Auto Scaling and Load Balancing** - Escalado automático
4. **RDS Database Setup** - Configuración de bases de datos relacionales
5. **Lambda Serverless Functions** - Funciones serverless

## 🔗 Recursos Útiles

- [AWS Documentation](https://docs.aws.amazon.com/)
- [AWS Training and Certification](https://aws.amazon.com/training/)
- [AWS Skill Builder](https://skillbuilder.aws/)
- [AWS Workshops](https://workshops.aws/)

## 👤 Contacto

- **GitHub**: [@Paulo-Gutierrez-cloud](https://github.com/Paulo-Gutierrez-cloud)
- **LinkedIn**: [Tu perfil de LinkedIn]
- **Email**: [Tu email]

## 📝 Licencia

Este repositorio es para fines educativos y de documentación personal.

---

**Última actualización**: Diciembre 2025 | **Labs completados**: 17/17 🎉 **PORTAFOLIO COMPLETO**

⭐ Si encuentras útil este repositorio, considera darle una estrella!
