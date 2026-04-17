# MVC Productos - Post Contenido 2

## Descripción del Proyecto

Aplicación Java Web desarrollada con **JSP y Servlets** bajo el patrón **MVC (Model-View-Controller)** que implementa un **Sistema de Gestión de Inventario de Productos** con las siguientes características avanzadas:

- **Autenticación de Usuarios** con HttpSession
- **Validaciones Robustas** en el servidor con retroalimentación de errores
- **Internacionalización (i18n)** con soporte para español e inglés
- **CRUD Completo** (Create, Read, Update, Delete) de productos
- **Interfaz Responsiva** y moderna

## Estructura del Proyecto

```
mvc-productos/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/universidad/mvc/
│   │   │       ├── model/
│   │   │       │   ├── Usuario.java
│   │   │       │   └── Producto.java
│   │   │       ├── servlet/
│   │   │       │   ├── LoginServlet.java
│   │   │       │   ├── ProductoServlet.java
│   │   │       │   └── IdiomaServlet.java
│   │   │       └── service/
│   │   │           └── ProductoService.java
│   │   ├── webapp/
│   │   │   ├── index.jsp
│   │   │   └── WEB-INF/
│   │   │       ├── web.xml
│   │   │       └── views/
│   │   │           ├── login.jsp
│   │   │           ├── lista.jsp
│   │   │           └── formulario.jsp
│   │   └── resources/
│   │       ├── messages.properties (inglés)
│   │       └── messages_es.properties (español)
├── pom.xml
├── README.md
└── capturas/
    └── [Capturas de pantalla]
```


## Checkpoints de Verificación

### 1. Cambio de idioma y persistencia

- [x] Al hacer clic en **Español**, los encabezados se muestran en español.
- [x] Al hacer clic en **English**, los encabezados se muestran en inglés.
- [x] El idioma persiste al navegar a otras páginas (formulario de producto).

**Evidencia - Español**

![Tabla en Español](../Img/ESPAÑOL.png)

**Evidencia - English**

![Table in English](../Img/INGLES.png)

**Evidencia - Persistencia al navegar al formulario**

![Formulario en English](../Img/FORMULARIO.png)

### 2. Validación de Nombre vacío y repoblación de datos

- [x] Al enviar el formulario con **Nombre** vacío, se muestra el mensaje de error.
- [x] Los demás campos permanecen con los valores ingresados (ejemplo: categoría, precio y stock).

**Evidencia - Nombre vacío con datos repoblados**

![Validación de Nombre vacío](../Img/NOMBRE_VACIO.png)

### 3. Acceso a productos sin sesión

- [x] Al intentar acceder a **/productos** en una pestaña incógnito, el sistema redirige a **/login**.

**Evidencia - Redirección a login sin sesión**

![Sin sesión redirige a login](../Img/SIN_CREDENCIALES.png)



## Dependencias Maven

```xml
- jakarta.servlet:jakarta.servlet-api:6.0.0
- jakarta.servlet.jsp:jakarta.servlet.jsp-api:3.1.1
- jakarta.servlet.jsp.jstl:jakarta.servlet.jsp.jstl-api:3.0.0
- org.glassfish.web:jakarta.servlet.jsp.jstl:3.0.1
- junit:junit:4.13.2 (testing)
```

## Arquitectura MVC

### Model (`com.universidad.mvc.model`)
- **Usuario.java** - Representa un usuario autenticado
- **Producto.java** - Representa un producto del inventario

### View (`src/main/webapp/WEB-INF/views`)
- **login.jsp** - Formulario de autenticación
- **lista.jsp** - Listado de productos con tabla
- **formulario.jsp** - Formulario CRUD para productos

### Controller (`com.universidad.mvc.servlet`)
- **LoginServlet** - Gestión de autenticación
- **ProductoServlet** - Gestión de CRUD de productos
- **IdiomaServlet** - Gestión de idioma/internacionalización

### Service (`com.universidad.mvc.service`)
- **ProductoService** - Lógica de negocio para productos (CRUD en memoria)

