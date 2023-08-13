import 'package:flutter/material.dart';

class EditFeedbackScreen extends StatelessWidget {
  // Dummy initial feedback
  final String initialFeedback =
      "Excellent.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit your feedback:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              maxLines: 5,
              initialValue: initialFeedback, // Pre-filled dummy data
              decoration: InputDecoration(
                hintText: 'Enter your feedback here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement the save functionality
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EditFeedbackScreen(),
  ));
}
