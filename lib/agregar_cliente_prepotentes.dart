import 'package:flutter/material.dart';

class AgregarClienteScreen extends StatefulWidget {
  const AgregarClienteScreen({Key? key}) : super(key: key);

  @override
  State<AgregarClienteScreen> createState() => _AgregarClienteScreenState();
}

class _AgregarClienteScreenState extends State<AgregarClienteScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  void _guardarCliente() {
    final Map<String, String> cliente = {
      'nombre': _nombreController.text,
      'telefono': _telefonoController.text,
    };

    Navigator.pop(context, cliente);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir Cliente"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration:
                  const InputDecoration(labelText: 'Nombre del Cliente'),
            ),
            TextField(
              controller: _telefonoController,
              decoration:
                  const InputDecoration(labelText: 'Número de Teléfono'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarCliente,
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
