import 'package:get/get.dart';
import '../models/social_network.dart';

class SocialNetworkController extends GetxController {
  var posts = <SocialNetwork>[].obs;

  void addPost(String title, String content, String author, String? imageUrl) {
    posts.add(SocialNetwork(title: title, content: content, author: author, imageUrl: imageUrl));
  }

  void addComment(int postIndex, String commentText, String commentAuthor) {
    posts[postIndex].comments.add(Comment(text: commentText, author: commentAuthor));
    posts.refresh();
  }

  void likePost(int index) {
    posts[index].likes++;
    posts.refresh();
  }

  void deletePost(int index) {
    posts.removeAt(index);
  }

  void deleteComment(int postIndex, int commentIndex) {
    posts[postIndex].comments.removeAt(commentIndex);
    posts.refresh();
  }
}
