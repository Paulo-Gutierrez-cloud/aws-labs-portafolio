# Guía de Contribución de Labs

## Estructura Estándar de un Lab

Cada lab debe seguir esta estructura:

```
labs/XX-lab-name/
├── README.md                      # Descripción general
├── docs/
│   ├── step-by-step-guide.md     # Guía detallada
│   ├── commands-reference.md      # Referencia de comandos
│   └── results.md                 # Resultados y conclusiones
├── scripts/                       # Scripts de automatización
├── policies/                      # Políticas IAM (si aplica)
└── assets/                        # Diagramas e imágenes
```

## Numeración de Labs

- Usar formato: `01-`, `02-`, `03-`, etc.
- Mantener orden cronológico de completación

## Contenido Requerido

### README.md del Lab
- Badges de servicios AWS utilizados
- Descripción clara del laboratorio
- Objetivos de aprendizaje
- Diagrama de arquitectura
- Guía de inicio rápido
- Enlaces a documentación detallada

### Documentación
- **step-by-step-guide.md**: Instrucciones paso a paso
- **commands-reference.md**: Todos los comandos utilizados
- **results.md**: Resultados, aprendizajes y conclusiones

### Assets
- Diagrama de arquitectura (SVG preferido)
- Screenshots relevantes
- Cualquier imagen necesaria

## Actualizar README Principal

Después de agregar un lab:

1. Actualizar la sección "Laboratorios Completados"
2. Incrementar contador en tabla de progreso
3. Actualizar fecha de última actualización

## Template

Usar el template en `resources/templates/lab-template.md` como punto de partida.
