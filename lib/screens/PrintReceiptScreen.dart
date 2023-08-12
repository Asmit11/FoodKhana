import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class PrintReceiptScreen extends StatefulWidget {
  PrintReceiptScreen({Key? key}) : super(key: key);

  @override
  PrintReceiptScreenState createState() => PrintReceiptScreenState();
}

class PrintReceiptScreenState extends State<PrintReceiptScreen> {
  final BlueThermalPrinter bluetoothPrinter = BlueThermalPrinter.instance;

  Future<void> printReceipt(BuildContext context) async {
    bool? connected = await bluetoothPrinter.isConnected;
    if (connected != true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Printer not connected.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),

              ),TextButton(
                child: const Text('Complete Order'),
                onPressed: () {
                  Navigator.of(context).pushNamed("/dashboard");
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      List<int> bytes = [];

      // Add receipt content as bytes
      bytes.addAll(utf8.encode('My Store\n'));
      bytes.addAll(utf8.encode('Date: ${DateTime.now()}\n'));
      bytes.addAll(utf8.encode('Item      Qty   Price\n'));
      bytes.addAll(utf8.encode('Product 1 1     10.0\n'));
      bytes.addAll(utf8.encode('Product 2 2     5.0\n'));
      bytes.addAll(utf8.encode('Total           15.0\n'));
      bytes.addAll(utf8.encode('Thank you!\n'));

      Uint8List data = Uint8List.fromList(bytes);

      await bluetoothPrinter.writeBytes(data);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Receipt printed successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while printing the receipt.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
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
        title: Text('Receipt Printer'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => printReceipt(context),
          child: Text('Print Receipt'),
        ),
      ),
    );
  }
}
