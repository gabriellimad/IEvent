import 'package:flutter/material.dart';

class Filtros extends StatefulWidget {
  @override
  _FiltrosState createState() => _FiltrosState();
}

class _FiltrosState extends State<Filtros> {
  double _selectedDistance = 5.0;
  String _selectedEventType = 'Todos';
  bool _isPublic = true;
  int _selectedAge = 18;
  bool _isPrivate = false;

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
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text('Filtrar Eventos'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Distância (km)',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Slider(
              value: _selectedDistance,
              min: 1.0,
              max: 50.0,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  _selectedDistance = value;
                });
              },
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
            ),
            Text(
              '${_selectedDistance.toStringAsFixed(1)} km',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Tipo de Evento',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            DropdownButton<String>(
              value: _selectedEventType,
              dropdownColor: Colors.grey[900],
              underline: Container(),
              onChanged: (value) {
                setState(() {
                  _selectedEventType = value!;
                });
              },
              items: eventTypes.map((String eventType) {
                return DropdownMenuItem<String>(
                  value: eventType,
                  child: Text(
                    eventType,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }).toList(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Visibilidade',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Checkbox(
                  value: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: Colors.grey[900],
                ),
                Text(
                  'Público',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 16.0),
                Checkbox(
                  value: _isPrivate,
                  onChanged: (value) {
                    setState(() {
                      _isPrivate = value!;
                    });
                  },
                  checkColor: Colors.white,
                  activeColor: Colors.grey[900],
                ),
                Text(
                  'Privado',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Idade',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Slider(
              value: _selectedAge.toDouble(),
              min: 0.0,
              max: 100.0,
              divisions: 100,
              onChanged: (value) {
                setState(() {
                  _selectedAge = value.toInt();
                });
              },
              activeColor: Colors.white,
              inactiveColor: Colors.grey,
            ),
            Text(
              _selectedAge == 0 ? 'Qualquer idade' : '$_selectedAge anos',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        label: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.black,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Aplicar Filtros',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        icon: Icon(Icons.filter_list),
      ),
    );
  }
}
