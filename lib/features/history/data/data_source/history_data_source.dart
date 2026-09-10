import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/history_model.dart';

class HistoryDataSource {
  final FirebaseFirestore firestore;

  HistoryDataSource(this.firestore);

  Future<void> addToHistory(HistoryModel movie) async {
    await firestore
        .collection('history')
        .doc(movie.movieId.toString())
        .set(movie.toJson());
  }

  Future<List<HistoryModel>> getHistory() async {
    final snapshot = await firestore
        .collection('history')
        .orderBy('watchedAt', descending: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => HistoryModel.fromJson(doc.data()),
    )
        .toList();
  }

  Future<void> clearHistory() async {
    final snapshot =
    await firestore.collection('history').get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}