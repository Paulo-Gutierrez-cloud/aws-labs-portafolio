# Troubleshooting a VPC

![VPC](https://img.shields.io/badge/AWS-VPC-orange?style=for-the-badge&logo=amazon-aws)
![Troubleshooting](https://img.shields.io/badge/Troubleshooting-Networking-red?style=for-the-badge)
![Flow Logs](https://img.shields.io/badge/VPC-Flow%20Logs-blue?style=for-the-badge)

## 📋 Descripción del Laboratorio

Este laboratorio proporciona experiencia práctica en troubleshooting de configuraciones VPC y análisis de VPC Flow Logs. Aprenderás a identificar y resolver problemas de conectividad, configurar flow logs, analizar tráfico de red, y usar AWS CLI para diagnosticar issues de networking.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Crear VPC Flow Logs para capturar tráfico de red
- ✅ Troubleshoot problemas de configuración VPC
- ✅ Analizar security groups y network ACLs
- ✅ Diagnosticar problemas de route tables
- ✅ Analizar flow logs con grep y AWS CLI
- ✅ Resolver problemas de conectividad SSH y HTTP

## 🏗️ Arquitectura

```
┌────────────────────────────────────────────────────────────┐
│                         VPC1                               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Public Subnet                           │  │
│  │  ┌────────────────────────────────────────────────┐  │  │
│  │  │   Café Web Server                              │  │  │
│  │  │   - HTTP Server (port 80)                      │  │  │
│  │  │   - SSH Access (port 22)                       │  │  │
│  │  │   - Issues to troubleshoot                     │  │  │
│  │  └────────────────────────────────────────────────┘  │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                            │
│  VPC Flow Logs ──> S3 Bucket (flowlog######)             │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│                      Separate VPC                          │
│  ┌──────────────────────────────────────────────────────┐  │
│  │   CLI Host Instance                                  │  │
│  │   - AWS CLI configured                               │  │
│  │   - Troubleshooting tools (nmap, grep)              │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────┘

Troubleshooting Tasks:
1. Create VPC Flow Logs
2. Fix Internet Gateway route
3. Fix Security Group rules
4. Fix Network ACL rules
5. Analyze flow logs
```

## 📁 Estructura del Proyecto

```
13-vpc-troubleshooting/
├── README.md                      # Este archivo
├── docs/
│   ├── step-by-step-guide.md     # Guía detallada
│   ├── commands-reference.md      # Comandos de troubleshooting
│   └── results.md                 # Resultados
└── assets/
    └── architecture.txt           # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab)
- Conocimientos de VPC y networking
- Experiencia con AWS CLI
- Comprensión de security groups y NACLs

### Pasos Principales

1. **Crear VPC Flow Logs**
   ```bash
   # Crear S3 bucket
   aws s3api create-bucket --bucket flowlog######
   
   # Crear flow logs
   aws ec2 create-flow-logs --resource-type VPC
   ```

2. **Troubleshoot Challenge #1: Web Access**
   - Verificar security groups
   - Verificar route tables
   - Verificar internet gateway

3. **Troubleshoot Challenge #2: SSH Access**
   - Analizar network ACLs
   - Eliminar reglas bloqueantes

4. **Analizar Flow Logs**
   ```bash
   # Descargar logs
   aws s3 cp s3://flowlog######/ . --recursive
   
   # Analizar con grep
   grep -rn REJECT . | grep 22
   ```

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones detalladas
- **[Referencia de Comandos](./docs/commands-reference.md)**: AWS CLI troubleshooting
- **[Resultados](./docs/results.md)**: Resultados y análisis

## 🔑 Conceptos Clave Aprendidos

- **VPC Flow Logs**: Captura de tráfico de red
- **Security Groups**: Troubleshooting de firewalls stateful
- **Network ACLs**: Troubleshooting de firewalls stateless
- **Route Tables**: Diagnóstico de enrutamiento
- **AWS CLI**: Comandos de troubleshooting
- **Log Analysis**: Análisis con grep y herramientas Linux
- **Network Troubleshooting**: Metodología sistemática

## 🛠️ Tecnologías Utilizadas

- **Amazon VPC**: Networking virtual
- **VPC Flow Logs**: Captura de tráfico
- **Amazon S3**: Almacenamiento de logs
- **AWS CLI**: Troubleshooting programático
- **Linux Tools**: nmap, grep, gunzip
- **Amazon EC2**: Instancias de prueba

## 📊 Resultados

- ✅ VPC Flow Logs creados y configurados
- ✅ Problemas de security group resueltos
- ✅ Problemas de route table resueltos
- ✅ Problemas de network ACL resueltos
- ✅ Acceso web restaurado
- ✅ Acceso SSH restaurado
- ✅ Flow logs analizados exitosamente

## 🔧 Comandos Clave de Troubleshooting

### Diagnóstico de Instancias
```bash
# Describir instancia
aws ec2 describe-instances --filter "Name=ip-address,Values='<IP>'"

# Verificar puertos abiertos
nmap <WebServerIP>
```

### Análisis de Security Groups
```bash
# Describir security groups
aws ec2 describe-security-groups --group-ids <sg-id>
```

### Análisis de Route Tables
```bash
# Describir route tables
aws ec2 describe-route-tables \
  --filter "Name=association.subnet-id,Values='<subnet-id>'"

# Crear ruta
aws ec2 create-route \
  --route-table-id <rtb-id> \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id <igw-id>
```

### Análisis de Network ACLs
```bash
# Describir NACLs
aws ec2 describe-network-acls \
  --filter "Name=association.subnet-id,Values='<subnet-id>'"

# Eliminar regla NACL
aws ec2 delete-network-acl-entry \
  --network-acl-id <acl-id> \
  --rule-number <number> \
  --egress/--ingress
```

### Análisis de Flow Logs
```bash
# Buscar conexiones rechazadas
grep -rn REJECT .

# Buscar por puerto
grep -rn 22 . | grep REJECT

# Buscar por IP
grep -rn 22 . | grep REJECT | grep <ip-address>
```

## 🎓 Recursos Adicionales

- [Flow Log Records](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html)
- [AWS CLI: create-route](https://docs.aws.amazon.com/cli/latest/reference/ec2/create-route.html)
- [AWS CLI: delete-network-acl-entry](https://docs.aws.amazon.com/cli/latest/reference/ec2/delete-network-acl-entry.html)
- [AWS CLI: describe-security-groups](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-security-groups.html)
- [Querying VPC Flow Logs](https://docs.aws.amazon.com/athena/latest/ug/vpc-flow-logs.html)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
