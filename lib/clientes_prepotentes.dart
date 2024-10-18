import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'agregar_cliente_prepotentes.dart';
import 'editar_cliente_prepotentes.dart';

class ClientesScreen extends StatefulWidget {
  const ClientesScreen({Key? key}) : super(key: key);

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  final Box clientesBox = Hive.box('clientesBox');

  void agregarCliente(Map<String, String> cliente) {
    setState(() {
      clientesBox.add(cliente);
    });
  }

  void editarCliente(int index, Map<String, String> clienteEditado) {
    setState(() {
      clientesBox.putAt(index, clienteEditado);
    });
  }

  void eliminarCliente(int index) {
    setState(() {
      clientesBox.deleteAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
      ),
      body: clientesBox.isEmpty
          ? const Center(child: Text("No hay clientes añadidos"))
          : ListView.builder(
              itemCount: clientesBox.length,
              itemBuilder: (context, index) {
                final cliente =
                    (clientesBox.getAt(index) as Map).cast<String, String>();

                return ListTile(
                  title: Text(cliente['nombre']!),
                  subtitle: Text("Teléfono: ${cliente['telefono']}"),
                  onTap: () async {
                    // Editar cliente
                    final clienteEditado =
                        await Navigator.push<Map<String, String>>(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditarClienteScreen(cliente: cliente),
                      ),
                    );

                    if (clienteEditado != null) {
                      editarCliente(index, clienteEditado);
                    }
                  },
                  onLongPress: () {
                    // Eliminar cliente
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Eliminar Cliente'),
                          content: const Text(
                              '¿Estás seguro de eliminar este cliente?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Cerrar diálogo
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                eliminarCliente(index); // Eliminar cliente
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
          final cliente = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(
                builder: (context) => const AgregarClienteScreen()),
          );

          if (cliente != null) {
            agregarCliente(cliente);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
