import 'package:flutter/material.dart';

class AgregarProductoScreen extends StatefulWidget {
  const AgregarProductoScreen({Key? key}) : super(key: key);

  @override
  State<AgregarProductoScreen> createState() => _AgregarProductoScreenState();
}

class _AgregarProductoScreenState extends State<AgregarProductoScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  void _guardarProducto() {
    final Map<String, String> producto = {
      'id': _idController.text,
      'nombre': _nombreController.text,
      'cantidad': _cantidadController.text,
      'categoria': _categoriaController.text,
    };

    Navigator.pop(context, producto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir Producto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'ID de Producto'),
            ),
            TextField(
              controller: _nombreController,
              decoration:
                  const InputDecoration(labelText: 'Nombre de Producto'),
            ),
            TextField(
              controller: _cantidadController,
              decoration: const InputDecoration(labelText: 'Cantidad'),
            ),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarProducto,
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
