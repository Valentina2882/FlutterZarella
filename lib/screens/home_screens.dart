import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/social_network_controller.dart';

class HomeScreens extends StatelessWidget {
  final SocialNetworkController controller = Get.put(SocialNetworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Network'),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                var post = controller.posts[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Posted by: ${post.author}',
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.grey, size: 18), // Icono más pequeño y gris
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            String newTitle = post.title;
                                            String newContent = post.content;
                                            String newImageUrl = post.imageUrl ?? '';

                                            return AlertDialog(
                                              title: Text('Edit Post'),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    decoration: InputDecoration(labelText: 'Title'),
                                                    initialValue: post.title,
                                                    onChanged: (value) {
                                                      newTitle = value;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(labelText: 'Content'),
                                                    initialValue: post.content,
                                                    onChanged: (value) {
                                                      newContent = value;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    decoration: InputDecoration(labelText: 'Image URL'),
                                                    initialValue: post.imageUrl ?? '',
                                                    onChanged: (value) {
                                                      newImageUrl = value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('Save'),
                                                  onPressed: () {
                                                    controller.editPost(index, newTitle, newContent, newImageUrl);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red, size: 18), // Icono más pequeño
                                      onPressed: () {
                                        controller.deletePost(index);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(post.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(post.content),
                            if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Image.network(
                                  post.imageUrl!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Likes: ${post.likes}'),
                                IconButton(
                                  icon: Icon(Icons.thumb_up, color: Colors.blue, size: 18), // Icono más pequeño
                                  onPressed: () {
                                    controller.likePost(index);
                                  },
                                ),
                              ],
                            ),
                            Divider(),
                            for (var comment in post.comments.asMap().entries)
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text('${comment.value.author}: ${comment.value.text}'),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit, color: Colors.grey, size: 16), // Icono más pequeño y gris
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                String newCommentText = comment.value.text;
                                                String newCommentAuthor = comment.value.author;
                                                
                                                return AlertDialog(
                                                  title: Text('Edit Comment'),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      TextFormField(
                                                        decoration: InputDecoration(labelText: 'Comment'),
                                                        initialValue: comment.value.text,
                                                        onChanged: (value) {
                                                          newCommentText = value;
                                                        },
                                                      ),
                                                      TextFormField(
                                                        decoration: InputDecoration(labelText: 'Author'),
                                                        initialValue: comment.value.author,
                                                        onChanged: (value) {
                                                          newCommentAuthor = value;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child: Text('Cancel'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('Save'),
                                                      onPressed: () {
                                                        controller.editComment(index, comment.key, newCommentText, newCommentAuthor);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete, color: Colors.red, size: 16), // Icono más pequeño
                                          onPressed: () {
                                            controller.deleteComment(index, comment.key);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    String commentText = '';
                                    String commentAuthor = '';
                                    return AlertDialog(
                                      title: Text('Add Comment'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            decoration: InputDecoration(labelText: 'Comment'),
                                            onChanged: (value) {
                                              commentText = value;
                                            },
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(labelText: 'Author'),
                                            onChanged: (value) {
                                              commentAuthor = value;
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Submit'),
                                          onPressed: () {
                                            controller.addComment(index, commentText, commentAuthor);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text('Add Comment'),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Delete Post'),
                                    content: Text('Are you sure you want to delete this post?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          controller.deletePost(index);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Delete'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String title = '';
              String content = '';
              String author = '';
              String imageUrl = '';

              return AlertDialog(
                title: Text('Create Post'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Content'),
                      onChanged: (value) {
                        content = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Author'),
                      onChanged: (value) {
                        author = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      onChanged: (value) {
                        imageUrl = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text('Create'),
                    onPressed: () {
                      controller.addPost(title, content, author, imageUrl.isEmpty ? null : imageUrl);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
