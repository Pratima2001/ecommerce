import 'package:ecommerce1/Pages/Purchase/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../commonwidget/allWidgets.dart';

class CheckOut extends ConsumerStatefulWidget {
  const CheckOut({super.key});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends ConsumerState<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  backArrow(context),
                  Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(right: 40),
                          alignment: Alignment.center,
                          child: Text(
                            "Check Out",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )))
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "STEP1",
                      style: GoogleFonts.aBeeZee(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Shipping",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      style: GoogleFonts.roboto(),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.aBeeZee(),
                          hintText: "First Name*",
                          border: const UnderlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: GoogleFonts.roboto(),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.aBeeZee(),
                          hintText: "Last Name*",
                          border: const UnderlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: GoogleFonts.roboto(),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.aBeeZee(),
                          hintText: "Street*",
                          border: const UnderlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: GoogleFonts.roboto(),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.aBeeZee(),
                          hintText: "City*",
                          border: const UnderlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      maxLines: 4, //or null
                      decoration: InputDecoration.collapsed(
                          border: UnderlineInputBorder(),
                          hintText: "Enter Address"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: GoogleFonts.roboto(),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.aBeeZee(),
                          hintText: "zip Code*",
                          border: const UnderlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: GoogleFonts.roboto(),
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.aBeeZee(),
                          hintText: "Phone Number*",
                          border: const UnderlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        // Razorpay razorpay = Razorpay();
                        // var options = {
                        //   'key': 'rzp_live_ILgsfZCZoFIKMb',
                        //   'amount': 100,
                        //   'name': 'Acme Corp.',
                        //   'description': 'Fine T-Shirt',
                        //   'retry': {'enabled': true, 'max_count': 1},
                        //   'send_sms_hash': true,
                        //   'prefill': {
                        //     'contact': '8888888888',
                        //     'email': 'test@razorpay.com'
                        //   },
                        //   'external': {
                        //     'wallets': ['paytm']
                        //   }
                        // };
                        // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                        //     handlePaymentErrorResponse);
                        // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                        //     handlePaymentSuccessResponse);
                        // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                        //     handleExternalWalletSelected);
                        // razorpay.open(options);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PaymentScreen()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff343434),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            "Continue to Payment",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    ));
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
