import 'package:flutter/material.dart'; // Importa a biblioteca de widgets do Flutter.

class HelpScreen extends StatelessWidget { // Widget StatelessWidget para exibir a tela de ajuda (não possui estado interno mutável).
  @override
  Widget build(BuildContext context) { // Método build obrigatório para StatelessWidget, descreve a UI.
    return Scaffold( // Estrutura básica da tela com AppBar e corpo.
      appBar: AppBar( // Barra superior da tela.
        title: Text('Ajuda'), // Título exibido na AppBar.
      ),
      body: Center( // Centraliza o widget filho no corpo da tela.
        child: Text('Tela de Ajuda'), // Texto exibido no centro da tela de ajuda.
      ),
    );
  }
}