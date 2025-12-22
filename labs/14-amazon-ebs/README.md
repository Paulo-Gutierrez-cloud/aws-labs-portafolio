# Working with Amazon EBS

![EBS](https://img.shields.io/badge/AWS-EBS-orange?style=for-the-badge&logo=amazon-aws)
![Storage](https://img.shields.io/badge/Storage-Block%20Storage-blue?style=for-the-badge)
![Snapshots](https://img.shields.io/badge/EBS-Snapshots-green?style=for-the-badge)

## 📋 Descripción del Laboratorio

Este laboratorio proporciona experiencia práctica con Amazon Elastic Block Store (EBS). Aprenderás a crear volúmenes EBS, adjuntarlos a instancias EC2, crear sistemas de archivos, tomar snapshots para backup, y restaurar volúmenes desde snapshots.

## 🎯 Objetivos

Al completar este laboratorio, se logra:

- ✅ Crear volúmenes EBS
- ✅ Adjuntar y montar volúmenes EBS a instancias EC2
- ✅ Crear sistemas de archivos ext3
- ✅ Crear snapshots de volúmenes EBS
- ✅ Restaurar volúmenes desde snapshots
- ✅ Gestionar almacenamiento persistente

## 🏗️ Arquitectura

```
┌────────────────────────────────────────────────────────────┐
│                    EC2 Instance (Lab)                      │
│  ┌──────────────────────────────────────────────────────┐  │
│  │                                                      │  │
│  │  Root Volume (8 GB)                                  │  │
│  │  /dev/nvme0n1p1                                      │  │
│  │                                                      │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  EBS Volume "My Volume" (1 GB)                       │  │
│  │  /dev/sdb → /mnt/data-store                          │  │
│  │  ext3 filesystem                                     │  │
│  └──────────────────────────────────────────────────────┘  │
│                          │                                 │
│                          │ Snapshot                        │
│                          ▼                                 │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  EBS Snapshot "My Snapshot"                          │  │
│  │  Stored in S3                                        │  │
│  └──────────────────────────────────────────────────────┘  │
│                          │                                 │
│                          │ Restore                         │
│                          ▼                                 │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Restored Volume (1 GB)                              │  │
│  │  /dev/sdc → /mnt/data-store2                         │  │
│  │  Contains restored file.txt                          │  │
│  └──────────────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────────────┘

Availability Zone: us-west-2a
```

## 📁 Estructura del Proyecto

```
14-amazon-ebs/
├── README.md                      # Este archivo
├── docs/
│   ├── step-by-step-guide.md     # Guía detallada
│   ├── commands-reference.md      # Comandos Linux
│   └── results.md                 # Resultados
└── assets/
    └── architecture.txt           # Diagrama de arquitectura
```

## 🚀 Inicio Rápido

### Prerrequisitos

- Cuenta de AWS (AWS Academy Lab)
- Instancia EC2 en ejecución
- Conocimientos básicos de Linux

### Pasos Principales

1. **Crear volumen EBS**
   - Tipo: gp2 (General Purpose SSD)
   - Tamaño: 1 GB
   - Misma AZ que la instancia

2. **Adjuntar volumen a instancia**
   - Device: /dev/sdb
   - Estado: In-use

3. **Crear y montar filesystem**
   ```bash
   sudo mkfs -t ext3 /dev/sdb
   sudo mkdir /mnt/data-store
   sudo mount /dev/sdb /mnt/data-store
   ```

4. **Crear snapshot**
   - Backup del volumen
   - Almacenado en S3

5. **Restaurar desde snapshot**
   - Crear nuevo volumen
   - Adjuntar como /dev/sdc
   - Montar en /mnt/data-store2

Para instrucciones detalladas, consulta la [Guía Paso a Paso](./docs/step-by-step-guide.md).

## 📚 Documentación

- **[Guía Paso a Paso](./docs/step-by-step-guide.md)**: Instrucciones detalladas
- **[Referencia de Comandos](./docs/commands-reference.md)**: Comandos Linux
- **[Resultados](./docs/results.md)**: Resultados y análisis

## 🔑 Conceptos Clave Aprendidos

- **Amazon EBS**: Almacenamiento de bloques persistente
- **EBS Volumes**: Volúmenes de almacenamiento
- **EBS Snapshots**: Backups incrementales
- **File Systems**: ext3, montaje y configuración
- **Availability Zones**: Ubicación de volúmenes
- **Persistent Storage**: Datos que persisten
- **Backup & Restore**: Estrategias de respaldo

## 🛠️ Tecnologías Utilizadas

- **Amazon EBS**: Servicio de almacenamiento de bloques
- **Amazon EC2**: Instancias de computación
- **Amazon S3**: Almacenamiento de snapshots
- **Linux**: Sistema operativo y comandos
- **ext3**: Sistema de archivos

## 📊 Resultados

- ✅ Volumen EBS de 1 GB creado
- ✅ Volumen adjuntado a instancia EC2
- ✅ Sistema de archivos ext3 creado
- ✅ Volumen montado en /mnt/data-store
- ✅ Snapshot creado exitosamente
- ✅ Volumen restaurado desde snapshot
- ✅ Datos recuperados correctamente

## 🔧 Comandos Clave

### Gestión de Volúmenes
```bash
# Ver almacenamiento disponible
df -h

# Crear filesystem ext3
sudo mkfs -t ext3 /dev/sdb

# Crear directorio de montaje
sudo mkdir /mnt/data-store

# Montar volumen
sudo mount /dev/sdb /mnt/data-store

# Configurar montaje automático
echo "/dev/sdb /mnt/data-store ext3 defaults,noatime 1 2" | sudo tee -a /etc/fstab

# Ver configuración de montaje
cat /etc/fstab
```

### Operaciones con Archivos
```bash
# Crear archivo de prueba
sudo sh -c "echo some text has been written > /mnt/data-store/file.txt"

# Leer archivo
cat /mnt/data-store/file.txt

# Eliminar archivo
sudo rm /mnt/data-store/file.txt

# Verificar eliminación
ls /mnt/data-store/file.txt
```

### Restauración de Snapshot
```bash
# Crear directorio para volumen restaurado
sudo mkdir /mnt/data-store2

# Montar volumen restaurado
sudo mount /dev/sdc /mnt/data-store2

# Verificar archivo restaurado
ls /mnt/data-store2/file.txt
```

## 🎓 Recursos Adicionales

- [Amazon Elastic Block Store (Amazon EBS)](https://docs.aws.amazon.com/ebs/)
- [EBS Volume Types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-volume-types.html)
- [EBS Snapshots](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html)
- [Making an Amazon EBS Volume Available for Use](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html)
- [AWS Training and Certification](https://aws.amazon.com/training/)

## 👤 Autor

Laboratorio completado como parte del portafolio de AWS

## 📝 Licencia

Este proyecto es para fines educativos y de documentación.

---

**Nota**: Este laboratorio fue realizado en un entorno AWS Academy Lab. Las credenciales y recursos son temporales y se eliminan al finalizar la sesión del laboratorio.
