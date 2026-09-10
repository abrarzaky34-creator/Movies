import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WatchListRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _userId {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently signed in.');
    }

    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _watchListCollection {
    return _firestore
        .collection('users')
        .doc(_userId)
        .collection('watchlist');
  }

  Future<void> addMovie({
    required int movieId,
    required String title,
    required String posterUrl,
  }) async {
    await _watchListCollection.doc(movieId.toString()).set({
      'movieId': movieId,
      'title': title,
      'posterUrl': posterUrl,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeMovie(int movieId) async {
    await _watchListCollection.doc(movieId.toString()).delete();
  }

  Future<bool> isMovieInWatchList(int movieId) async {
    final doc = await _watchListCollection.doc(movieId.toString()).get();

    return doc.exists;
  }

  Stream<List<Map<String, dynamic>>> getWatchList() {
    return _watchListCollection
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }
}