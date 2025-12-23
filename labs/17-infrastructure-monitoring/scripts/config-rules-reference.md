# AWS Config Rules Reference

## Reglas Utilizadas en el Laboratorio

### 1. required-tags

**Descripción**: Verifica que los recursos tengan las etiquetas requeridas.

**Parámetros**:
- `tag1Key`: project (nombre de la etiqueta requerida)

**Recursos en Scope**:
- Todos los recursos que soportan etiquetas

**Compliance**:
- ✅ **Compliant**: Recursos con la etiqueta "project"
- ❌ **Non-compliant**: Recursos sin la etiqueta "project"

**Remediation**:
- Manual: Agregar etiqueta "project" a recursos
- Automática: Lambda function para auto-tagging

### 2. ec2-volume-inuse-check

**Descripción**: Verifica que los volúmenes EBS estén adjuntos a instancias EC2.

**Parámetros**: Ninguno

**Recursos en Scope**:
- Volúmenes EBS

**Compliance**:
- ✅ **Compliant**: Volúmenes attached a instancias
- ❌ **Non-compliant**: Volúmenes unattached

**Remediation**:
- Manual: Adjuntar o eliminar volúmenes no utilizados
- Automática: Lambda para crear snapshots y eliminar

## Reglas Adicionales Recomendadas

### 3. encrypted-volumes

**Descripción**: Verifica que los volúmenes EBS estén cifrados.

```json
{
  "ConfigRuleName": "encrypted-volumes",
  "Description": "Checks whether EBS volumes are encrypted",
  "Source": {
    "Owner": "AWS",
    "SourceIdentifier": "ENCRYPTED_VOLUMES"
  },
  "Scope": {
    "ComplianceResourceTypes": [
      "AWS::EC2::Volume"
    ]
  }
}
```

### 4. ec2-instance-managed-by-systems-manager

**Descripción**: Verifica que las instancias EC2 estén gestionadas por Systems Manager.

```json
{
  "ConfigRuleName": "ec2-managed-by-ssm",
  "Description": "Checks whether EC2 instances are managed by Systems Manager",
  "Source": {
    "Owner": "AWS",
    "SourceIdentifier": "EC2_INSTANCE_MANAGED_BY_SSM"
  }
}
```

### 5. cloudwatch-alarm-action-check

**Descripción**: Verifica que las alarmas de CloudWatch tengan acciones configuradas.

```json
{
  "ConfigRuleName": "cloudwatch-alarm-action-check",
  "Description": "Checks whether CloudWatch alarms have actions configured",
  "Source": {
    "Owner": "AWS",
    "SourceIdentifier": "CLOUDWATCH_ALARM_ACTION_CHECK"
  },
  "InputParameters": {
    "alarmActionRequired": "true",
    "insufficientDataActionRequired": "false",
    "okActionRequired": "false"
  }
}
```

### 6. s3-bucket-logging-enabled

**Descripción**: Verifica que los buckets S3 tengan logging habilitado.

```json
{
  "ConfigRuleName": "s3-bucket-logging-enabled",
  "Description": "Checks whether logging is enabled for S3 buckets",
  "Source": {
    "Owner": "AWS",
    "SourceIdentifier": "S3_BUCKET_LOGGING_ENABLED"
  }
}
```

### 7. iam-password-policy

**Descripción**: Verifica que la política de contraseñas IAM cumpla requisitos.

```json
{
  "ConfigRuleName": "iam-password-policy",
  "Description": "Checks whether IAM password policy meets requirements",
  "Source": {
    "Owner": "AWS",
    "SourceIdentifier": "IAM_PASSWORD_POLICY"
  },
  "InputParameters": {
    "RequireUppercaseCharacters": "true",
    "RequireLowercaseCharacters": "true",
    "RequireNumbers": "true",
    "MinimumPasswordLength": "14",
    "MaxPasswordAge": "90"
  }
}
```

## Creación de Reglas Personalizadas

### Ejemplo: Lambda Function para Regla Custom

```python
import json
import boto3

def evaluate_compliance(configuration_item, rule_parameters):
    """
    Evalúa compliance de un recurso
    """
    # Lógica de evaluación
    if configuration_item['resourceType'] == 'AWS::EC2::Instance':
        tags = configuration_item.get('tags', {})
        
        # Verificar tag "Environment"
        if 'Environment' in tags:
            return 'COMPLIANT'
        else:
            return 'NON_COMPLIANT'
    
    return 'NOT_APPLICABLE'

def lambda_handler(event, context):
    config = boto3.client('config')
    
    # Obtener información del recurso
    configuration_item = json.loads(event['configurationItem'])
    rule_parameters = json.loads(event['ruleParameters'])
    
    # Evaluar compliance
    compliance_status = evaluate_compliance(
        configuration_item,
        rule_parameters
    )
    
    # Reportar resultado
    config.put_evaluations(
        Evaluations=[
            {
                'ComplianceResourceType': configuration_item['resourceType'],
                'ComplianceResourceId': configuration_item['resourceId'],
                'ComplianceType': compliance_status,
                'OrderingTimestamp': configuration_item['configurationItemCaptureTime']
            }
        ],
        ResultToken=event['resultToken']
    )
```

## Remediation Actions

### Ejemplo: Auto-remediation con Systems Manager

```json
{
  "schemaVersion": "0.3",
  "description": "Attach required tag to EC2 instance",
  "parameters": {
    "InstanceId": {
      "type": "String"
    },
    "TagKey": {
      "type": "String",
      "default": "project"
    },
    "TagValue": {
      "type": "String",
      "default": "default-project"
    }
  },
  "mainSteps": [
    {
      "name": "attachTag",
      "action": "aws:createTags",
      "inputs": {
        "ResourceType": "EC2",
        "ResourceIds": ["{{ InstanceId }}"],
        "Tags": [
          {
            "Key": "{{ TagKey }}",
            "Value": "{{ TagValue }}"
          }
        ]
      }
    }
  ]
}
```

## Best Practices

1. **Start Simple**: Comenzar con reglas managed de AWS
2. **Prioritize**: Enfocarse en compliance crítico primero
3. **Automate**: Configurar auto-remediation cuando sea posible
4. **Monitor**: Revisar compliance dashboard regularmente
5. **Document**: Documentar políticas y excepciones
6. **Test**: Probar reglas en entorno de desarrollo primero
7. **Notify**: Configurar SNS para alertas de non-compliance

## Recursos Adicionales

- [AWS Config Managed Rules](https://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html)
- [Custom Config Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_develop-rules.html)
- [Remediation Actions](https://docs.aws.amazon.com/config/latest/developerguide/remediation.html)
