class PhotoScreenModel {
  final int id;
  final String title;
  final String thumbnailUrl;

  PhotoScreenModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
  });

  factory PhotoScreenModel.fromJson(Map<String, dynamic> json) {
    return PhotoScreenModel(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
