import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'filtros.dart';

class TelaMapa extends StatelessWidget {
  const TelaMapa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text('Mapa'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<Widget>(
            future: _carregarImagemFundo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                }
              }
              return Container(); 
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Filtros()),
          );
        },
        child: Icon(Icons.filter_list),
        backgroundColor: Color.fromARGB(255, 0, 139, 19),
        
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<Widget> _carregarImagemFundo() async {
    final imageBytes = await rootBundle.load('lib/images/mapa.jpg');
    return Image.memory(
      imageBytes.buffer.asUint8List(),
      fit: BoxFit.cover,
    );
  }
}
