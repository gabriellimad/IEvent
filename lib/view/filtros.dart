import 'package:flutter/material.dart';

class Filtros extends StatefulWidget {
  @override
  _FiltrosState createState() => _FiltrosState();
}

class _FiltrosState extends State<Filtros> {
  // Valores iniciais para os filtros
  double _selectedDistance = 5.0; // em km
  String _selectedEventType = 'Todos';
  bool _isPublic = true;

  // Opções de tipos de eventos
  final List<String> eventTypes = [
    'Todos',
    'Musical',
    'Social',
    'Infantil',
    'Cultural',
    'Teatro',
    'Balada',
    'Bar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar Eventos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Distância (km)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Slider(
                  value: _selectedDistance,
                  min: 1.0,
                  max: 50.0,
                  divisions: 49,
                  onChanged: (value) {
                    setState(() {
                      _selectedDistance = value;
                    });
                  },
                ),
                Text('${_selectedDistance.toStringAsFixed(1)} km'),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Tipo de Evento',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: _selectedEventType,
              onChanged: (value) {
                setState(() {
                  _selectedEventType = value!;
                });
              },
              items: eventTypes.map((String eventType) {
                return DropdownMenuItem<String>(
                  value: eventType,
                  child: Text(eventType),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Visibilidade',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                ),
                Text('Público'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Lógica para aplicar os filtros
        },
        label: Text('Aplicar Filtros'),
        icon: Icon(Icons.filter_list),
      ),
    );
  }
}
