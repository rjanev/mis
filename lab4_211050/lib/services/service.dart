import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class LocationService {
  Future<bool> requestLocationPermission() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<LatLng?> fetchUserLocation() async {
    final hasPermission = await requestLocationPermission();
    if (!hasPermission) return null;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (error) {
      return null;
    }
  }

  Future<List<LatLng>> fetchRoute(LatLng start, LatLng destination) async {
    try {
      final response = await http.get(Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=geojson',
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> coords = data['routes'][0]['geometry']['coordinates'];
        return coords.map((coord) => LatLng(coord[1], coord[0])).toList();
      } else {
        throw Exception('Error fetching route');
      }
    } catch (error) {
      return [];
    }
  }
}
