import 'package:flutter/material.dart';
import 'package:foodkhana/models/FeedbackModel.dart';
import 'package:foodkhana/repositories/FeedbackRepository.dart';
import 'package:foodkhana/screens/DashBoardScreen.dart';

class CustomerFeedback extends StatefulWidget {
  @override
  _CustomerFeedbackState createState() => _CustomerFeedbackState();
}

class _CustomerFeedbackState extends State<CustomerFeedback> {
  int _rating = 0;
  String _comment = '';

  void _submitFeedback() {
    if (_rating > 0) {
      // Save the feedback to the database (Firebase).
      // Implement your Firebase database code here.
      // For simplicity, we'll just print the feedback for now.
      FeedbackModel feedback = FeedbackModel(rating: _rating, comment: _comment);
      print('Feedback submitted: ${feedback.rating} stars - ${feedback.comment}');
      CustomerFeedbackRepository().saveFeedback(feedback);
      // Show a dialog to notify the user that feedback has been submitted.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Feedback Submitted'),
            content: Text('Your feedback has been submitted.'),
            actions: [
              TextButton(
                onPressed: ()
          {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoardScreen()),
            );
          },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

    } else {
      // Show a dialog asking the user to provide a rating.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Rating is required'),
            content: Text('Please provide a rating before submitting your feedback.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'How would you rate your experience?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = i;
                      });
                    },
                    child: Icon(
                      Icons.star,
                      color: i <= _rating ? Colors.orange : Colors.grey,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Your feedback...',
              ),
              onChanged: (value) {
                setState(() {
                  _comment = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
