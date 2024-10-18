import 'package:flutter/material.dart';

class EditarProductoScreen extends StatefulWidget {
  final Map<String, String> producto;

  const EditarProductoScreen({Key? key, required this.producto})
      : super(key: key);

  @override
  _EditarProductoScreenState createState() => _EditarProductoScreenState();
}

class _EditarProductoScreenState extends State<EditarProductoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _idController;
  late TextEditingController _nombreController;
  late TextEditingController _cantidadController;
  late TextEditingController _categoriaController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.producto['id']);
    _nombreController = TextEditingController(text: widget.producto['nombre']);
    _cantidadController =
        TextEditingController(text: widget.producto['cantidad']);
    _categoriaController =
        TextEditingController(text: widget.producto['categoria']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID de Producto'),
              ),
              TextFormField(
                controller: _nombreController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de Producto'),
              ),
              TextFormField(
                controller: _cantidadController,
                decoration:
                    const InputDecoration(labelText: 'Cantidad de Producto'),
              ),
              TextFormField(
                controller: _categoriaController,
                decoration:
                    const InputDecoration(labelText: 'Categoría de Producto'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'id': _idController.text,
                      'nombre': _nombreController.text,
                      'cantidad': _cantidadController.text,
                      'categoria': _categoriaController.text,
                    });
                  }
                },
                child: const Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
