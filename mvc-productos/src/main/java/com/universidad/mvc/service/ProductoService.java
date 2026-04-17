package com.universidad.mvc.service;

import com.universidad.mvc.model.Producto;
import java.util.*;

public class ProductoService {
    private static final Map<Integer, Producto> productos = new LinkedHashMap<>();
    private static int nextId = 1;

    static {
        // Datos iniciales de prueba
        productos.put(1, new Producto(1, "Laptop Dell", "Informática", 899.99, 5));
        productos.put(2, new Producto(2, "Mouse Logitech", "Accesorios", 29.99, 50));
        productos.put(3, new Producto(3, "Teclado Mecánico", "Accesorios", 149.99, 15));
        nextId = 4;
    }

    public void guardar(Producto producto) {
        if (producto.getId() == 0) {
            producto.setId(nextId++);
        }
        productos.put(producto.getId(), producto);
    }

    public Producto obtenerPorId(int id) {
        return productos.get(id);
    }

    public Collection<Producto> obtenerTodos() {
        return productos.values();
    }

    public void eliminar(int id) {
        productos.remove(id);
    }

    public void actualizar(Producto producto) {
        if (productos.containsKey(producto.getId())) {
            productos.put(producto.getId(), producto);
        }
    }
}
