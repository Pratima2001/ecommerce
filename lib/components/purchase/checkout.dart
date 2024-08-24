import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce1/commonwidget/animatedButton.dart';
import 'package:ecommerce1/data/models/userModule.dart';
import 'package:ecommerce1/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../commonwidget/allWidgets.dart';
import 'payment.dart';

class CheckOut extends ConsumerStatefulWidget {
  List products = [];

  CheckOut({super.key, required this.products});

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends ConsumerState<CheckOut> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool isProcessing = false;
  bool isCompleted = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    final documentRef =
        FirebaseFirestore.instance.collection("users").doc(uuid);
    final DocumentSnapshot docSnapshot = await documentRef.get();

    Map<String, dynamic> mapData = docSnapshot.data() as Map<String, dynamic>;
    if (mapData.containsKey("Address")) {
      _fnameController.text = mapData['fname'];
      _lnameController.text = mapData['lname'];
      _streetController.text = mapData['street'];
      _zipCodeController.text = mapData['zipCode'];
      _cityController.text = mapData['city'];
      _addressController.text = mapData['Address'];
      _phoneNumberController.text = mapData['phoneNumber'];
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      bool status = await saveUserInfo(UserModule(
          name: _fnameController.text,
          uid: uuid,
          email: '',
          fname: _fnameController.text,
          lname: _lnameController.text,
          street: _streetController.text,
          city: _cityController.text,
          phoneNumber: _phoneNumberController.text,
          zipCode: _zipCodeController.text,
          address: _addressController.text));
      if (status) {
        await addTransactReceipt(widget.products);
        setState(() {
          isProcessing = false;
          isCompleted = true;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentScreen(),
            ));
      }
    } else {
      setState(() {
        isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedButton(
                  onTap: () {
                    // if (!isProcessing) {
                    setState(() {
                      isProcessing = true;
                      _submitForm();
                    });
                    // }
                  },
                  isCompleted: isCompleted,
                  isProcessing: isProcessing)
            ],
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  child: Form(
                    key: _formKey,
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
                        TextFormField(
                          controller: _fnameController,
                          style: GoogleFonts.roboto(),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.aBeeZee(),
                            hintText: "First Name*",
                            border: const UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _lnameController,
                          style: GoogleFonts.roboto(),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.aBeeZee(),
                            hintText: "Last Name*",
                            border: const UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _streetController,
                          style: GoogleFonts.roboto(),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.aBeeZee(),
                            hintText: "Street*",
                            border: const UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your street';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _cityController,
                          style: GoogleFonts.roboto(),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.aBeeZee(),
                            hintText: "City*",
                            border: const UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your city';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _phoneNumberController,
                          style: GoogleFonts.roboto(),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.aBeeZee(),
                            hintText: "Phone Number*",
                            border: const UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _zipCodeController,
                          style: GoogleFonts.roboto(),
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.aBeeZee(),
                            hintText: "Zip Code*",
                            border: const UnderlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your zip code';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _addressController,
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            hintText: "Enter Address",
                            hintStyle: GoogleFonts.aBeeZee(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      )),
    );
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
