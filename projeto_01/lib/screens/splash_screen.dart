import 'package:flutter/material.dart'; // Importa a biblioteca de widgets do Flutter.
import 'home_screen.dart'; // Importa a tela principal do app.

class SplashScreen extends StatefulWidget { // Widget com estado mutável para a tela de carregamento.
  @override
  _SplashScreenState createState() => _SplashScreenState(); // Cria o estado para este widget.
}

class _SplashScreenState extends State<SplashScreen> { // Classe que gerencia o estado do SplashScreen.
  @override
  void initState() { // Chamado uma vez quando o widget é criado.
    super.initState(); // Chama o initState da classe pai.
    Future.delayed(Duration(seconds: 3), () { // Espera 3 segundos.
      Navigator.pushReplacement( // Navega para a HomeScreen substituindo a tela atual.
        context, // Contexto atual.
        MaterialPageRoute(builder: (context) => HomeScreen()), // Define a rota para a HomeScreen.
      );
    });
  }

  @override
  Widget build(BuildContext context) { // Constrói a interface do widget.
    return Scaffold( // Estrutura básica da tela.
      body: Center( // Centraliza o conteúdo.
        child: Column( // Organiza os filhos verticalmente.
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os filhos no eixo vertical.
          children: <Widget>[ // Lista de widgets filhos.
            Text( // Texto do título do app.
              'Meu App de Tarefas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Estilo do texto.
            ),
            SizedBox(height: 20), // Espaço vertical entre os widgets.
            CircularProgressIndicator(), // Indicador de carregamento circular.
          ],
        ),
      ),
    );
  }
}