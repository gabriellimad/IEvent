import 'package:flutter/material.dart';
import '../model/empresa.dart';
import 'empresa.dart';
import 'evento_publico.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool showEventButtons = true;

  void _toggleEventButtons() {
    setState(() {
      showEventButtons = !showEventButtons;
    });
  }

  void _navigateToEventView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventoPublico()),
    );
  }

  void _navigateToEmpresaView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmpresaView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 103, 103, 255),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showEventButtons)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _toggleEventButtons();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 103, 103, 255),
                        fixedSize: Size(300, 120),
                      ),
                      child: Text(
                        'Gerenciar Eventos',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _navigateToEmpresaView,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 103, 103, 255),
                        fixedSize: Size(300, 120),
                      ),
                      child: Text(
                        'Gerenciar Empresas',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              if (!showEventButtons)
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _navigateToEventView();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 103, 103, 255),
                        fixedSize: Size(300, 120),
                      ),
                      child: Text(
                        'Eventos Públicos',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _navigateToEventView();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 103, 103, 255),
                        fixedSize: Size(300, 120),
                      ),
                      child: Text(
                        'Eventos Privados',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _toggleEventButtons,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 103, 103, 255),
                      ),
                      child: Text(
                        'Voltar',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
