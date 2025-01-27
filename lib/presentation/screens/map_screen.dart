import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Welcome to map screen'),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                child: Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
