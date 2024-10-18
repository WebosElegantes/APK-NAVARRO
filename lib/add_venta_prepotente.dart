import 'package:flutter/material.dart';
import 'seleccionar_producto_screen.dart';
import 'seleccionar_cliente_screen.dart';
import 'package:hive/hive.dart';

class AddVentaScreen extends StatefulWidget {
  const AddVentaScreen({Key? key}) : super(key: key);

  @override
  State<AddVentaScreen> createState() => _AddVentaScreenState();
}

class _AddVentaScreenState extends State<AddVentaScreen> {
  List<Map<String, dynamic>> productosSeleccionados = [];
  String? clienteSeleccionado;
  int cantidad = 1;

  void _seleccionarProducto() async {
    final producto = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SeleccionarProductoScreen()),
    );
    if (producto != null) {
      setState(() {
        productosSeleccionados.add(producto);
      });
    }
  }

  void _seleccionarCliente() async {
    final cliente = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SeleccionarClienteScreen()),
    );
    if (cliente != null) {
      setState(() {
        clienteSeleccionado = cliente;
      });
    }
  }

  void _finalizarVenta() async {
    // Obtener el box de productos y actualizar las cantidades
    final Box productosBox = Hive.box('productosBox');
    for (var producto in productosSeleccionados) {
      final index = productosBox.values.toList().indexOf(producto);
      final stockActual = int.parse(producto['cantidad']!);
      final cantidadVendida = producto['cantidadVendida'] != null
          ? int.parse(producto['cantidadVendida']!)
          : 0;

      final stockNuevo = stockActual - cantidadVendida;

      // Actualizar la cantidad del producto en el box
      if (index >= 0 && index < productosBox.length) {
        // Solo actualiza si el índice es válido
        productosBox.putAt(index, {
          'id': producto['id'],
          'nombre': producto['nombre'],
          'cantidad': stockNuevo.toString(),
          'categoria': producto['categoria'],
        });
      } else {
        // Manejar el caso en que el índice no sea válido
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar el producto.')),
        );
      }
    }

    // Guardar la venta con la fecha actual
    final Box ventasBox;
    if (!Hive.isBoxOpen('ventasBox')) {
      ventasBox = await Hive.openBox('ventasBox');
    } else {
      ventasBox = Hive.box('ventasBox');
    }

    final nuevaVenta = {
      'productos': productosSeleccionados.map((p) => p['id']).toList(),
      'cliente': clienteSeleccionado,
      'fecha': DateTime.now().toString(),
    };
    ventasBox.add(nuevaVenta);

    // Cerrar la pantalla y regresar a la pantalla de ventas
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir Venta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _seleccionarProducto,
              child: const Text("Seleccionar Producto"),
            ),
            const SizedBox(height: 10),
            if (productosSeleccionados.isNotEmpty)
              ...productosSeleccionados.map((producto) => ListTile(
                    title: Text(producto['nombre']),
                    subtitle: Text("Categoría: ${producto['categoria']}"),
                  )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _seleccionarCliente,
              child: const Text("Seleccionar Cliente"),
            ),
            if (clienteSeleccionado != null)
              Text("Cliente: $clienteSeleccionado"),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Cantidad",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  cantidad = int.parse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _finalizarVenta,
              child: const Text("Finalizar Venta"),
            ),
          ],
        ),
      ),
    );
  }
}
