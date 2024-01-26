import 'package:flutter/material.dart';
import 'package:kacha/screens/receipt_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String errorMessage1 = "";
  String errorMessage2 = "";
  String userInput = "";
  String password = "";

  void errorMessageSetter(int fieldNumber, String message) {
    setState(() {
      if (fieldNumber == 1) {
        errorMessage1 = message;
      } else {
        errorMessage2 = message;
      }
    });
  }

  void tryLoggingIn() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => TransactionReceiptScreen(
          phoneNumber: userInput,
          amount: password,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Image.asset(
                    'assets/images/piggy-bank.png',
                    scale: 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: Color(0xFFF5F7FA)),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 6.18,
                      spreadRadius: 0.618,
                      offset: Offset(-4, -4),
                      // color: Colors.white38
                      color: Color(0xFFF5F7FA),
                    ),
                    BoxShadow(
                        blurRadius: 6.18,
                        spreadRadius: 0.618,
                        offset: const Offset(4, 4),
                        color: Colors.blueGrey.shade100
                        // color: Color(0xFFF5F7FA)
                        )
                  ],
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      errorMessageSetter(1, 'You must provide a phone number');
                    } else {
                      errorMessageSetter(1, "");

                      setState(() {
                        userInput = value;
                      });
                    }

                    return null;
                  },
                  autocorrect: false,
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Phone Number",
                    hintStyle:
                        TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
                  ),
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF929BAB)),
                  keyboardType: TextInputType.phone,
                ),
              ),
              if (errorMessage1 != '')
                Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    "\t\t\t\t$errorMessage1",
                    style: const TextStyle(fontSize: 10, color: Colors.red),
                  ),
                ),
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Color(0xFFF5F7FA)),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      const BoxShadow(
                          // blurRadius: 6.18,
                          spreadRadius: 0.618,
                          blurRadius: 6.18,
                          // spreadRadius: 6.18,
                          offset: Offset(-4, -4),
                          // color: Colors.white38
                          color: Color(0xFFF5F7FA)),
                      BoxShadow(
                          blurRadius: 6.18,
                          // spreadRadius: 6.18,
                          spreadRadius: 0.618,
                          offset: const Offset(4, 4),
                          color: Colors.blueGrey.shade100
                          // color: Color(0xFFF5F7FA)
                          )
                    ]),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => _validateLoginDetails(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      errorMessageSetter(
                        2,
                        'Amount is Empty',
                      );
                    } else {
                      errorMessageSetter(2, "");
                      setState(() {
                        password = value;
                      });
                    }
                    return null;
                  },
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: 15,
                      bottom: 11,
                      top: 11,
                      right: 15,
                    ),
                    hintText: "Amount",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF929BAB),
                    ),
                  ),
                ),
              ),
              if (errorMessage2 != '')
                Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    "\t\t\t\t$errorMessage2",
                    style: const TextStyle(fontSize: 10, color: Colors.red),
                  ),
                ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                width: double.infinity,
                height: 64,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey.shade100,
                        offset: const Offset(0, 4),
                        blurRadius: 5.0)
                  ],
                  gradient: const RadialGradient(
                      colors: [Color(0xff0070BA), Color(0xff1546A0)],
                      radius: 8.4,
                      center: Alignment(-0.24, -0.36)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: _validateLoginDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    // TODO: Change it depending on the request
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_rounded,
        ),
      ),
    );
  }

  void _validateLoginDetails() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState!.validate()) {
      if (errorMessage1 != "" || errorMessage2 != "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please provide all required details'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // _formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              onVisible: tryLoggingIn,
              content: const Text('Processing...'),
              backgroundColor: Colors.blue),
        );
      }
    }
  }
}
