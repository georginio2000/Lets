import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import '../widgets/map/map_activity_button.dart'; // Import the ActivityButton widget
// Import the ActivityButton widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'Flutter Map Example',
      theme: ThemeData.dark(), // Optional: Use a dark theme for the app
      home: const MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<Marker> _markers = []; // List to hold markers

  @override
  void initState() {
    super.initState();
    _loadMarkersFromFirestore(); // Load markers on initialization
  }

  Future<void> _loadMarkersFromFirestore() async {
    try {
      print("Fetching markers from Firestore...");
      // Access Firestore collection 'activities'
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('activities').get();

      // Iterate through the documents
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        print("Document Data: ${doc.data()}"); // Debug: Print the document data

        // Check for non-null latitude and longitude
        if (data['latitude'] != null &&
            data['longitude'] != null &&
            data['title'] != null &&
            data['time'] != null) {
          double latitude = (data['latitude'] as num).toDouble();
          double longitude = (data['longitude'] as num).toDouble();
          String title = data['title'];
          String time = data['time'];

          print("Adding marker at Latitude=$latitude, Longitude=$longitude"); // Debug

          // Add marker to the list
          _markers.add(
            Marker(
              point: LatLng(latitude, longitude),
              builder: (ctx) => Stack(
                clipBehavior: Clip.none, // Allow content to overflow
                alignment: Alignment.bottomCenter,
                children: [
                  // Activity Button
                  Positioned(
                    top: -70, // Position above the marker
                    left: 40, // Adjust position to the right
                    child: MapActivityButton(
                      title: title,
                      time: time,
                      activityId: doc.id, // Pass the activity ID
                    ),
                  ),
                  // Marker Icon
                  SvgPicture.asset(
                    'assets/SMALL_MAP_ICON.svg',
                    height: 30,
                    color: const Color(0xFF50B498),
                  ),
                ],
              ),
            ),
          );
        } else {
          print("Document skipped: Missing latitude, longitude, title, or time");
        }
      }

      // Update the UI after loading markers
      setState(() {
        print("Markers loaded: ${_markers.length} markers added");
      });
    } catch (e) {
      print("Error loading markers: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(37.9838, 23.7275), // Athens coordinates
          zoom: 13.0, // Initial zoom level
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png", // Dark theme
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: _markers, // Dynamically loaded markers
          ),
        ],
      ),
    );
  }
}

