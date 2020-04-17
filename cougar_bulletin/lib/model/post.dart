import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Timestamp createdAt;
  Timestamp lastUpdate;
  String id;
  String title;
  String body;
  String category;
  String contact;
  String author;

  Post();

  Post.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    createdAt = data['createdAt'];
    lastUpdate = data['lastUpdate'];
    title = data['title'];
    body = data['body'];
    category = data['category'];
    contact = data['contact'];
    author = data['author'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'createdAt': createdAt,
      'lastUpdate': lastUpdate,
      'title': title,
      'body': body,
      'category': category,
      'contact': contact,
      'author': author
    };
  }
}