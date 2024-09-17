class SocialNetwork {
  String title;
  String content;
  String author;
  String? imageUrl;
  List<Comment> comments;
  int likes;  

  //Constructor 
  SocialNetwork({
    required this.title,
    required this.content,
    required this.author,
    this.imageUrl,
    this.likes = 0, 
    List<Comment>? comments,
  }) : this.comments = comments ?? [];
}

class Comment {
  String text;
  String author;

  //Constructor 
  //
  Comment({required this.text, required this.author});
}
