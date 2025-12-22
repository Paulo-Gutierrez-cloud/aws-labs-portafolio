# Migrating to Amazon RDS

![RDS](https://img.shields.io/badge/AWS-RDS-orange?style=for-the-badge&logo=amazon-aws)
![Database](https://img.shields.io/badge/Database-MariaDB-blue?style=for-the-badge&logo=mariadb)
![Migration](https://img.shields.io/badge/Migration-Database-green?style=for-the-badge)

## 📋 Descripción del Laboratorio

Este laboratorio proporciona experiencia práctica en la migración de una base de datos local a Amazon RDS. Aprenderás a crear instancias RDS usando AWS CLI, migrar datos con mysqldump, configurar subnets privadas, security groups, y monitorear el rendimiento con CloudWatch.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Crear instancia Amazon RDS MariaDB usando AWS CLI
- ✅ Migrar datos desde base de datos local a RDS
- ✅ Configurar subnets privadas y DB subnet groups
- ✅ Configurar security groups para RDS
- ✅ Actualizar aplicación para usar RDS
- ✅ Monitorear RDS con CloudWatch metrics

## 🏗️ Arquitectura

### Arquitectura Inicial
```
┌────────────────────────────────────────┐
│           Cafe VPC                     │
│  ┌──────────────────────────────────┐  │
│  │    Public Subnet                 │  │
│  │  ┌────────────────────────────┐  │  │
│  │  │  CafeInstance (LAMP)       │  │  │
│  │  │  - Apache                  │  │  │
│  │  │  - MySQL (local)           │  │  │
│  │  │  - PHP                     │  │  │
│  │  │  - Café Application        │  │  │
│  │  └────────────────────────────┘  │  │
│  │                                  │  │
│  │  ┌────────────────────────────┐  │  │
│  │  │  CLI Host                  │  │  │
│  │  └────────────────────────────┘  │  │
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

### Arquitectura Final
```
┌────────────────────────────────────────────────────────────┐
│                    Cafe VPC                                │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Public Subnet                           │  │
│  │  ┌────────────────────────────────────────────────┐  │  │
│  │  │  CafeInstance (LAMP)                           │  │  │
│  │  │  - Apache                                      │  │  │
│  │  │  - PHP                                         │  │  │
│  │  │  - Café Application ───────┐                  │  │  │
│  │  └────────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────┘  │
│                                  │                         │
│  ┌──────────────────────────────────────────────────────┐  │
│  │         Private Subnets (Multi-AZ)                   │  │
│  │  ┌────────────────┐    ┌────────────────┐          │  │
│  │  │ Private Sub 1  │    │ Private Sub 2  │          │  │
│  │  │  (AZ-a)        │    │  (AZ-b)        │          │  │
│  │  └────────────────┘    └────────────────┘          │  │
│  │           │                                          │  │
│  │  ┌────────────────────────────────────────────────┐  │  │
│  │  │  RDS Instance (CafeDBInstance)                 │  │  │
│  │  │  - MariaDB 10.5.13                             │  │  │
│  │  │  - db.t3.micro                                 │  │  │
│  │  │  - CafeDatabaseSG                              │  │  │
│  │  └────────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────┘
```

## 📁 Estructura del Proyecto

```
11-rds-migration/
├── README.md                      # Este archivo
├── docs/
│   ├── step-by-step-guide.md     # Guía detallada
│   ├── commands-reference.md      # Comandos AWS CLI
│   └── results.md                 # Resultados
├── scripts/
│   ├── create-rds-instance.sh    # Script de creación RDS
│   └── migrate-database.sh        # Script de migración
└── assets/
    └── architecture.txt           # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab)
- Instancia EC2 con MySQL local
- AWS CLI configurado
- Datos de prueba en base de datos local

### Pasos Principales

1. **Generar datos de prueba**
   - Acceder a aplicación café
   - Realizar pedidos de prueba

2. **Crear componentes prerequisitos**
   ```bash
   # Security group
   aws ec2 create-security-group --group-name CafeDatabaseSG
   
   # Private subnets
   aws ec2 create-subnet --cidr-block 10.200.2.0/23
   aws ec2 create-subnet --cidr-block 10.200.10.0/23
   
   # DB subnet group
   aws rds create-db-subnet-group
   ```

3. **Crear instancia RDS**
   ```bash
   aws rds create-db-instance \
     --db-instance-identifier CafeDBInstance \
     --engine mariadb \
     --db-instance-class db.t3.micro
   ```

4. **Migrar datos**
   ```bash
   # Backup
   mysqldump --databases cafe_db > cafedb-backup.sql
   
   # Restore
   mysql --host=<RDS-endpoint> < cafedb-backup.sql
   ```

5. **Actualizar aplicación**
   - Modificar parámetro /cafe/dbUrl en Parameter Store

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones detalladas
- **[Referencia de Comandos](./docs/commands-reference.md)**: AWS CLI y MySQL
- **[Resultados](./docs/results.md)**: Resultados y análisis

## 🔑 Conceptos Clave Aprendidos

- **Amazon RDS**: Base de datos administrada
- **Database Migration**: Migración con mysqldump
- **Multi-AZ Deployment**: Alta disponibilidad
- **DB Subnet Groups**: Subnets para RDS
- **Security Groups**: Protección de base de datos
- **Parameter Store**: Gestión de configuración
- **CloudWatch Metrics**: Monitoreo de RDS
- **Automated Backups**: Respaldos automáticos

## 🛠️ Tecnologías Utilizadas

- **Amazon RDS**: Servicio de base de datos administrada
- **MariaDB**: Motor de base de datos
- **AWS CLI**: Automatización
- **mysqldump**: Herramienta de backup
- **CloudWatch**: Monitoreo
- **Systems Manager**: Parameter Store
- **VPC**: Networking

## 📊 Resultados

- ✅ Instancia RDS creada en multi-AZ
- ✅ Datos migrados exitosamente
- ✅ Aplicación usando RDS
- ✅ Security groups configurados
- ✅ Backups automáticos habilitados
- ✅ Monitoreo CloudWatch activo

## 🔧 Configuración de RDS

### Especificaciones
- **Engine**: MariaDB 10.5.13
- **Instance Class**: db.t3.micro
- **Storage**: 20 GB
- **Multi-AZ**: No (single AZ)
- **Backup Retention**: 1 día
- **Username**: root
- **Password**: Re:Start!9

### Networking
- **VPC**: Cafe VPC
- **Subnets**: 2 private subnets
- **Security Group**: CafeDatabaseSG (port 3306)
- **Public Access**: No

## 📈 CloudWatch Metrics

- **CPUUtilization**: Uso de CPU
- **DatabaseConnections**: Conexiones activas
- **FreeStorageSpace**: Espacio disponible
- **FreeableMemory**: Memoria disponible
- **WriteIOPS**: Operaciones de escritura
- **ReadIOPS**: Operaciones de lectura

## 🎓 Recursos Adicionales

- [AWS CLI Documentation for RDS](https://docs.aws.amazon.com/cli/latest/reference/rds/)
- [Overview of Monitoring Metrics in Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MonitoringOverview.html)
- [Working with DB Subnet Groups](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html)
- [Migrating Data to Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MySQL.Procedural.Importing.html)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
