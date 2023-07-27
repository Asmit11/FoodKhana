import 'package:flutter/material.dart';
import 'order.dart';

class EditOrderPage extends StatefulWidget {
  final Order order;

  EditOrderPage({required this.order});

  @override
  _EditOrderPageState createState() => _EditOrderPageState();
}

class _EditOrderPageState extends State<EditOrderPage> {
  TextEditingController _itemController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _itemController.text = widget.order.item;
    _amountController.text = widget.order.amount.toString();
    _selectedDate = widget.order.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'Item'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final newDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (newDate != null) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                }
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save changes and update the order
                widget.order.item = _itemController.text;
                widget.order.amount = double.parse(_amountController.text);
                widget.order.date = _selectedDate;

                // You can update the order in your database here

                // Go back to the previous screen after saving
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
