package com.universidad.mvc.servlet;

import com.universidad.mvc.model.Producto;
import com.universidad.mvc.model.Usuario;
import com.universidad.mvc.service.ProductoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/productos")
public class ProductoServlet extends HttpServlet {

    private ProductoService service = new ProductoService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        if (!verificarSesion(req, resp)) return;

        String accion = req.getParameter("accion");
        
        if (accion == null || accion.isEmpty()) {
            listar(req, resp);
        } else if ("nuevo".equals(accion)) {
            formulario(req, resp);
        } else if ("editar".equals(accion)) {
            editar(req, resp);
        } else if ("eliminar".equals(accion)) {
            eliminar(req, resp);
        } else {
            listar(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        if (!verificarSesion(req, resp)) return;

        String accion = req.getParameter("accion");
        
        if ("guardar".equals(accion)) {
            guardar(req, resp);
        } else {
            listar(req, resp);
        }
    }

    private boolean verificarSesion(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        HttpSession s = req.getSession(false);
        if (s == null || s.getAttribute("usuarioActual") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    private void listar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("productos", service.obtenerTodos());
        req.getRequestDispatcher("/WEB-INF/views/lista.jsp").forward(req, resp);
    }

    private void formulario(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            Producto p = service.obtenerPorId(Integer.parseInt(id));
            req.setAttribute("producto", p);
        }
        req.getRequestDispatcher("/WEB-INF/views/formulario.jsp").forward(req, resp);
    }

    private void editar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null) {
            Producto p = service.obtenerPorId(Integer.parseInt(id));
            req.setAttribute("producto", p);
        }
        req.getRequestDispatcher("/WEB-INF/views/formulario.jsp").forward(req, resp);
    }

    private void guardar(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String id = req.getParameter("id");
        String nombre = req.getParameter("nombre");
        String precioStr = req.getParameter("precio");
        String stockStr = req.getParameter("stock");
        String categoria = req.getParameter("categoria");
        
        Map<String, String> errores = new LinkedHashMap<>();

        // Validación de nombre
        if (nombre == null || nombre.trim().isEmpty())
            errores.put("nombre", "El nombre del producto es obligatorio.");
        else if (nombre.trim().length() > 100)
            errores.put("nombre", "El nombre no debe superar los 100 caracteres.");

        // Validación de precio
        double precio = 0;
        try {
            precio = Double.parseDouble(precioStr);
            if (precio < 0) errores.put("precio", "El precio no puede ser negativo.");
        } catch (NumberFormatException e) {
            errores.put("precio", "El precio debe ser un número válido (ej: 19.99).");
        }

        // Validación de stock
        int stock = 0;
        try {
            stock = Integer.parseInt(stockStr);
            if (stock < 0) errores.put("stock", "El stock no puede ser negativo.");
        } catch (NumberFormatException e) {
            errores.put("stock", "El stock debe ser un número entero.");
        }

        // Si hay errores, mostrar formulario nuevamente
        if (!errores.isEmpty()) {
            req.setAttribute("errores", errores);
            req.setAttribute("id", id);
            req.setAttribute("nombre", nombre);
            req.setAttribute("precio", precioStr);
            req.setAttribute("stock", stockStr);
            req.setAttribute("categoria", categoria);
            req.getRequestDispatcher("/WEB-INF/views/formulario.jsp").forward(req, resp);
            return;
        }

        // Guardar o actualizar
        Producto p;
        if (id != null && !id.isEmpty()) {
            p = new Producto(Integer.parseInt(id), nombre.trim(), categoria, precio, stock);
            service.actualizar(p);
        } else {
            p = new Producto(0, nombre.trim(), categoria, precio, stock);
            service.guardar(p);
        }

        resp.sendRedirect(req.getContextPath() + "/productos?mensaje=Producto+guardado");
    }

    private void eliminar(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String id = req.getParameter("id");
        if (id != null) {
            service.eliminar(Integer.parseInt(id));
        }
        resp.sendRedirect(req.getContextPath() + "/productos?mensaje=Producto+eliminado");
    }
}
