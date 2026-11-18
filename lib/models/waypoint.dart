class Waypoint {
  final String nome;
  final double latitude;
  final double longitude;
  final double altitude;

  const Waypoint({
    required this.nome,
    required this.latitude,
    required this.longitude,
    this.altitude = 0.0,
  });
}