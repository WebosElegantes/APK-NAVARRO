import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SeleccionarProductoScreen extends StatelessWidget {
  const SeleccionarProductoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productosBox = Hive.box('productosBox');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar Producto"),
      ),
      body: ListView.builder(
        itemCount: productosBox.length,
        itemBuilder: (context, index) {
          final producto =
              (productosBox.getAt(index) as Map).cast<String, String>();
          return ListTile(
            title: Text(producto['nombre']!),
            subtitle: Text("Categoría: ${producto['categoria']}"),
            onTap: () {
              Navigator.pop(context, producto);
            },
          );
        },
      ),
    );
  }
}
