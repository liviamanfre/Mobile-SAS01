import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatelessWidget { // Widget StatelessWidget para exibir a tela de configurações.
  @override
  Widget build(BuildContext context) {// Retorna um Scaffold, que fornece a estrutura básica de uma tela
    return Scaffold(
       // Define a barra superior (AppBar) da tela.
      appBar: AppBar(
        title: Text('Configurações'), //Título
      ),
      body: Center(
        // Centraliza o widget filho dentro do corpo.
        child: Text('Tela de configurações'), //Texto Simples
      ),
    );
  }
}