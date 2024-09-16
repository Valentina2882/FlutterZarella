class SocialNetwork {
  String title;
  String content;
  String author;
  String? imageUrl;
  List<Comment> comments;
  int likes;  // Nuevo campo para los likes

  SocialNetwork({
    required this.title,
    required this.content,
    required this.author,
    this.imageUrl,
    this.likes = 0,  // Inicializa con 0 likes
    List<Comment>? comments,
  }) : this.comments = comments ?? [];
}

class Comment {
  String text;
  String author;

  Comment({required this.text, required this.author});
}
