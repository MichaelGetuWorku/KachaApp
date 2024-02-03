import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionReceiptScreen extends StatelessWidget {
  final String phoneNumber;
  final String amount;
  final String? type;
  TransactionReceiptScreen({
    Key? key,
    required this.phoneNumber,
    required this.amount,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
// double screenWidth=360;

    TextStyle _receiptHeaders = GoogleFonts.lato(
        color: const Color(0xff929bab), fontSize: screenWidth < 380 ? 14 : 16);
    TextStyle _receiptValues = GoogleFonts.chivo(
        fontSize: screenWidth < 380 ? 15 : 19,
        color: const Color(0xff343a40),
        fontWeight: FontWeight.bold);

    return Scaffold(
        backgroundColor: Colors.blueGrey.shade300,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [const Color(0xff495057), Colors.blueGrey.shade300],
                  radius: 0.625),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 72,
                ),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    ClipPath(
                      clipper: ReceiptClipper(),
                      child: Container(
                        // height: MediaQuery.of(context).size.height -36,
                        height: 618,
                        width: screenWidth - 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Positioned(
                        top: -36,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 39,
                          child: CircleAvatar(
                            child: Image.asset(
                              'assets/images/checkmark.png',
                            ),
                            radius: 36,
                          ),
                        )),

                    Positioned(
                      top: 155,
                      child: DottedLine(
                        direction: Axis.horizontal,
                        lineLength: screenWidth - 120,
                        lineThickness: 2.4,
                        dashLength: 12,
                        dashColor: Colors.grey.shade500,
                        dashRadius: 0.0,
                        dashGapLength: 3.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                    ),

                    //? RECEIPT HEADER ↴
                    Positioned(
                        top: 70,
                        child: Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 3.6,
                          children: [
                            Text(
                              'Congratulations!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.heebo(
                                fontSize: 24,
                                color: const Color(0xff343a40),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Your transaction was successful',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.sarabun(
                                color: const Color(0xff929bab),
                              ),
                            )
                          ],
                        )),

                    //? RECEIPT BODY ↴
                    Positioned(
                        top: 200,
                        child: Container(
                          width: screenWidth - 120,
                          color: Colors.transparent,
                          child: Wrap(
                            direction: Axis.vertical,
                            spacing: 24,
                            children: [
                              //? DATE AND TIME OF TRANSACTION ↴
                              Container(
                                width: screenWidth - 120,
                                color: Colors.transparent,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.vertical,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      spacing: 3.6,
                                      children: [
                                        Text('DATE', style: _receiptHeaders),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.4,
                                          child: Text(
                                            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                                            style: _receiptValues,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //? INFO AND SENDER OR RECEIPIENT ↴
                              Container(
                                width: screenWidth - 120,
                                color: Colors.transparent,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.vertical,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      spacing: 3.6,
                                      children: [
                                        Text('TO', style: _receiptHeaders),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.4,
                                          child: Text(
                                            phoneNumber,
                                            style: _receiptValues,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //? TRANSACTION AMOUNT ---  ↔  --- TRANSACTION STATUS ↴
                              Container(
                                width: screenWidth - 120,
                                color: Colors.transparent,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.vertical,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.start,
                                      spacing: 3.6,
                                      children: [
                                        Text('AMOUNT', style: _receiptHeaders),
                                        Text(
                                          '\$ $amount',
                                          style: GoogleFonts.oswald(
                                              fontSize: 32,
                                              color: const Color(0xff343a40),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      direction: Axis.vertical,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.end,
                                      spacing: 3.6,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(7.2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xff76c893)),
                                              borderRadius:
                                                  BorderRadius.circular(6.18)),
                                          child: Text(
                                            'COMPLETED',
                                            style: GoogleFonts.quicksand(
                                                color: const Color(0xff76c893),
                                                fontSize: 12.84),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                      bottom: 14,
                      child: Container(
                          height: 100,
                          width: screenWidth - 96,
                          decoration: BoxDecoration(
                              color: const Color(0xffbde0fe).withOpacity(0.618),
                              borderRadius: BorderRadius.circular(7)),
                          // child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Builder(
                            builder: _financialInstrumentsBuilder,
                          )
                          // ),
                          ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: Colors.white24,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 48,
                )
              ],
            ),
          ),
        ));
  }

  String _formatCardBrandName(String brand) {
    String formattedVersion = brand
        .toLowerCase()
        .split(' ')
        .map((e) => "${e[0].toUpperCase()}${e.substring(1)}")
        .toList()
        .join(' ');
    return formattedVersion;
  }

  Widget _financialInstrumentsBuilder(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 12,
      runSpacing: 6.4,
      crossAxisAlignment: WrapCrossAlignment.center,
      runAlignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: [
        SizedBox(
          height: 72,
          child: Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Text(
                type == 'Credit' ? 'Credit' : 'Debit',
                style: GoogleFonts.roboto(
                    fontSize: screenWidth < 400 ? 16 : 18,
                    color: const Color(0xff343a40),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                type == 'Credit'
                    ? "\$ $amount added to your balance"
                    : "\$ $amount deducted from your balance",
                style: GoogleFonts.heebo(
                  fontSize: screenWidth < 400 ? 11 : 13,
                  color: const Color(0xff929bab),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  String _formatCardNumber(String cardNumber) {
    String formattedVersion = cardNumber.replaceAll(' ', '');
    int lastTwoPlaces = formattedVersion.length - 2;
    return "**${formattedVersion.substring(lastTwoPlaces)}";
  }

  String _formatParticipantName(String name) {
    String formattedVersion = name;
    if (name.length > 26) {
      formattedVersion = "${name.substring(0, 23)}...";
    }
    return formattedVersion;
  }
}

class ReceiptClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path
      ..lineTo(size.width, 0)
      ..lineTo(size.width, 140)
      ..cubicTo(size.width * .92, 140, size.width * .92, 170, size.width, 170)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 170)
      ..cubicTo(size.width * .08, 170, size.width * .08, 140, 0, 140)
      ..lineTo(0, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
