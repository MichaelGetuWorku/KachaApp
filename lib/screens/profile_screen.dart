import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kacha/state/user_state.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  // final Function setTab;
  // final Map<String, dynamic> user;
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserData>(context).user;
    Widget walletScreenDashBoard = Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 224, width: double.infinity,
          //  color: Color(0xFF0070BA)
          color: const Color(0xff1546A0),
        ),
        SizedBox(
          height: 224,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  left: -156,
                  top: -96,
                  child: Opacity(
                    opacity: 0.16,
                    child: Image.asset(
                      "assets/images/hadwin_system/magicpattern-blob-1652765120695.png",
                      color: Colors.white,
                      height: 480,
                    ),
                  ))
            ],
          ),
        ),
        const Positioned(
          // top: 128,
          bottom: -60,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 64,
            child: Icon(
              Icons.person,
              size: 120,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
    //? STORES INFORMATION ABOUT THE USER
    Widget userInfo = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(children: [
        const Row(
          children: [
            Text("Personal Info", style: TextStyle(color: Color(0xff929BAB)))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'NAME',
              style: TextStyle(color: Color(0xff243656), fontSize: 15),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                '${user!.displayName}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff243656),
                    fontSize: 15),
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "E-mail",
              style: TextStyle(color: Color(0xff243656), fontSize: 15),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                '${user.email}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff243656),
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Phone",
              style: TextStyle(color: Color(0xff243656), fontSize: 15),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                '+251940-082280',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff243656),
                    fontSize: 15),
              ),
            )
          ],
        ),
      ]),
    );

    Widget myBankingCards = Expanded(
      child: Container(
          height: 100,
          padding: const EdgeInsets.symmetric(
            // horizontal: 18,
            vertical: 10,
          ),
          color: const Color.fromARGB(255, 220, 219, 219),
          child: Builder(
            builder: _buildAvailableCards,
          )),
    );

    Widget walletScreenContents = Column(
      children: [
        walletScreenDashBoard,
        const SizedBox(
          height: 60,
        ),
        userInfo,
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Row(
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(color: Color(0xff929BAB)),
              ),
            ],
          ),
        ),
        myBankingCards,
      ],
    );

    return Scaffold(
        backgroundColor: const Color(0xfffdfdfd),
        //  backgroundColor: Color(0xfffcfcfc),
        appBar: AppBar(
          leading: IconButton(
            onPressed: goBackToLastTabScreen,
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            "My Wallet",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   SlideRightRoute(
                  //     page: NewSettingsScreen(),
                  //   ),
                  // ).then(
                  //   (value) => setState(
                  //     () {},
                  //   ),
                  // );
                },
                icon: const Icon(FluentIcons.settings_28_regular),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: walletScreenContents,
          )
        ]));
  }

  void goToAddCardScreen() {
    // Navigator.push(context, SlideRightRoute(page: AddCardScreen()))
    //     .then((value) {
    //   setState(() {});
    // });
  }

  Widget _buildAvailableCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.separated(
        padding: const EdgeInsets.all(0),
        separatorBuilder: (_, b) => const Divider(
          height: 14,
          color: Colors.transparent,
        ),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: const Color(0xff1546a0).withOpacity(0.1),
                    blurRadius: 48,
                    offset: const Offset(2, 8),
                    spreadRadius: -16),
              ],
              color: Colors.white,
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.only(
                left: 0,
                top: 0,
                bottom: 0,
                right: 6.18,
              ),
              leading: CircleAvatar(
                radius: 38,
                backgroundColor: Color.fromARGB(255, 18, 44, 82),
                child: Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              // ignore: prefer_const_constructors
              title: Text(
                'Transaction Name',
                style: TextStyle(fontSize: 16.5, color: Color(0xff243656)),
              ),
              subtitle: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  '12/12/2022',
                  style: TextStyle(fontSize: 12, color: Color(0xff929BAB)),
                ),
              ),
              trailing: Text(
                "Credit",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff37d39b),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //? FUNCTION FOR FORMATTING CARD NUMBER
  String _formatCardNumber(String currentCardNumber, {bool encrypt = true}) {
    String formattedCardNumber = "";
    String cardCopy = currentCardNumber;
    cardCopy = cardCopy.replaceAll(' ', '');
    if (encrypt) {
      cardCopy = cardCopy[0] +
          '*' * (cardCopy.length - 6) +
          cardCopy.substring(cardCopy.length - 5);
    }
    if (RegExp(r'^3[47]').hasMatch(currentCardNumber)) {
      for (var i = 0; i < cardCopy.length; i++) {
        formattedCardNumber += cardCopy[i];
        if (i == 3 || i == 9) {
          formattedCardNumber += ' ';
        }
      }
    } else {
      for (var i = 0; i < cardCopy.length; i++) {
        formattedCardNumber += cardCopy[i];
        if ((i + 1) % 4 == 0) {
          formattedCardNumber += ' ';
        }
      }
    }
    return formattedCardNumber.trim();
  }

  void goBackToLastTabScreen() {
    // int lastTab =
    //     Provider.of<TabNavigationProvider>(context, listen: false).lastTab;
    // Provider.of<TabNavigationProvider>(context, listen: false).removeLastTab();
    // widget.setTab(lastTab);
    Navigator.of(context).pop();
  }

  void _deleteCardDialogBox(String cardNumber) {
    Decoration buttonDecoration = BoxDecoration(
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
      borderRadius: BorderRadius.circular(10),
    );
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: Colors.transparent,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text(
                "Delete Card?",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Are you sure, you want to delete Card with number\n${_formatCardNumber(cardNumber, encrypt: false)}?",
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 48,
                          width: 100,
                          decoration: buttonDecoration,
                          child: ElevatedButton(
                              onPressed: () => _deleteSelectedCard(cardNumber),
                              style: buttonStyle,
                              child: const Text('Delete')),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Container(
                          height: 48,
                          width: 100,
                          decoration: buttonDecoration,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: buttonStyle,
                              child: const Text('Cancel')),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ));
  }

  Future<void> _deleteSelectedCard(String cardNumber) async {
    // bool cardDeletionStatus = await availableCards.deleteCard(cardNumber);
    // if (cardDeletionStatus) {
    //   setState(() {});
    //   Navigator.of(context).pop();
    // } else {
    //   Navigator.of(context).pop();
    // }
  }
}
