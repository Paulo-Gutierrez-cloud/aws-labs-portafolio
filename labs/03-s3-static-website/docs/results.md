# Resultados del Laboratorio - S3 Static Website

## 📊 Resumen Ejecutivo

Este documento presenta los resultados del laboratorio de creación de un sitio web estático en Amazon S3. El laboratorio demostró exitosamente cómo desplegar y gestionar contenido web usando AWS CLI, configurar permisos IAM, y automatizar actualizaciones mediante scripts.

**Duración del laboratorio**: ~45 minutos  
**Región utilizada**: us-west-2  
**Recursos utilizados**: 1 instancia EC2, 1 bucket S3, 1 usuario IAM

---

## ✅ Objetivos Completados

| # | Objetivo | Estado |
|---|----------|--------|
| 1 | Ejecutar comandos AWS CLI para IAM y S3 | ✅ Completado |
| 2 | Crear bucket de S3 para hosting estático | ✅ Completado |
| 3 | Crear usuario IAM con acceso completo a S3 | ✅ Completado |
| 4 | Desplegar sitio web estático en S3 | ✅ Completado |
| 5 | Crear script de automatización | ✅ Completado |
| 6 | Optimizar con aws s3 sync | ✅ Completado |

---

## 📋 Tarea 3: Crear Bucket de S3

### Comando Ejecutado
```bash
aws s3api create-bucket --bucket twhitlock256 --region us-west-2 \
  --create-bucket-configuration LocationConstraint=us-west-2
```

### Resultado
```json
{
    "Location": "http://twhitlock256.s3.amazonaws.com/"
}
```

**✅ Bucket creado exitosamente**

---

## 📋 Tarea 4: Crear Usuario IAM

### Comandos Ejecutados

1. **Crear usuario**:
```bash
aws iam create-user --user-name awsS3user
```

2. **Crear login profile**:
```bash
aws iam create-login-profile --user-name awsS3user --password Training123!
```

3. **Adjuntar política**:
```bash
aws iam attach-user-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess \
  --user-name awsS3user
```

### Verificación
- ✅ Usuario creado
- ✅ Login profile configurado
- ✅ Política AmazonS3FullAccess adjuntada
- ✅ Acceso a consola verificado

---

## 📋 Tarea 5-6: Configurar Permisos del Bucket

### Configuraciones Aplicadas
- ✅ Block public access: Deshabilitado
- ✅ ACLs: Habilitadas
- ✅ Object Ownership: ACLs enabled

---

## 📋 Tarea 7: Extraer Archivos

### Archivos Extraídos
```
static-website/
├── index.html
├── css/
│   └── styles.css
└── images/
    ├── logo.png
    └── banner.jpg
```

**✅ Archivos extraídos correctamente**

---

## 📋 Tarea 8: Subir Archivos a S3

### Comandos Ejecutados

1. **Configurar website hosting**:
```bash
aws s3 website s3://twhitlock256/ --index-document index.html
```

2. **Subir archivos**:
```bash
aws s3 cp /home/ec2-user/sysops-activity-files/static-website/ \
  s3://twhitlock256/ --recursive --acl public-read
```

### Resultado
```
upload: ./index.html to s3://twhitlock256/index.html
upload: ./css/styles.css to s3://twhitlock256/css/styles.css
upload: ./images/logo.png to s3://twhitlock256/images/logo.png
upload: ./images/banner.jpg to s3://twhitlock256/images/banner.jpg
```

### URL del Sitio Web
```
http://twhitlock256.s3-website-us-west-2.amazonaws.com
```

**✅ Sitio web desplegado y accesible**

---

## 📋 Tarea 9: Script de Actualización

### Script Creado
```bash
#!/bin/bash
aws s3 cp /home/ec2-user/sysops-activity-files/static-website/ \
  s3://twhitlock256/ --recursive --acl public-read
```

### Cambios Realizados
- `bgcolor="aquamarine"` → `bgcolor="gainsboro"`
- `bgcolor="orange"` → `bgcolor="cornsilk"`

### Resultado
- ✅ Script ejecutado exitosamente
- ✅ Cambios visibles en el sitio web
- ✅ Colores actualizados correctamente

---

## 📋 Tarea 10: Optimización con S3 Sync

### Script Optimizado
```bash
#!/bin/bash
aws s3 sync /home/ec2-user/sysops-activity-files/static-website/ \
  s3://twhitlock256/ --acl public-read
```

### Comparación de Resultados

**Con `aws s3 cp --recursive`**:
```
upload: ./index.html to s3://bucket/index.html
upload: ./css/styles.css to s3://bucket/css/styles.css
upload: ./images/logo.png to s3://bucket/images/logo.png
upload: ./images/banner.jpg to s3://bucket/images/banner.jpg
```
**Total**: 4 archivos subidos

**Con `aws s3 sync`** (después de modificar solo index.html):
```
upload: index.html to s3://bucket/index.html
```
**Total**: 1 archivo subido

### Beneficios Demostrados
- ✅ 75% menos archivos transferidos
- ✅ Tiempo de actualización reducido
- ✅ Menor uso de ancho de banda
- ✅ Más eficiente para actualizaciones frecuentes

---

## 📊 Métricas del Laboratorio

### Tiempo de Ejecución
| Tarea | Tiempo Estimado | Tiempo Real |
|-------|-----------------|-------------|
| Tarea 1-2: Conexión y configuración | 5 min | 4 min |
| Tarea 3: Crear bucket | 3 min | 2 min |
| Tarea 4: Crear usuario IAM | 7 min | 6 min |
| Tarea 5-6: Configurar permisos | 5 min | 4 min |
| Tarea 7: Extraer archivos | 3 min | 2 min |
| Tarea 8: Subir archivos | 7 min | 5 min |
| Tarea 9: Crear script | 10 min | 8 min |
| Tarea 10: Optimizar | 5 min | 4 min |
| **Total** | **45 min** | **35 min** |

### Recursos Utilizados
- 1 x EC2 Instance (t2.micro)
- 1 x S3 Bucket
- 1 x IAM User
- ~10 archivos estáticos (HTML, CSS, imágenes)

---

## 🎓 Lecciones Aprendidas

### 1. S3 Static Website Hosting
**Aprendizaje**: S3 proporciona una forma simple y económica de hospedar sitios web estáticos sin necesidad de servidores.

**Aplicación práctica**: Ideal para landing pages, documentación, portfolios, y sitios de marketing.

### 2. IAM User Management
**Aprendizaje**: Las políticas de AWS permiten control granular de permisos.

**Aplicación práctica**: Crear usuarios con permisos específicos mejora la seguridad y facilita la auditoría.

### 3. Automatización con Scripts
**Aprendizaje**: Los scripts bash simplifican tareas repetitivas y reducen errores humanos.

**Aplicación práctica**: Automatizar despliegues ahorra tiempo y asegura consistencia.

### 4. Optimización con Sync
**Aprendizaje**: `aws s3 sync` es más eficiente que `cp` para actualizaciones.

**Aplicación práctica**: En sitios con muchos archivos, sync reduce significativamente el tiempo de despliegue.

---

## 🔍 Casos de Uso

### S3 Static Website Hosting
- Sitios web corporativos
- Documentación técnica
- Portfolios personales
- Landing pages de marketing
- Sitios de eventos
- Blogs estáticos (Jekyll, Hugo)

### Automatización con AWS CLI
- CI/CD pipelines
- Despliegues automáticos
- Backups programados
- Sincronización de contenido

---

## 📈 Próximos Pasos

### Mejoras Sugeridas

1. **Agregar CloudFront**
   - Distribución global de contenido
   - HTTPS/SSL
   - Mejor performance

2. **Implementar CI/CD**
   - GitHub Actions
   - AWS CodePipeline
   - Despliegues automáticos

3. **Agregar Dominio Personalizado**
   - Route 53
   - Certificado SSL
   - URL personalizada

4. **Habilitar Versionado**
   - Protección contra eliminación accidental
   - Historial de cambios
   - Rollback fácil

---

## 💰 Costos Estimados

> **Nota**: En AWS Academy Lab no hay costos. Los siguientes son estimados para producción.

| Servicio | Costo Mensual Estimado |
|----------|------------------------|
| S3 Storage (1 GB) | $0.023 |
| S3 Requests (10,000) | $0.005 |
| Data Transfer (1 GB) | $0.09 |
| **Total** | **~$0.12/mes** |

**Conclusión**: Extremadamente económico para sitios pequeños.

---

## ✅ Conclusión

El laboratorio de S3 Static Website demostró exitosamente:

1. ✅ **Creación de infraestructura** con AWS CLI
2. ✅ **Gestión de permisos** con IAM
3. ✅ **Despliegue de contenido** web estático
4. ✅ **Automatización** de actualizaciones
5. ✅ **Optimización** de transferencias

**Impacto en producción**:
- Hosting web sin servidores
- Costos mínimos
- Alta disponibilidad
- Escalabilidad automática

**Habilidades adquiridas**:
- AWS CLI para S3 e IAM
- Configuración de static website hosting
- Gestión de ACLs y permisos
- Scripting bash para automatización
- Optimización con sync vs copy

---

**Laboratorio completado exitosamente** ✅  
**Fecha de finalización**: Diciembre 11, 2025  
**Duración total**: 35 minutos
