# Portal Institucional — RCE

Sitio público del Portal Educativo de Red Córdoba Educativa.

## Arquitectura
- **Web:** `web-prod` (Nginx + aplicación interna)
- **Base de datos:** `db-prod.internal:3306` (MariaDB)
- **Backups y artefactos de despliegue:** bucket S3 `rce-portal-backups`
- **Observabilidad:** CloudWatch Logs (grupo `/aws/ec2/web-prod`)

## Despliegue
El pipeline vive en `.github/workflows/deploy.yml`.
Los logs de cada ejecución quedan en `deploy/logs/`.
La versión actual en producción es la indicada por el último deploy exitoso.

## Contacto
platform-team@rce.edu.ar
