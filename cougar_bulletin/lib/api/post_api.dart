

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cougar_bulletin/model/post.dart';
import 'package:cougar_bulletin/model/user.dart';
import 'package:cougar_bulletin/notifier/auth_notifier.dart';
import 'package:cougar_bulletin/notifier/post_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';


login(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

signup(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = user.displayName;

    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile(updateInfo);
      // refresh
      await firebaseUser.reload();

      print("Sign up: $firebaseUser");
      // refresh current user
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError((error) => print(error.code));

  authNotifier.setUser(null);
}

// Get the current user from firebase if we're already signed in
initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getPosts(PostNotifier postNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance.collection('post').getDocuments();

  List<Post> _postList = [];

  snapshot.documents.forEach((document) {
    Post post = Post.fromMap(document.data);
    _postList.add(post);
  });

  postNotifier.postList = _postList.reversed.toList();
}

uploadPost(Post post, bool isUpdating) async {
  CollectionReference postRef = Firestore.instance.collection('post');

  if(isUpdating){
    await postRef.document(post.id).updateData(post.toMap());
    print("Updated post: ${post.id}");
  }
  else
  {
    DocumentReference docRef = await postRef.add(post.toMap());

    post.id = docRef.documentID;

    print("Uploaded post: ${post.toString()}");

    await docRef.setData(post.toMap(), merge: true);
  }


}

//Todo - upload image Coding With Curry Part 3 45:00