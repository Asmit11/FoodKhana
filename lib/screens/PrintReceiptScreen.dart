import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receipt Printer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReceiptPrinterPage(),
    );
  }
}

class ReceiptPrinterPage extends StatelessWidget {
  final PrinterNetworkManager printerManager = PrinterNetworkManager();

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

  Future<void> printReceipt(BuildContext context) async {
    final PosPrintResult res = await printerManager.connect('192.168.1.10', port: 9100);

    if (res != PosPrintResult.success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to connect to the printer.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    const PaperSize paper = PaperSize.mm80;

    final PosPrintResult printResult = await printerManager.printTicket(
      await _ticket(paper),
      printerManager: printerManager,
    );

    await printerManager.disconnect();

    if (printResult != PosPrintResult.success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to print the receipt.'),
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

  Future<Ticket> _ticket(PaperSize paper) async {
    final Ticket ticket = Ticket(paper);

    ticket.text('My Store', styles: PosStyles(align: PosAlign.center, bold: true));
    ticket.feed(1);

    ticket.text('Date: ${DateTime.now()}', styles: PosStyles(align: PosAlign.left));
    ticket.feed(1);

    ticket.row([
      PosColumn(text: 'Item', width: 6),
      PosColumn(text: 'Qty', width: 2),
      PosColumn(text: 'Price', width: 4),
    ]);

    ticket.row([
      PosColumn(text: 'Product 1', width: 6),
      PosColumn(text: '1', width: 2),
      PosColumn(text: '10.0', width: 4),
    ]);

    ticket.row([
      PosColumn(text: 'Product 2', width: 6),
      PosColumn(text: '2', width: 2),
      PosColumn(text: '5.0', width: 4),
    ]);

    ticket.feed(1);

    ticket.row([
      PosColumn(text: 'Total', width: 6),
      PosColumn(text: '', width: 2),
      PosColumn(text: '15.0', width: 4),
    ]);

    ticket.feed(2);

    ticket.text('Thank you!', styles: PosStyles(align: PosAlign.center, bold: true));

    return ticket;
  }
}
