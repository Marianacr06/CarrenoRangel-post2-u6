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
    <title><fmt:message key="formulario.titulo"/></title>
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
            font-size: 28px;
        }
        
        .container {
            max-width: 600px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .form-card {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        form h2 {
            margin-bottom: 20px;
            color: #667eea;
        }
        
        .alert-error {
            background: #fee;
            border: 1px solid #fcc;
            color: #c33;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .alert-error ul {
            margin-left: 20px;
        }
        
        .alert-error li {
            margin-bottom: 5px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s;
        }
        
        input.input-error,
        select.input-error {
            border-color: #dc3545;
            background: #fff8f8;
        }
        
        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
        }
        
        .campo-error {
            color: #dc3545;
            font-size: 13px;
            margin-top: 5px;
            display: block;
        }
        
        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        
        .btn {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
        }
        
        .btn-guardar {
            background: #667eea;
            color: white;
        }
        
        .btn-guardar:hover {
            background: #764ba2;
            transform: translateY(-2px);
        }
        
        .btn-cancelar {
            background: #ccc;
            color: #333;
        }
        
        .btn-cancelar:hover {
            background: #bbb;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <header>
        <h1><fmt:message key="formulario.titulo"/></h1>
    </header>
    
    <div class="container">
        <div class="form-card">
            <c:if test="${not empty errores}">
                <div class="alert-error">
                    <ul>
                        <c:forEach var="e" items="${errores}">
                            <li>${e.value}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            
            <form method="POST" action="${pageContext.request.contextPath}/productos">
                <input type="hidden" name="accion" value="guardar">
                <c:if test="${not empty producto.id}">
                    <input type="hidden" name="id" value="${producto.id}">
                </c:if>
                <c:if test="${not empty id}">
                    <input type="hidden" name="id" value="${id}">
                </c:if>
                
                <div class="form-group">
                    <label for="nombre"><fmt:message key="formulario.nombre"/></label>
                    <input type="text" id="nombre" name="nombre" 
                           value="${not empty nombre ? nombre : (not empty producto.nombre ? producto.nombre : '')}"
                           class="${not empty errores.nombre ? 'input-error' : ''}" required>
                    <c:if test="${not empty errores.nombre}">
                        <span class="campo-error">${errores.nombre}</span>
                    </c:if>
                </div>
                
                <div class="form-group">
                    <label for="categoria"><fmt:message key="formulario.categoria"/></label>
                    <select id="categoria" name="categoria">
                        <option value="">Seleccionar categoría</option>
                        <option value="Informática" ${(not empty categoria and categoria == 'Informática') or (not empty producto and producto.categoria == 'Informática') ? 'selected' : ''}>Informática</option>
                        <option value="Accesorios" ${(not empty categoria and categoria == 'Accesorios') or (not empty producto and producto.categoria == 'Accesorios') ? 'selected' : ''}>Accesorios</option>
                        <option value="Periféricos" ${(not empty categoria and categoria == 'Periféricos') or (not empty producto and producto.categoria == 'Periféricos') ? 'selected' : ''}>Periféricos</option>
                        <option value="Otros" ${(not empty categoria and categoria == 'Otros') or (not empty producto and producto.categoria == 'Otros') ? 'selected' : ''}>Otros</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="precio"><fmt:message key="formulario.precio"/></label>
                    <input type="number" id="precio" name="precio" step="0.01" min="0"
                           value="${not empty precio ? precio : (not empty producto.precio ? producto.precio : '')}"
                           class="${not empty errores.precio ? 'input-error' : ''}" required>
                    <c:if test="${not empty errores.precio}">
                        <span class="campo-error">${errores.precio}</span>
                    </c:if>
                </div>
                
                <div class="form-group">
                    <label for="stock"><fmt:message key="formulario.stock"/></label>
                    <input type="number" id="stock" name="stock" min="0"
                           value="${not empty stock ? stock : (not empty producto.stock ? producto.stock : '')}"
                           class="${not empty errores.stock ? 'input-error' : ''}" required>
                    <c:if test="${not empty errores.stock}">
                        <span class="campo-error">${errores.stock}</span>
                    </c:if>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-guardar"><fmt:message key="btn.guardar"/></button>
                    <a href="${pageContext.request.contextPath}/productos" class="btn btn-cancelar" style="text-align: center; text-decoration: none; display: flex; align-items: center; justify-content: center;"><fmt:message key="btn.cancelar"/></a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
