import 'dart:developer';

import 'package:flutter/material.dart';
import '../helpers/api_service.dart';

class PhotosSection extends StatefulWidget {
  const PhotosSection({super.key});

  @override
  _PhotosSectionState createState() => _PhotosSectionState();
}

class _PhotosSectionState extends State<PhotosSection> {
  List photos = [];
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
        log("photos::: ${photos.toList()}");
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => setState(() => searchQuery = value),
          decoration: const InputDecoration(hintText: "Search by title"),
        ),
      ),
      body: ListView.builder(
        itemCount: photos.length + 1,
        itemBuilder: (context, index) {
          if (index < photos.length) {
            final photo = photos[index];
            if (searchQuery.isNotEmpty &&
                !photo['title'].toString().contains(searchQuery)) {
              return const SizedBox.shrink();
            }
            return ListTile(
              leading: Image.network(photo['thumbnailUrl']),
              title: Text(photo['title']),
            );
          } else {
            return isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: fetchMorePhotos, child: const Text("Load More"));
          }
        },
      ),
    );
  }
}
