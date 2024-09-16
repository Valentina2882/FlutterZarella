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
                            Text(
                              'Posted by: ${post.author}',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              post.title,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
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

                            SizedBox(height: 10),
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Likes: ${post.likes}'),
                                IconButton(
                                  icon: Icon(Icons.thumb_up, color: Colors.blue[700]),
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
                                      child: Text(
                                        '${comment.value.author}: ${comment.value.text}',
                                        style: TextStyle(fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        controller.deleteComment(index, comment.key);
                                      },
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
                                          TextField(
                                            decoration: InputDecoration(labelText: 'Comment'),
                                            onChanged: (value) {
                                              commentText = value;
                                            },
                                          ),
                                          TextField(
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
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Content'),
                      onChanged: (value) {
                        content = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Author'),
                      onChanged: (value) {
                        author = value;
                      },
                    ),
                    TextField(
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
                    child: Text('Post'),
                    onPressed: () {
                      controller.addPost(title, content, author, imageUrl);
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
