import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ievent/view/selecao_colecao.dart';
import 'package:ievent/view/sobrenos.dart';
import 'package:ievent/view/cadastro_usuario.dart';
import 'package:ievent/view/evento_publico.dart';

import 'firebase_options.dart';
import 'view/login_view.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      builder: (context) => MaterialApp(
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'cadastrar': (context) => CadastrarView(),
          'login': (context) => LoginView(),
          'principal': (context) => HomeView(),
          'sobrenos': (context) => Sobrenos(),
        },
      ),
    ),
  );
}
