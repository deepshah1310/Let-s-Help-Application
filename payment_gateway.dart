import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'constants.dart';

class PaymentGateway extends StatefulWidget {
  const PaymentGateway({Key? key}) : super(key: key);

  @override
  PaymentGatewayState createState() => PaymentGatewayState();
}

class PaymentGatewayState extends State<PaymentGateway> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController amount = TextEditingController();

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    initializeRazorPay();
  }

  void initializeRazorPay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void launchRazorPay() {
    int amountToPay = int.parse(amount.text) * 100;

    var options = {
      'key': 'rzp_test_8CtrBagzhPxplI',
      'amount': "$amountToPay",
      'name': name.text,
      'prefill': {'contact': phoneNo.text, 'email': email.text}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Sucessful");

    print(
        "${response.orderId} \n${response.paymentId} \n${response.signature}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed");

    print("${response.code}\n${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("Payment Failed");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xFFB2DFDB),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Payments"),
        ),
        body: SafeArea(
          child:
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color(0xFFB2DFDB),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      4.0,
                      4.0,
                    ),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Enter your name',
                      prefixIcon: Icon(Icons.person),
                      enabledBorder: kEnabledBorder,
                      focusedBorder: kFocusedBorder,
                      errorBorder: kErrorBorder,
                      focusedErrorBorder: kErrorBorder,
                    ),
                    onTap: () {
                    },
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: kEnabledBorder,
                      focusedBorder: kFocusedBorder,
                      errorBorder: kErrorBorder,
                      focusedErrorBorder: kErrorBorder,
                    ),
                    onTap: () {
                    },
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: phoneNo,
                    decoration: InputDecoration(
                      labelText: 'Enter your phone no.',
                      prefixIcon: Icon(Icons.phone),
                      enabledBorder: kEnabledBorder,
                      focusedBorder: kFocusedBorder,
                      errorBorder: kErrorBorder,
                      focusedErrorBorder: kErrorBorder,
                    ),
                    onTap: () {
                    },
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone no.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: amount,
                    decoration: InputDecoration(
                      labelText: 'Enter the amount you want to send',
                      prefixIcon: Icon(Icons.account_balance_wallet),
                      enabledBorder: kEnabledBorder,
                      focusedBorder: kFocusedBorder,
                      errorBorder: kErrorBorder,
                      focusedErrorBorder: kErrorBorder,
                    ),
                    onTap: () {
                    },
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the amount you want to send';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: kInputSpacing,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Colors.black,
                      textColor: Colors.white,
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      onPressed: launchRazorPay,
                      child: Text(
                        'SEND',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

        ),
      );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}