import 'package:flutter/material.dart';
import 'package:possmartnew/ui/home_screen.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _paymentMethod =
      'Pay on Delivery'; // Make the _paymentMethod nullable
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

// Method to show confirmation dialog for 'Pay on Delivery'
  void _showConfirmationDialog(String paymentMethod) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Payment'),
          content:
              Text('Are you sure you want to proceed with Pay on Delivery?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showThankYouMessage(paymentMethod);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

// Method to show thank you message for 'Cash' payment
  void _showThankYouMessage(String paymentMethod) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Thank you for choosing $paymentMethod!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

// Method to process 'Card' payment with entered card details
  void _processCardPayment(String cardNumber, String expiryDate, String cvv) {
    // Implement your card payment processing logic here
    // For demonstration purposes, we'll just show a simple success message
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Card Payment Successful'),
          content: Text(
              'Card Number: $cardNumber\nExpiry Date: $expiryDate\nCVV: $cvv'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            RadioListTile(
              title: Text('Pay on Delivery'),
              value: 'Pay on Delivery',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value;
                });
              },
            ),
            RadioListTile(
              title: Text('Cash'),
              value: 'Cash',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value;
                });
              },
            ),
            RadioListTile(
              title: Text('Card'),
              value: 'Card',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value;
                });
              },
            ),
            if (_paymentMethod == 'Card') ...[
              SizedBox(height: 20),
              Text(
                'Enter Card Details:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _cardNumberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateController,
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _cvvController,
                      decoration: InputDecoration(
                        labelText: 'CVV',
                      ),
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement payment processing logic here
                switch (_paymentMethod) {
                  case 'Pay on Delivery':
                    // Show confirmation dialog for 'Pay on Delivery'
                    _showConfirmationDialog('Pay on Delivery');
                    break;
                  case 'Cash':
                    // Show thank you message for 'Cash' payment
                    _showThankYouMessage('Cash');
                    break;
                  case 'Card':
                    // Use the entered card details for payment processing
                    String cardNumber = _cardNumberController.text;
                    String expiryDate = _expiryDateController.text;
                    String cvv = _cvvController.text;
                    _processCardPayment(cardNumber, expiryDate, cvv);
                    break;
                  default:
                    break;
                }
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaymentPage(),
  ));
}
