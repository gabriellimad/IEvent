import 'package:flutter/material.dart';
import '../controller/login_controller.dart';

class CadastrarView extends StatefulWidget {
  const CadastrarView({Key? key}) : super(key: key);

  @override
  _CadastrarViewState createState() => _CadastrarViewState();
}

class _CadastrarViewState extends State<CadastrarView> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtConfirmarSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _senhasBatem() {
    return txtSenha.text == txtConfirmarSenha.text;
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('lib/images/logo.jpg'),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Criar Conta',
                style: TextStyle(
                  fontSize: 60,
                ),
              ),
            ),
            SizedBox(height: 40),
            TextFormField(
              controller: txtNome,
              decoration: InputDecoration(
                labelText: 'Nome',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: txtEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: txtSenha,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: txtConfirmarSenha,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(140, 40),
                  primary: Color.fromARGB(255, 103, 103, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_senhasBatem()) {
                    LoginController().criarConta(
                      context,
                      txtNome.text,
                      txtEmail.text,
                      txtSenha.text,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Erro'),
                          content: Text('As senhas não coincidem.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'Salvar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
