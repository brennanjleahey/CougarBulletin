import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Timestamp createdAt;
  String title;
  String body;
  String category;
  String contact;

  Post.fromMap(Map<String, dynamic> data) {
    createdAt = data['createdAt'];
    title = data['title'];
    body = data['body'];
    category = data['category'];
    contact = data['contact'];
  }
}