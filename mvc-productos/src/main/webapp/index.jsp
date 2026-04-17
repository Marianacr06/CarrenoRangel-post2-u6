<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Redirigir a /login si el usuario no está autenticado
    if (session.getAttribute("usuarioActual") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
    } else {
        response.sendRedirect(request.getContextPath() + "/productos");
    }
%>
