import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SeleccionarClienteScreen extends StatelessWidget {
  const SeleccionarClienteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientesBox = Hive.box('clientesBox');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar Cliente"),
      ),
      body: ListView.builder(
        itemCount: clientesBox.length,
        itemBuilder: (context, index) {
          final cliente =
              (clientesBox.getAt(index) as Map).cast<String, String>();
          return ListTile(
            title: Text(cliente['nombre']!),
            subtitle: Text("Teléfono: ${cliente['telefono']}"),
            onTap: () {
              Navigator.pop(context, cliente['telefono']);
            },
          );
        },
      ),
    );
  }
}
