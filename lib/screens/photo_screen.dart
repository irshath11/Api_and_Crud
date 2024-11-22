import 'dart:developer';
import 'package:api_pagination_task/model/photo_screen_model.dart';
import 'package:flutter/material.dart';
import '../helpers/api_service.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  List<PhotoScreenModel> photos = [];
  int start = 0;
  final int limit = 10;
  bool isLoading = false;
  String searchQuery = "";

  final ApiService apiService = ApiService();

  @override 
  void initState() {
    super.initState();
    fetchMorePhotos();
  }

  Future<void> fetchMorePhotos() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      final newPhotos = await apiService.fetchPhotos(start, limit);
      setState(() {
        start += limit;
        photos.addAll(newPhotos);
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Photo Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search by title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: photos.isEmpty && !isLoading
                ? const Center(child: Text('No photos available'))
                : ListView.builder(
                    itemCount: photos.length + 1,
                    itemBuilder: (context, index) {
                      if (index < photos.length) {
                        final photo = photos[index];
                        if (searchQuery.isNotEmpty &&
                            !photo.title.toLowerCase().contains(searchQuery.toLowerCase())) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(photo.thumbnailUrl, width: 50, height: 50, fit: BoxFit.cover),
                              ),
                              title: Text(
                                photo.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'ID: ${photo.id}',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevatedButton(
                                  onPressed: fetchMorePhotos,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.cyan,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: const Text("Load More", style: TextStyle(fontSize: 16, color: Colors.black)),
                                ),
                              );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
