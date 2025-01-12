import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentScreen extends StatefulWidget {
  @override
  _RazorpayPaymentScreenState createState() => _RazorpayPaymentScreenState();
}

class _RazorpayPaymentScreenState extends State<RazorpayPaymentScreen> {
  late Razorpay _razorpay;
  final Color customColor = Color(0xFF11151E);


  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _startPayment(); // Start the payment process immediately
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment successful!");
    Navigator.pop(context); // Close the screen after success
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment failed: ${response.message ?? 'Unknown error'}");
    Navigator.pop(context); // Close the screen after failure
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet Selected: ${response.walletName}");
    Navigator.pop(context); // Close the screen after wallet selection
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_Q5B3VbaftPZRgh', // Razorpay test key
      'amount': 500, // Amount in smallest currency unit (₹5.00 = 500)
      'name': 'Recipe App',
      'description': 'Ad-Free Premium Experience',
      'prefill': {
        'contact': '8888888888', // Customer phone
        'email': 'test@razorpay.com' // Customer email
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor,
      body: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
          strokeWidth: 7.0,
        ), // Display a loading indicator
      ),
    );
  }
}
