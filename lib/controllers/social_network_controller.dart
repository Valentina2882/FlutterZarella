import 'package:get/get.dart';
import '../models/social_network.dart';

class SocialNetworkController extends GetxController {
  var posts = <SocialNetwork>[].obs;

  void addPost(String title, String content, String author, String? imageUrl) {
    posts.add(SocialNetwork(
        title: title, content: content, author: author, imageUrl: imageUrl, likes: 0, comments: []));
  }

  void deletePost(int index) {
    posts.removeAt(index);
  }

  void likePost(int index) {
    posts[index].likes++;
    posts.refresh();
  }

  void addComment(int postIndex, String commentText, String commentAuthor) {
    posts[postIndex].comments.add(Comment(author: commentAuthor, text: commentText));
    posts.refresh();
  }

  void deleteComment(int postIndex, int commentIndex) {
    posts[postIndex].comments.removeAt(commentIndex);
    posts.refresh();
  }

  void editPost(int index, String newTitle, String newContent, String newImageUrl) {
    posts[index].title = newTitle;
    posts[index].content = newContent;
    posts[index].imageUrl = newImageUrl;
    posts.refresh();
  }

  void editComment(int postIndex, int commentIndex, String newCommentText, String newCommentAuthor) {
    posts[postIndex].comments[commentIndex].text = newCommentText;
    posts[postIndex].comments[commentIndex].author = newCommentAuthor;
    posts.refresh();
  }
}
