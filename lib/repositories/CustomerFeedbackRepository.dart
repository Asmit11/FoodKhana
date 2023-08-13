

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodkhana/models/FeedbackModel.dart';

class CustomerFeedbackRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveFeedback(FeedbackModel feedback) async {
    try {

      await _firestore.collection('feedbacks').add({

        'rating': feedback.rating,
        'comment': feedback.comment,
        'timestamp': FieldValue.serverTimestamp(),

      });
    } catch (e) {
      // Handle any errors that occurred during the process.
      print('Error saving feedback: $e');
      rethrow; // Rethrow the error to handle it in the calling code.
    }
  }
}

