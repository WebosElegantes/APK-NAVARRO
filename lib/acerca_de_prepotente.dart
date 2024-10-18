import 'package:flutter/material.dart';

class AcercaDeScreen extends StatelessWidget {
  const AcercaDeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Proyecto: Punto de venta',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Materia: Tópicos de Programación Avanzada',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Docente: Eder Jahir Gonzalez Bravo',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Alumno: Jesús Sánchez Morales',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
