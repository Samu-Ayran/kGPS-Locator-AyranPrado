import 'package:flutter/material.dart';

void main() {
  runApp(const KGpsLocatorApp());
}

class KGpsLocatorApp extends StatelessWidget {
  const KGpsLocatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kGPS-Locator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dados fictícios para a Gaveta 2
  double latitude = -23.2048746;
  double longitude = -46.1559800;
  double altitude = 760.0;
  double heading = 45.0;

  Waypoint? navegandoPara;

  final List<Waypoint> waypoints = [
    const Waypoint(nome: 'WP001', latitude: -23.164281, longitude: -45.896756),
    const Waypoint(nome: 'WP002', latitude: -23.189425, longitude: -46.026272),
    const Waypoint(nome: 'WP003', latitude: -23.811881, longitude: -45.396372),
  ];

  void navegarPara(Waypoint waypoint) {
    print('Você acionou o Navegar para ${waypoint.nome}');
    
    setState(() {
      navegandoPara = waypoint;
    });
  }

  void pararNavegacao() {
    if (navegandoPara != null) {
      print('Você parou o Navegar para ${navegandoPara!.nome}');
    }

    setState(() {
      navegandoPara = null;
    });
  }

  void adicionarWaypoint(Waypoint waypoint) {
    print('Você clicou no botão Add Waypoint ${waypoint.nome}');
  }

  void excluirWaypoint(Waypoint waypoint) {
    print('Você acionou o excluir Waypoint ${waypoint.nome}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('kGPS-Locator')),
      body: SafeArea(
        child: Column(
            children: [
              const SizedBox(height: 12),

              Compass(heading: heading),

              const SizedBox(height: 8),

              Text(
                'Heading: ${heading.toStringAsFixed(2)}°',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              _buildLocationInfo(),

              const SizedBox(height: 12),

              if (navegandoPara != null) _buildNavigationInfo(),

              const SizedBox(height: 8),

              Expanded(child: _buildWaypointList()),
            ],
          ),
        ),

        floatingActionButton: navegandoPara != null
            ? FloatingActionButton.extended(
                onPressed: pararNavegacao,
                icon: const Icon(Icons.stop),
                label: const Text('STOP'),
            )
            : null,

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.icon(
            onPressed: adicionarWaypoint,
            icon: const Icon(Icons.add_location_alt),
            label: const Text('Add Waypoint'),
          ),
        ),
    );
  }

  Widget _buildLocationInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _infoRow('Latitude', '${latitude.toStringAsFixed(6)}°'),
              _infoRow('Longitude', '${longitude.toStringAsFixed(6)}°'),
              _infoRow('Altitude', '${altitude.toStringAsFixed(1)} m'),
            ],
          ), 
        ),
      ),
    );
  }

  Widget _buildNavigationInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: Colors.blue.shade50,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                'Navegando para: ${navegandoPara!.nome}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              _infoRow('Latitude', '${navegandoPara!.latitude.toStringAsFixed(6)}°'),
              _infoRow('Longitude', '${navegandoPara!.longitude.toStringAsFixed(6)}°'),
              _infoRow('Altitude', '${navegandoPara!.altitude.toStringAsFixed(1)} m'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationInfo() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              'NAVEGANDO PARA',
              //Parei aqui 21/10/26
            )
          ]
        ),
      ),
    );
  }

}
// Inicialização do Projeto Flutter

