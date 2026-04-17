<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:setLocale value="${sessionScope.locale != null ? sessionScope.locale : 'es'}"/>
<fmt:setBundle basename="messages"/>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><fmt:message key="app.titulo"/></title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f5f5;
            color: #333;
        }
        
        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        header h1 {
            margin-bottom: 10px;
            font-size: 32px;
        }
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .user-info {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .lang-selector {
            display: flex;
            gap: 10px;
        }
        
        .lang-selector a {
            color: white;
            text-decoration: none;
            padding: 8px 12px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 5px;
            transition: background 0.3s;
        }
        
        .lang-selector a:hover {
            background: rgba(255, 255, 255, 0.4);
        }
        
        .logout-btn {
            background: rgba(255, 0, 0, 0.8);
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s;
        }
        
        .logout-btn:hover {
            background: rgba(255, 0, 0, 1);
        }
        
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .actions {
            margin-bottom: 20px;
        }
        
        .btn-new {
            background: #667eea;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
            transition: background 0.3s;
        }
        
        .btn-new:hover {
            background: #764ba2;
        }
        
        .message {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        
        thead {
            background: #667eea;
            color: white;
        }
        
        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }
        
        td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        
        tbody tr:hover {
            background: #f8f9ff;
        }
        
        .btn-editar, .btn-eliminar {
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 13px;
            text-decoration: none;
            display: inline-block;
            margin-right: 5px;
        }
        
        .btn-editar {
            background: #ffc107;
            color: white;
        }
        
        .btn-editar:hover {
            background: #e0a800;
        }
        
        .btn-eliminar {
            background: #dc3545;
            color: white;
        }
        
        .btn-eliminar:hover {
            background: #c82333;
        }
        
        .empty-message {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
    <header>
        <div class="header-content">
            <div>
                <h1><fmt:message key="app.titulo"/></h1>
                <p><fmt:message key="app.bienvenida"/>, <strong>${sessionScope.usuarioActual.username}</strong></p>
            </div>
            <div class="user-info">
                <div class="lang-selector">
                    <a href="<c:url value="/idioma?lang=es"/>">🇪🇸 Español</a>
                    <a href="<c:url value="/idioma?lang=en"/>">🇬🇧 English</a>
                </div>
                <a href="<c:url value="/login?accion=logout"/>" class="logout-btn"><fmt:message key="logout"/></a>
            </div>
        </div>
    </header>
    
    <div class="container">
        <c:if test="${not empty param.mensaje}">
            <div class="message">
                ${param.mensaje}
            </div>
        </c:if>
        
        <div class="actions">
            <a href="<c:url value="/productos?accion=nuevo"/>" class="btn-new">
                <fmt:message key="menu.nuevo"/>
            </a>
        </div>
        
        <c:if test="${empty productos}">
            <div class="empty-message">
                <p>No hay productos registrados</p>
            </div>
        </c:if>
        
        <c:if test="${not empty productos}">
            <table>
                <thead>
                    <tr>
                        <th><fmt:message key="tabla.nombre"/></th>
                        <th><fmt:message key="tabla.categoria"/></th>
                        <th><fmt:message key="tabla.precio"/></th>
                        <th><fmt:message key="tabla.stock"/></th>
                        <th><fmt:message key="tabla.acciones"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="producto" items="${productos}">
                        <tr>
                            <td>${producto.nombre}</td>
                            <td>${producto.categoria}</td>
                            <td>$<fmt:formatNumber value="${producto.precio}" type="number" minFractionDigits="2" maxFractionDigits="2"/></td>
                            <td>${producto.stock}</td>
                            <td>
                                <a href="<c:url value="/productos?accion=editar&id=${producto.id}"/>" class="btn-editar">
                                    <fmt:message key="btn.editar"/>
                                </a>
                                <a href="<c:url value="/productos?accion=eliminar&id=${producto.id}"/>" class="btn-eliminar" onclick="return confirm('¿Está seguro?')">
                                    <fmt:message key="btn.eliminar"/>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</body>
</html>
