import 'package:get/get.dart';
import '../models/social_network.dart';
//Controller for managing social network posts and comments.
class SocialNetworkController extends GetxController {
  //Observable list of posts.
  var posts = <SocialNetwork>[].obs;

  //Adds a new post to the list.
  void addPost(String title, String content, String author, String? imageUrl) {
    posts.add(SocialNetwork(
        title: title, content: content, author: author, imageUrl: imageUrl, likes: 0, comments: []));
  }
  //Deletes a post at a specified index.
  void deletePost(int index) {
    posts.removeAt(index);
  }
  //Increments the like count of a post at a specified index.
  void likePost(int index) {
    posts[index].likes++;
    posts.refresh();
  }
  //Adds a new comment to a post.
  void addComment(int postIndex, String commentText, String commentAuthor) {
    posts[postIndex].comments.add(Comment(author: commentAuthor, text: commentText));
    posts.refresh();
  }
  //Deletes a comment from a post.
  void deleteComment(int postIndex, int commentIndex) {
    posts[postIndex].comments.removeAt(commentIndex);
    posts.refresh();
  }
  //Edits the details of a post.
  void editPost(int index, String newTitle, String newContent, String newImageUrl) {
    posts[index].title = newTitle;
    posts[index].content = newContent;
    posts[index].imageUrl = newImageUrl;
    posts.refresh();
  }
  //Edits a comment on a post.
  void editComment(int postIndex, int commentIndex, String newCommentText, String newCommentAuthor) {
    posts[postIndex].comments[commentIndex].text = newCommentText;
    posts[postIndex].comments[commentIndex].author = newCommentAuthor;
    posts.refresh();
  }
}
