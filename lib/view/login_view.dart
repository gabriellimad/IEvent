import 'package:flutter/material.dart';
import '../controller/login_controller.dart';
import 'sobrenos.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtEmailEsqueceuSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Sobrenos()),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('lib/images/logo.jpg'),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'iEvent',
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            TextField(
              controller: txtEmail,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.email, color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 171, 53, 240)),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: txtSenha,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.lock, color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 171, 53, 240)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Esqueceu a senha?"),
                        content: Container(
                          height: 150,
                          child: Column(
                            children: [
                              Text(
                                "Digite seu e-mail cadastrado para receber o link para criar uma nova senha.",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(height: 25),
                              TextField(
                                controller: txtEmailEsqueceuSenha,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(color: Colors.black),
                                  prefixIcon:
                                      Icon(Icons.email, color: Colors.black),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actionsPadding: EdgeInsets.all(20),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              LoginController().esqueceuSenha(
                                context,
                                txtEmailEsqueceuSenha.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 103, 103, 255),
                            ),
                            child: Text('enviar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Precisa de ajuda para logar?',
                  style: TextStyle(color: Color.fromARGB(255, 241, 241, 241)),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(400, 50),
                primary: Color.fromARGB(255, 103, 103, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                LoginController().login(
                  context,
                  txtEmail.text,
                  txtSenha.text,
                );
              },
              child: Text('Entrar'),
            ),
            SizedBox(height: 200),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'cadastrar');
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Ainda não tem conta? ',
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: 'Cadastre-se',
                        style: TextStyle(
                          color: Color.fromARGB(146, 201, 201, 201),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
