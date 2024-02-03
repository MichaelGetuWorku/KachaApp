import 'package:flutter/material.dart';
import 'package:kacha/screens/receipt_screen.dart';

class UtilityPayScreen extends StatefulWidget {
  const UtilityPayScreen({super.key});

  @override
  State<UtilityPayScreen> createState() => _UtilityPayScreenState();
}

class _UtilityPayScreenState extends State<UtilityPayScreen> {
  final _formKey = GlobalKey<FormState>();
  String errorMessage1 = "";
  String errorMessage2 = "";
  String userInput = "";
  String password = "";

  String? _selectedOption;

  final List<String> _options = [
    'DSTV Subscription',
    'Addis Park',
    'Friendship Squarer Park',
    'National Museum',
  ];

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
          phoneNumber: _selectedOption!,
          amount: password,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedOption = _options.isNotEmpty ? _options[0] : '';
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedOption,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedOption = newValue;
                          // Todo : User the newValue Result
                        });
                      }
                    },
                    items:
                        _options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1.0, color: const Color(0xFFF5F7FA)),
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
                  keyboardType: TextInputType.number,
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
                    'Pay',
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
      if (errorMessage2 != "") {
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
