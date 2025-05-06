import 'package:flutter/material.dart'; 
import 'screens/home_screen.dart'; //importa (HomeScreen)
import 'screens/splash_screen.dart';//(SplashScreen).

void main() {
  runApp(MyApp()); //raiz do aplicativo
}

class MyApp extends StatelessWidget {
  @override // Sobrescreve o método build, responsável por construir a interface do widget.
  Widget build(BuildContext context) {
    return MaterialApp(// Retorna um MaterialApp, que configura a estrutura básica de um aplicativo.
      title: 'Gerenciador de Tarefas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}