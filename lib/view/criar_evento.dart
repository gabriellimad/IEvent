// import 'package:flutter/material.dart';

// import '../controller/evento_publico_controller.dart';
// import '../controller/login_controller.dart';
// import '../model/evento.dart';
// import 'eventos_view.dart';

// class CadastroScreen extends StatefulWidget {
//   @override
//   _CadastroScreenState createState() => _CadastroScreenState();
// }

// class _CadastroScreenState extends State<CadastroScreen> {
//   TextEditingController txtNome = EventosView().createState().txtNome;
//   TextEditingController txtLocal = EventosView().createState().txtLocal;
//   TextEditingController txtDescricao =
//       EventosView().createState().txtDescricao;
//   var eventId = EventosView().createState().


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cadastro de eventos'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: txtNome,
//               decoration: InputDecoration(
//                 labelText: 'Nome',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               controller: txtLocal,
//               decoration: InputDecoration(
//                 labelText: 'Local',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               controller: txtDescricao,
//               decoration: InputDecoration(
//                 labelText: 'Descrição',
//               ),
//             ),
//             SizedBox(height: 32.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                 var event = Eventos(LoginController().idUsuario(), txtNome.text,
//                     txtLocal.text, txtDescricao.text);
//                 txtNome.clear();
//                 txtDescricao.clear();
//                 txtLocal.clear();
//                 if (eventId == null) {
//                   EventosController().adicionar(context, event);
//                 } else {
//                   EventosController().atualizar(context, eventId, event);
//                 }
//               },
//                   child: Text('Salvar'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text('Fechar'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
