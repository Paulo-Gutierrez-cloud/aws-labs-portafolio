# Automation with CloudFormation

![CloudFormation](https://img.shields.io/badge/AWS-CloudFormation-orange?style=for-the-badge&logo=amazon-aws)
![Infrastructure as Code](https://img.shields.io/badge/IaC-Infrastructure%20as%20Code-blue?style=for-the-badge)
![YAML](https://img.shields.io/badge/YAML-Templates-green?style=for-the-badge)

## 📋 Descripción del Laboratorio

Este laboratorio proporciona experiencia práctica en el despliegue y edición de stacks de AWS CloudFormation. Aprenderás a definir infraestructura como código (IaC), desplegar recursos de forma automatizada y consistente, y gestionar el ciclo de vida completo de la infraestructura.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Desplegar un stack de CloudFormation con VPC y Security Groups
- ✅ Configurar stacks con recursos como S3 y EC2
- ✅ Editar y actualizar templates de CloudFormation
- ✅ Usar parámetros y referencias en templates
- ✅ Implementar Infrastructure as Code (IaC)
- ✅ Terminar stacks y eliminar recursos automáticamente

## 🏗️ Arquitectura

### Task 1: VPC y Security Group
```
┌─────────────────────────────────────┐
│      CloudFormation Stack           │
│  ┌───────────────────────────────┐  │
│  │         Lab VPC               │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │   Public Subnet         │  │  │
│  │  │   10.0.0.0/24          │  │  │
│  │  └─────────────────────────┘  │  │
│  │                               │  │
│  │  Security Group (AppSecurityGroup)│
│  └───────────────────────────────┘  │
└─────────────────────────────────────┘
```

### Task 3: Stack Completo
```
┌──────────────────────────────────────────────┐
│      CloudFormation Stack (Lab)              │
│  ┌────────────────────────────────────────┐  │
│  │         Lab VPC (10.0.0.0/16)          │  │
│  │  ┌──────────────────────────────────┐  │  │
│  │  │   Public Subnet (10.0.0.0/24)    │  │  │
│  │  │  ┌────────────────────────────┐  │  │  │
│  │  │  │   EC2 Instance             │  │  │  │
│  │  │  │   (App Server)             │  │  │  │
│  │  │  │   t3.micro                 │  │  │  │
│  │  │  └────────────────────────────┘  │  │  │
│  │  └──────────────────────────────────┘  │  │
│  │                                        │  │
│  │  Security Group (AppSecurityGroup)    │  │
│  └────────────────────────────────────────┘  │
│                                              │
│  S3 Bucket (auto-generated name)            │
└──────────────────────────────────────────────┘
```

## 📁 Estructura del Proyecto

```
08-cloudformation/
├── README.md                      # Este archivo
├── docs/
│   ├── step-by-step-guide.md     # Guía detallada
│   ├── commands-reference.md      # Referencia de comandos
│   └── results.md                 # Resultados
├── templates/
│   ├── task1.yaml                # VPC y Security Group
│   ├── task2.yaml                # + S3 Bucket
│   └── task3.yaml                # + EC2 Instance
└── assets/
    └── architecture.txt           # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab)
- Conocimientos básicos de YAML
- Acceso a CloudFormation console

### Pasos Principales

1. **Desplegar Stack Inicial (Task 1)**
   - Crear VPC con CloudFormation
   - Definir Security Group
   - Usar parámetros para CIDR blocks

2. **Agregar S3 Bucket (Task 2)**
   - Editar template YAML
   - Actualizar stack existente
   - Verificar nuevo recurso

3. **Agregar EC2 Instance (Task 3)**
   - Usar AWS Systems Manager Parameter Store para AMI
   - Referenciar recursos con !Ref
   - Configurar tags y propiedades

4. **Eliminar Stack**
   - Terminar stack completo
   - Verificar eliminación de recursos

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones detalladas
- **[Referencia de Comandos](./docs/commands-reference.md)**: Sintaxis de templates
- **[Resultados](./docs/results.md)**: Resultados y análisis

## 🔑 Conceptos Clave Aprendidos

- **Infrastructure as Code (IaC)**: Definir infraestructura en código
- **CloudFormation Templates**: Estructura YAML/JSON
- **Parameters**: Inputs dinámicos para templates
- **Resources**: Definición de recursos AWS
- **Outputs**: Información exportada del stack
- **!Ref Function**: Referencias entre recursos
- **Stack Updates**: Modificación de infraestructura existente
- **Stack Deletion**: Limpieza automática de recursos

## 🛠️ Tecnologías Utilizadas

- **AWS CloudFormation**: Servicio de IaC
- **YAML**: Formato de templates
- **Amazon VPC**: Redes virtuales
- **Amazon EC2**: Instancias de computación
- **Amazon S3**: Almacenamiento de objetos
- **AWS Systems Manager**: Parameter Store para AMIs

## 📊 Resultados

- ✅ Stack de CloudFormation desplegado
- ✅ VPC y subnet creados
- ✅ Security Group configurado
- ✅ S3 Bucket agregado vía update
- ✅ EC2 Instance desplegada
- ✅ Stack eliminado correctamente

## 🔧 Estructura de Templates

### Secciones Principales

```yaml
Parameters:
  # Inputs dinámicos

Resources:
  # Recursos AWS a crear

Outputs:
  # Información exportada
```

### Ejemplo de Recurso

```yaml
Resources:
  MyBucket:
    Type: AWS::S3::Bucket
  
  MyInstance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: !Ref AmazonLinuxAMIID
      InstanceType: t3.micro
      SubnetId: !Ref PublicSubnet
```

## 🎓 Recursos Adicionales

- [AWS CloudFormation User Guide](https://docs.aws.amazon.com/cloudformation/)
- [CloudFormation Template Reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-reference.html)
- [Amazon S3 Template Snippets](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref-s3.html)
- [AWS::EC2::Instance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-instance.html)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
