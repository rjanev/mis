import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/Exam.dart';
import '../services/service.dart';

class LocationMapScreen extends StatefulWidget {
  final List<Exam> exams;

  const LocationMapScreen({Key? key, required this.exams}) : super(key: key);

  @override
  _LocationMapScreenState createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  bool isRouteLoading = false;
  bool isLocationLoading = true;
  LatLng? currentLocation;
  List<LatLng> routeCoordinates = [];
  LatLng center = LatLng(42.0047680, 21.4097789);
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    fetchUserLocation();
    calculateExamsCenter();
  }

  Future<void> fetchUserLocation() async {
    final location = await _locationService.fetchUserLocation();
    if (location != null) {
      setState(() {
        currentLocation = location;
        isLocationLoading = false;
      });
    } else {
      setState(() {
        isLocationLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch current location')),
      );
    }
  }

  void calculateExamsCenter() {
    if (widget.exams.isEmpty) return;

    double totalLat = 0;
    double totalLon = 0;

    for (var exam in widget.exams) {
      totalLat += exam.latitude;
      totalLon += exam.longitude;
    }

    setState(() {
      center = LatLng(totalLat / widget.exams.length, totalLon / widget.exams.length);
    });
  }

  Future<void> fetchRoute(LatLng destination) async {
    if (currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to fetch current location.')),
      );
      return;
    }

    setState(() {
      routeCoordinates = [];
      isRouteLoading = true;
    });

    try {
      final newRoute = await _locationService.fetchRoute(currentLocation!, destination);
      setState(() {
        routeCoordinates = newRoute;
        isRouteLoading = false;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching route: $error')),
        );
      }
      setState(() {
        isRouteLoading = false;
      });
    }
  }

  void showLocationDetails(BuildContext context, Exam exam) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              exam.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.place, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(child: Text('Location: ${exam.location}')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Text('Latitude: ${exam.latitude}')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Text('Longitude: ${exam.longitude}')),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: Text('Time: ${exam.dateTime}')),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await fetchRoute(LatLng(exam.latitude, exam.longitude));
              },
              child: const Text('Show route'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: isLocationLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: MapOptions(center: center, zoom: 14.0),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          if (currentLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: currentLocation!,
                  builder: (ctx) => const Icon(Icons.my_location, color: Colors.blue, size: 27.0),
                ),
              ],
            ),
          MarkerLayer(
            markers: widget.exams.map((exam) {
              return Marker(
                point: LatLng(exam.latitude, exam.longitude),
                builder: (ctx) => GestureDetector(
                  onTap: () {
                    showLocationDetails(context, exam);
                  },
                  child: const Icon(Icons.location_on, color: Colors.red, size: 30.0),
                ),
              );
            }).toList(),
          ),
          if (routeCoordinates.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(points: routeCoordinates, color: Colors.blue, strokeWidth: 4.0),
              ],
            ),
        ],
      ),
    );
  }
}
