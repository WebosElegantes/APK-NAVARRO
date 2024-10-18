import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'agregar_producto_prepotentes.dart';
import 'editar_producto_prepotentes.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({Key? key}) : super(key: key);

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  final Box productosBox = Hive.box('productosBox');

  void agregarProducto(Map<String, String> producto) {
    setState(() {
      productosBox.add(producto);
    });
  }

  void editarProducto(int index, Map<String, String> productoEditado) {
    setState(() {
      productosBox.putAt(index, productoEditado);
    });
  }

  void eliminarProducto(int index) {
    setState(() {
      productosBox.deleteAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),
      body: productosBox.isEmpty
          ? const Center(child: Text("No hay productos añadidos"))
          : ListView.builder(
              itemCount: productosBox.length,
              itemBuilder: (context, index) {
                final producto =
                    (productosBox.getAt(index) as Map).cast<String, String>();

                return ListTile(
                  title: Text(producto['nombre']!),
                  subtitle: Text("Categoría: ${producto['categoria']}"),
                  onTap: () async {
                    // Editar producto
                    final productoEditado =
                        await Navigator.push<Map<String, String>>(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditarProductoScreen(producto: producto),
                      ),
                    );

                    if (productoEditado != null) {
                      editarProducto(index, productoEditado);
                    }
                  },
                  onLongPress: () {
                    // Eliminar producto
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Eliminar Producto'),
                          content: const Text(
                              '¿Estás seguro de eliminar este producto?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Cerrar diálogo
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                eliminarProducto(index); // Eliminar producto
                                Navigator.of(context).pop(); // Cerrar diálogo
                              },
                              child: const Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final producto = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(
                builder: (context) => const AgregarProductoScreen()),
          );

          if (producto != null) {
            agregarProducto(producto);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
