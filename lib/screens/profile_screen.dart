import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  // final Function setTab;
  // final Map<String, dynamic> user;
  final User user;
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<ProfileScreen> {
  late User _currentUser;
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: ClipOval(
                  // child: Image.network(
                  //   "${ApiConstants.baseUrl}/dist/images/hadwin_images/hadwin_users/${widget.user['gender'].toLowerCase()}/${widget.user['avatar']}",
                  //   height: 120,
                  //   width: 120,
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ))
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
              style: const TextStyle(color: Color(0xff243656), fontSize: 15),
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              child: Text(
                '${_currentUser.displayName}',
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
                '  ${_currentUser.email}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff243656),
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
        Row(
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
        padding: const EdgeInsets.symmetric(horizontal: 28),
        color: Colors.red,
        // child: FutureBuilder<Map<String, dynamic>>(
        //   future: availableCards.readAvailableCards(),
        //   builder: _buildAvailableCards,
        // ),
      ),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Row(
            children: [
              const Text(
                "My Cards",
                style: TextStyle(color: Color(0xff929BAB)),
              ),
              const Spacer(),
              InkWell(
                  onTap: goToAddCardScreen,
                  child: const Text(
                    "+ Add",
                    style: TextStyle(color: Color(0xff929BAB)),
                  ))
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
              icon: const Icon(Icons.arrow_back)),
          title: const Text("My Wallet"),
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
                    icon: const Icon(FluentIcons.settings_28_regular)))
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

  Widget _buildAvailableCards(
      BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
    List<dynamic> cardData = [];
    if (snapshot.hasData) {
      cardData = snapshot.data!['availableCards'];

      return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemBuilder: (_, index) => Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  /*
                  color: Color(0xffF5F7FA),
                  blurRadius: 4,
                  offset: Offset(0.0, 3),
                  spreadRadius: 0
                  */
                  color: const Color(0xff1546a0).withOpacity(0.1),
                  blurRadius: 48,
                  offset: const Offset(2, 8),
                  spreadRadius: -16),
            ],
            color: Colors.white,
          ),
          child: ListTile(
            onTap: () => _deleteCardDialogBox(cardData[index]['cardNumber']),
            contentPadding:
                const EdgeInsets.only(left: 12, top: 0, right: 0, bottom: 0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6.18),
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xff243656),
                  BlendMode.color,
                ),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.saturation,
                  ),
                  child: Container(
                    color: Colors.white,
                    // child: Image.network(
                    //   "${ApiConstants.baseUrl}/dist/images/hadwin_images/hadwin_payment_system/square_card_brands/${cardData[index]['cardBrand'].replaceAll(' ', '-').toLowerCase()}.png",
                    //   width: 48,
                    //   height: 48,
                    // ),
                  ),
                ),
              ),
            ),
            title: Text(
              cardData[index]['cardBrand'],
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xff243656),
                  fontSize: 16.5),
            ),
            subtitle: Text(
              _formatCardNumber(cardData[index]['cardNumber']),
              style: const TextStyle(fontSize: 13, color: Color(0xff929BAB)),
            ),
          ),
        ),
        separatorBuilder: (_, b) => const Divider(
          height: 14,
          color: Colors.transparent,
        ),
        itemCount: cardData.length,
      );
    } else {
      // return availableCardsLoadingList(5);
      return const Text('Hello, ');
    }
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
