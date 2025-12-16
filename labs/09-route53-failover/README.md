# Amazon Route 53 Failover Routing

![Route 53](https://img.shields.io/badge/AWS-Route%2053-orange?style=for-the-badge&logo=amazon-aws)
![High Availability](https://img.shields.io/badge/HA-High%20Availability-green?style=for-the-badge)
![DNS](https://img.shields.io/badge/DNS-Failover-blue?style=for-the-badge)

## 📋 Descripción del Laboratorio

Este laboratorio proporciona experiencia práctica en la configuración de failover routing para una aplicación web usando Amazon Route 53. Aprenderás a implementar alta disponibilidad mediante health checks, configurar registros DNS de failover, y verificar el funcionamiento automático del failover entre Availability Zones.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Configurar Route 53 health checks con notificaciones por email
- ✅ Implementar failover routing en Route 53
- ✅ Crear registros A primarios y secundarios
- ✅ Configurar SNS para alertas de health check
- ✅ Verificar failover automático entre AZs
- ✅ Implementar alta disponibilidad para aplicaciones web

## 🏗️ Arquitectura

### Arquitectura Final
```
┌──────────────────────────────────────────────────────────────────┐
│                    Amazon Route 53                               │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  Hosted Zone: XXXXXX.vocareum.training                    │  │
│  │  ┌──────────────────┐      ┌──────────────────┐          │  │
│  │  │  A Record        │      │  A Record        │          │  │
│  │  │  (Primary)       │      │  (Secondary)     │          │  │
│  │  │  Failover        │      │  Failover        │          │  │
│  │  └──────────────────┘      └──────────────────┘          │  │
│  │          │                          │                     │  │
│  │  Health Check ───> SNS ───> Email Alert                  │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘
                │                          │
                ▼                          ▼
┌──────────────────────────┐  ┌──────────────────────────┐
│   Availability Zone 1    │  │   Availability Zone 2    │
│  ┌────────────────────┐  │  │  ┌────────────────────┐  │
│  │  Café Instance 1   │  │  │  │  Café Instance 2   │  │
│  │  (Primary)         │  │  │  │  (Secondary)       │  │
│  │  Public Subnet 1   │  │  │  │  Public Subnet 2   │  │
│  │  us-west-2a        │  │  │  │  us-west-2b        │  │
│  └────────────────────┘  │  │  └────────────────────┘  │
└──────────────────────────┘  └──────────────────────────┘

User Request ──> Route 53 ──> Primary (if healthy)
                          └──> Secondary (if primary fails)
```

## 📁 Estructura del Proyecto

```
09-route53-failover/
├── README.md                      # Este archivo
├── docs/
│   ├── step-by-step-guide.md     # Guía detallada
│   ├── commands-reference.md      # Configuraciones de Route 53
│   └── results.md                 # Resultados
└── assets/
    └── architecture.txt           # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab)
- 2 instancias EC2 en diferentes AZs
- Aplicación web desplegada en ambas instancias
- Dominio en Route 53

### Pasos Principales

1. **Confirmar sitios web del café**
   - Verificar CafeInstance1 (Primary)
   - Verificar CafeInstance2 (Secondary)

2. **Configurar Route 53 Health Check**
   - Crear health check para sitio primario
   - Configurar intervalo rápido (10 segundos)
   - Configurar SNS para notificaciones

3. **Crear Registros Route 53**
   - Registro A primario con health check
   - Registro A secundario sin health check
   - TTL de 15 segundos

4. **Verificar Failover**
   - Detener instancia primaria
   - Confirmar cambio automático a secundaria
   - Verificar notificación por email

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones detalladas
- **[Referencia de Comandos](./docs/commands-reference.md)**: Configuraciones DNS
- **[Resultados](./docs/results.md)**: Resultados y análisis

## 🔑 Conceptos Clave Aprendidos

- **Failover Routing**: Enrutamiento automático a recursos de respaldo
- **Health Checks**: Monitoreo de disponibilidad de endpoints
- **DNS Records**: Registros A con políticas de failover
- **SNS Notifications**: Alertas automáticas por email
- **High Availability**: Distribución multi-AZ
- **TTL Configuration**: Time-to-live para DNS
- **Primary/Secondary**: Arquitectura activo-pasivo

## 🛠️ Tecnologías Utilizadas

- **Amazon Route 53**: Servicio DNS
- **Amazon SNS**: Notificaciones
- **Amazon EC2**: Instancias de aplicación
- **Multi-AZ**: Alta disponibilidad
- **Health Checks**: Monitoreo de salud

## 📊 Resultados

- ✅ Health check configurado y funcionando
- ✅ Registros DNS de failover creados
- ✅ SNS configurado con email confirmado
- ✅ Failover automático verificado
- ✅ Notificaciones de alarma recibidas
- ✅ Alta disponibilidad implementada

## 🔧 Configuración de Route 53

### Health Check
- **Endpoint**: IP de CafeInstance1
- **Protocol**: HTTP
- **Path**: /cafe
- **Interval**: 10 segundos (Fast)
- **Failure Threshold**: 2

### Registros DNS
```
www.XXXXXX.vocareum.training
├── A Record (Primary)
│   ├── Value: IP de CafeInstance1
│   ├── TTL: 15 segundos
│   ├── Routing: Failover
│   ├── Type: Primary
│   └── Health Check: Primary-Website-Health
│
└── A Record (Secondary)
    ├── Value: IP de CafeInstance2
    ├── TTL: 15 segundos
    ├── Routing: Failover
    ├── Type: Secondary
    └── Health Check: None
```

## 🎓 Recursos Adicionales

- [Amazon Route 53 Health Checks](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover.html)
- [Amazon Route 53 Failover Routing](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-policy.html#routing-policy-failover)
- [Configuring DNS Failover](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-failover-configuring.html)
- [Route 53 Health Check Types](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/health-checks-types.html)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
