# Troubleshooting EC2 Instance Creation

![Amazon EC2](https://img.shields.io/badge/Amazon-EC2-orange?style=for-the-badge&logo=amazon-ec2)
![AWS CLI](https://img.shields.io/badge/AWS-CLI-orange?style=for-the-badge&logo=amazon-aws)
![Troubleshooting](https://img.shields.io/badge/Skill-Troubleshooting-red?style=for-the-badge)

## 📋 Descripción del Laboratorio

Este laboratorio práctico se enfoca en troubleshooting y resolución de problemas al crear instancias EC2 usando AWS CLI. Aprenderás a identificar y resolver errores comunes, usar herramientas de diagnóstico como nmap, y desplegar una aplicación LAMP stack (Linux, Apache, MariaDB, PHP) completa.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Lanzar instancias EC2 usando AWS CLI
- ✅ Identificar y resolver errores en scripts de AWS CLI
- ✅ Troubleshoot configuraciones de security groups
- ✅ Usar herramientas de diagnóstico (nmap) para verificar conectividad
- ✅ Desplegar y verificar un LAMP stack completo
- ✅ Implementar la aplicación web Café con base de datos

## 🏗️ Arquitectura

![Architecture Diagram](./assets/architecture-diagram.txt)

La arquitectura implementada incluye:

- **CLI Host**: Instancia para ejecutar comandos AWS CLI
- **LAMP Instance**: Servidor con Linux, Apache, MariaDB, PHP
- **Café Web Application**: Aplicación web con backend de base de datos
- **Security Groups**: Configuración de puertos 22 (SSH) y 80 (HTTP)
- **User Data Script**: Automatización de instalación y configuración

## 📁 Estructura del Proyecto

```
05-ec2-troubleshooting/
├── README.md                          # Este archivo
├── docs/
│   ├── step-by-step-guide.md         # Guía detallada con troubleshooting
│   ├── commands-reference.md          # Comandos y herramientas de diagnóstico
│   └── results.md                     # Resultados y soluciones
├── scripts/
│   ├── create-lamp-instance.sh       # Script de creación (con issues)
│   ├── create-lamp-instance-fixed.sh # Script corregido
│   └── create-lamp-userdata.txt      # Script de configuración LAMP
└── assets/
    └── architecture-diagram.png       # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab o cuenta personal)
- CLI Host instance configurada
- VPC con nombre "Cafe VPC"

### Problemas Comunes y Soluciones

#### Issue #1: InvalidAMIID.NotFound
**Error**: "The image id '[ami-xxxxxxxxxx]' does not exist"

**Causa**: AMI ID no válido para la región

**Solución**: Verificar que el AMI ID corresponda a la región correcta

#### Issue #2: Web Server No Accesible
**Error**: No se puede cargar la página web

**Causa**: Puerto 80 no abierto en security group o servicio httpd no iniciado

**Solución**: 
- Verificar security group permite puerto 80
- Confirmar que httpd está corriendo: `sudo systemctl status httpd`

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones con troubleshooting
- **[Referencia de Comandos](./docs/commands-reference.md)**: Comandos de diagnóstico
- **[Resultados](./docs/results.md)**: Soluciones y lecciones aprendidas

## 🔑 Conceptos Clave Aprendidos

- **Troubleshooting Sistemático**: Metodología para identificar y resolver problemas
- **AWS CLI Debugging**: Interpretación de mensajes de error
- **Security Groups**: Configuración correcta de reglas de firewall
- **Port Scanning**: Uso de nmap para verificar puertos abiertos
- **LAMP Stack**: Despliegue completo de aplicación web con base de datos
- **User Data Scripts**: Automatización y verificación de ejecución
- **Log Analysis**: Revisión de logs para troubleshooting

## 🛠️ Tecnologías Utilizadas

- **Amazon EC2**: Servicio de computación
- **AWS CLI**: Automatización y scripting
- **LAMP Stack**: Linux + Apache + MariaDB + PHP
- **nmap**: Herramienta de escaneo de puertos
- **cloud-init**: Servicio de user data
- **Bash Scripting**: Automatización de tareas

## 📊 Resultados

- ✅ Script de creación troubleshooted y corregido
- ✅ LAMP instance desplegada exitosamente
- ✅ Aplicación web Café funcionando
- ✅ Base de datos MariaDB configurada
- ✅ Sistema de órdenes operativo

## 🔧 Herramientas de Troubleshooting

### nmap - Network Port Scanner
```bash
# Instalar nmap
sudo yum install -y nmap

# Escanear puertos
nmap -Pn <public-ip>
```

### Verificar Servicios
```bash
# Estado de Apache
sudo systemctl status httpd

# Logs de user data
sudo tail -f /var/log/cloud-init-output.log
```

## 🎓 Recursos Adicionales

- [Launching, Listing, and Terminating Amazon EC2 Instances](https://docs.aws.amazon.com/cli/latest/reference/ec2/)
- [EC2 Instance Connect](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Connect-using-EC2-Instance-Connect.html)
- [User Data and Shell Scripts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)
- [Troubleshooting EC2 Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-troubleshoot.html)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
