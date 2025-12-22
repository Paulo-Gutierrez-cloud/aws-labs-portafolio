# Configuring a VPC

![VPC](https://img.shields.io/badge/AWS-VPC-orange?style=for-the-badge&logo=amazon-aws)
![Networking](https://img.shields.io/badge/Networking-Configuration-blue?style=for-the-badge)
![NAT Gateway](https://img.shields.io/badge/NAT-Gateway-green?style=for-the-badge)

## 📋 Descripción del Laboratorio

Este laboratorio proporciona experiencia práctica en la construcción de una VPC completa desde cero. Aprenderás a crear subnets públicas y privadas, configurar internet gateways, NAT gateways, route tables, y desplegar instancias EC2 en diferentes subnets incluyendo un bastion server.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Crear VPC con subnets públicas y privadas
- ✅ Configurar Internet Gateway para conectividad pública
- ✅ Implementar NAT Gateway para acceso privado a internet
- ✅ Configurar route tables para tráfico local e internet
- ✅ Lanzar bastion server en subnet pública
- ✅ Conectar a instancias privadas vía bastion server

## 🏗️ Arquitectura

```
┌────────────────────────────────────────────────────────────┐
│                    Lab VPC (10.0.0.0/16)                   │
│                                                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Public Subnet (10.0.0.0/24)             │  │
│  │  ┌────────────────┐      ┌────────────────────────┐  │  │
│  │  │ Bastion Server │      │   NAT Gateway          │  │  │
│  │  │ (Public IP)    │      │   (Elastic IP)         │  │  │
│  │  └────────────────┘      └────────────────────────┘  │  │
│  │                                  │                   │  │
│  │  Route Table: Public Route Table │                   │  │
│  │  - 10.0.0.0/16 → local          │                   │  │
│  │  - 0.0.0.0/0 → Internet Gateway │                   │  │
│  └──────────────────────────────────────────────────────┘  │
│                          │                                 │
│                  Internet Gateway                          │
│                          │                                 │
│  ┌──────────────────────────────────────────────────────┐  │
│  │            Private Subnet (10.0.2.0/23)              │  │
│  │  ┌────────────────────────────────────────────────┐  │  │
│  │  │   Private Instance (Optional)                  │  │  │
│  │  │   (No Public IP)                               │  │  │
│  │  └────────────────────────────────────────────────┘  │  │
│  │                                                      │  │
│  │  Route Table: Private Route Table                   │  │
│  │  - 10.0.0.0/16 → local                              │  │
│  │  - 0.0.0.0/0 → NAT Gateway                          │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                            │
│  Availability Zone: us-west-2a                            │
└────────────────────────────────────────────────────────────┘
                          │
                     Internet
```

## 📁 Estructura del Proyecto

```
12-vpc-configuration/
├── README.md                      # Este archivo
├── docs/
│   ├── step-by-step-guide.md     # Guía detallada
│   ├── commands-reference.md      # Configuraciones
│   └── results.md                 # Resultados
└── assets/
    └── architecture.txt           # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab)
- Conocimientos básicos de networking
- Comprensión de CIDR blocks

### Pasos Principales

1. **Crear VPC**
   - CIDR: 10.0.0.0/16
   - Habilitar DNS hostnames

2. **Crear Subnets**
   - Public Subnet: 10.0.0.0/24
   - Private Subnet: 10.0.2.0/23

3. **Configurar Internet Gateway**
   - Crear y adjuntar a VPC

4. **Configurar Route Tables**
   - Public: ruta a Internet Gateway
   - Private: ruta a NAT Gateway

5. **Lanzar Bastion Server**
   - En public subnet
   - Con IP pública

6. **Crear NAT Gateway**
   - En public subnet
   - Con Elastic IP

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones detalladas
- **[Referencia de Comandos](./docs/commands-reference.md)**: Configuraciones VPC
- **[Resultados](./docs/results.md)**: Resultados y análisis

## 🔑 Conceptos Clave Aprendidos

- **VPC (Virtual Private Cloud)**: Red virtual aislada
- **Subnets**: Segmentación de red
- **Internet Gateway**: Conectividad pública
- **NAT Gateway**: Internet para recursos privados
- **Route Tables**: Enrutamiento de tráfico
- **Bastion Server**: Acceso seguro a recursos privados
- **CIDR Blocks**: Rangos de direcciones IP
- **Security Groups**: Firewalls a nivel de instancia

## 🛠️ Tecnologías Utilizadas

- **Amazon VPC**: Networking virtual
- **Internet Gateway**: Conectividad internet
- **NAT Gateway**: Network Address Translation
- **Amazon EC2**: Instancias de computación
- **Route Tables**: Enrutamiento
- **Security Groups**: Seguridad de red

## 📊 Resultados

- ✅ VPC creada con CIDR 10.0.0.0/16
- ✅ Public subnet configurada
- ✅ Private subnet configurada
- ✅ Internet Gateway adjunto
- ✅ NAT Gateway desplegado
- ✅ Route tables configuradas
- ✅ Bastion server funcionando
- ✅ Conectividad verificada

## 🔧 Configuración de Red

### VPC
- **CIDR Block**: 10.0.0.0/16
- **DNS Hostnames**: Habilitado
- **DNS Resolution**: Habilitado

### Subnets
| Subnet | CIDR | Tipo | Auto-assign IP |
|--------|------|------|----------------|
| Public Subnet | 10.0.0.0/24 | Pública | Sí |
| Private Subnet | 10.0.2.0/23 | Privada | No |

### Route Tables
**Public Route Table**:
- 10.0.0.0/16 → local
- 0.0.0.0/0 → Internet Gateway

**Private Route Table**:
- 10.0.0.0/16 → local
- 0.0.0.0/0 → NAT Gateway

## 🎓 Recursos Adicionales

- [What Is Amazon VPC?](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
- [VPC CIDR Blocks](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)
- [NAT Gateways](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html)
- [Internet Gateways](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
