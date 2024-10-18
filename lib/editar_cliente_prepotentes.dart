import 'package:flutter/material.dart';

class EditarClienteScreen extends StatefulWidget {
  final Map<String, String> cliente;

  const EditarClienteScreen({Key? key, required this.cliente})
      : super(key: key);

  @override
  _EditarClienteScreenState createState() => _EditarClienteScreenState();
}

class _EditarClienteScreenState extends State<EditarClienteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.cliente['nombre']);
    _telefonoController =
        TextEditingController(text: widget.cliente['telefono']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration:
                    const InputDecoration(labelText: 'Nombre de Cliente'),
              ),
              TextFormField(
                controller: _telefonoController,
                decoration:
                    const InputDecoration(labelText: 'Número de Teléfono'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'nombre': _nombreController.text,
                      'telefono': _telefonoController.text,
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
