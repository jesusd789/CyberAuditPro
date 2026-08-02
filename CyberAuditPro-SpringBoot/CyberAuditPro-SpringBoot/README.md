# CyberAuditPro API (Spring Boot + Hibernate)

CRUD REST completo sobre tu tabla real `usuarios` de la base de datos
`cyberaudit_db`.

## Requisitos
- JDK 17 o superior instalado
- Maven (o el que trae integrado IntelliJ)
- MySQL corriendo localmente, con la base `cyberaudit_db` ya creada
  (la de tu proyecto original)
- Postman

## Antes de arrancar: revisa la tabla roles

La columna `id_rol` de `usuarios` es una llave foránea hacia la tabla
`roles`. Antes de crear un usuario desde Postman, ejecuta en MySQL
Workbench:
```sql
SELECT * FROM roles;
```
y usa uno de esos ids reales en el campo `idRol` del JSON (en la
colección de Postman viene `1` de ejemplo — cámbialo si en tu tabla
`roles` no existe el id 1, o vas a recibir un error de la base de
datos por violar la llave foránea).

## Pasos para ejecutar

1. Abre `src/main/resources/application.properties` y confirma tu
   usuario/contraseña reales de MySQL (el nombre de base de datos ya
   está puesto como `cyberaudit_db`, que es el tuyo).
2. Abre la carpeta en IntelliJ IDEA como proyecto Maven.
3. Ejecuta `CyberAuditProApplication.java`. En consola debe salir:
   ```
   Tomcat started on port 8080 (http)
   Started CyberAuditProApplication ...
   ```
   Como la tabla `usuarios` ya existe, Hibernate no la vuelve a crear,
   solo la usa (por eso no verás un `create table` en el log esta vez).
4. Importa `postman_collection.json` en Postman (File -> Import).
5. Prueba en orden: **Crear -> Listar -> Consultar por id -> Actualizar
   -> Eliminar**. Después de cada una, verifica en MySQL Workbench:
   ```sql
   SELECT * FROM usuarios;
   ```

## Estructura del proyecto (para explicar en el video)

```
src/main/java/com/cyberaudit/api/
├── CyberAuditProApplication.java     -> arranca la app (main)
├── entity/Usuario.java               -> mapea la tabla usuarios (Hibernate/JPA)
├── repository/UsuarioRepository.java -> acceso a datos (CRUD automatico)
├── service/UsuarioService.java           -> contrato de la logica de negocio
├── service/impl/UsuarioServiceImpl.java  -> implementacion del CRUD
├── controller/UsuarioController.java     -> expone los endpoints REST (/api/usuarios)
└── exception/                            -> manejo de errores (404, etc.)
```

## Nota sobre la contraseña

El campo `contrasena` se guarda y se devuelve tal cual (sin cifrar),
igual que probablemente hacía tu proyecto original. Para efectos de
esta evidencia académica está bien así; si más adelante quieres
agregar cifrado (BCrypt), avísame y te lo agrego.
