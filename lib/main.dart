import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'acerca_de_widget.dart';
import 'productos_prepotentes.dart';
import 'clientes_prepotentes.dart';
import 'ventas_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('productosBox');
  await Hive.openBox('clientesBox');
  await Hive.openBox('ventasBox');

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Punto de Venta',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.only(bottomRight: Radius.circular(50)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text(
                    'Punto de Venta',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Bienvenido',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white54),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(100))),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 20,
                children: const [
                  ProductosWidget(),
                  ClientesWidget(),
                  VentasWidget(),
                  AcercaDeWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VentasWidget extends StatelessWidget {
  const VentasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const VentasScreen()), // <-- Navegación a VentasScreen
        );
      },
      child: const DashboardItem(
        title: "Ventas",
        iconData: CupertinoIcons.money_dollar_circle,
        background: Colors.red,
      ),
    );
  }
}

class ProductosWidget extends StatelessWidget {
  const ProductosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductosScreen(),
          ),
        );
      },
      child: const DashboardItem(
        title: "Productos",
        iconData: CupertinoIcons.cube_box_fill,
        background: Colors.green,
      ),
    );
  }
}

class ClientesWidget extends StatelessWidget {
  const ClientesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ClientesScreen(),
          ),
        );
      },
      child: const DashboardItem(
        title: "Clientes",
        iconData: CupertinoIcons.person_2,
        background: Colors.purple,
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color background;

  const DashboardItem({
    Key? key,
    required this.title,
    required this.iconData,
    required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Theme.of(context).primaryColor.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
