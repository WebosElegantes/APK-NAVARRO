import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'add_venta_screen.dart';

class VentasScreen extends StatefulWidget {
  const VentasScreen({Key? key}) : super(key: key);

  @override
  State<VentasScreen> createState() => _VentasScreenState();
}

class _VentasScreenState extends State<VentasScreen> {
  late Box ventasBox;

  @override
  void initState() {
    super.initState();
    _abrirVentasBox(); // Abre el box en el initState
  }

  Future<void> _abrirVentasBox() async {
    ventasBox = await Hive.openBox('ventasBox');
    if (!Hive.isBoxOpen('ventasBox')) {
      await Hive.openBox('ventasBox');
    } // Asegúrate de abrir el 'ventasBox'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ventas"),
      ),
      body: const Center(
        child: Text("Aquí se mostrarán las ventas"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddVentaScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
