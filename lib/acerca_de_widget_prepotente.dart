import 'package:flutter/material.dart';
import 'acerca_de_screen.dart';
import 'main.dart';

class AcercaDeWidget extends StatelessWidget {
  const AcercaDeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AcercaDeScreen()),
        );
      },
      child: const DashboardItem(
        title: "Acerca de",
        iconData: Icons.info,
        background: Colors.blue,
      ),
    );
  }
}
