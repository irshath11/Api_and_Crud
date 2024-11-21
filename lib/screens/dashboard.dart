import 'package:api_pagination_task/screens/photo_section.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttonSection("API Section", photoSectionNavigation),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          buttonSection("CRUD Section", photoSectionNavigation)
        ],
      ),
    );
  }

  Widget buttonSection(String title, Function() ontap ){
    return SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.075,
            child: ElevatedButton(
              onPressed: ontap,
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey,
                elevation: 5,
              ),
              child: Text(title, style: const TextStyle(fontSize: 16, color: Colors.black)),
            ),
          );
  }


  photoSectionNavigation() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PhotosSection()),
    );
  }
}
