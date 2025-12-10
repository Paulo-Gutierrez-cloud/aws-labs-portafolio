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
| **Fundamentos** | 2 | 0 | 2 |
| **Compute** | 0 | 0 | 2 |
| **Storage** | 0 | 0 | 2 |
| **Networking** | 0 | 0 | 2 |
| **Security** | 0 | 0 | 2 |
| **Serverless** | 0 | 0 | 2 |
| **Total** | **2** | **0** | **12** |

## 🏗️ Estructura del Repositorio

```
aws-labs-portafolio/
├── README.md                          # Este archivo
├── .gitignore                         # Protección de credenciales
├── labs/
│   ├── 01-aws-cli-installation/       # Lab 1: AWS CLI
│   ├── 02-aws-systems-manager/        # Lab 2: Systems Manager
│   └── ...
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

**Última actualización**: Diciembre 2025 | **Labs completados**: 2/14

⭐ Si encuentras útil este repositorio, considera darle una estrella!
