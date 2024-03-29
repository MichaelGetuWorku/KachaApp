import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kacha/component/activities_screen/activities_loading.dart';
import 'package:kacha/screens/over_due_payment_screen.dart';
import 'package:kacha/screens/payment_screen.dart';
import 'package:kacha/screens/profile_screen.dart';
import 'package:kacha/screens/receipt_screen.dart';
import 'package:kacha/screens/utility_pay_screen.dart';
import 'package:kacha/state/user_state.dart';
import 'package:kacha/utils/custom_date_grouping.dart';
import 'package:kacha/utils/display_error_alert.dart';
import 'package:provider/provider.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  HomeDashboardScreenState createState() => HomeDashboardScreenState();
}

class HomeDashboardScreenState extends State<HomeDashboardScreen> {
  List<dynamic> allTransactions = [];
  late List<Map<String, dynamic>> response;
  Map<String, dynamic>? error = null;
  late User _user;
  int balance = 0;
  String name = '';
  List overduePayments = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchUserData() async {
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(_user.uid).get();
    Map<String, dynamic>? userData =
        userSnapshot.data() as Map<String, dynamic>?;
    // Update the user data directly
    setState(() {
      balance = userData?['balance'] ?? 0;
      name = userData?['name'] ?? '';
      overduePayments = userData?['overduePayments'];
    });
    print('Over Due payments 1: ${userData?['overduePayments']}');
  }
  Future<void> _refreshData() async {
    fetchUserData();
  }


  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
      fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserData>(context).user;

    List<Widget> dashboardActions = [
      GestureDetector(
        onTap: goToWalletScreen,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 18, 44, 82),
            radius: 26,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      )
    ];
    List<Widget> dashboardContents = [
      Container(
          height: 240,
          width: double.infinity,
          decoration: const BoxDecoration(
            // color: Color(0xFF0070BA),
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(36),
            ),
          )),
      Positioned(
        left: -156,
        top: -96,
        child: Opacity(
          opacity: 0.16,
          child: Image.asset(
            "assets/images/blob.png",
            color: Colors.white,
            height: 480,
          ),
        ),
      ),
      Positioned(
        bottom: 20,
        left: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $name',
                style: const TextStyle(
                  // color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "\$ $balance",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.96),
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 6.18,
              ),
              const Text(
                "Your balance",
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
        ),
      )
    ];
    List<Widget> transactionButtons = <Widget>[
      Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // Pass the Send Money or Request Money var
                  builder: (context) => const PaymentScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              // primary: Color(0xFF0070BA),
              backgroundColor: const Color(0xff1546A0),
              // fixedSize: Size(90, 100),
              fixedSize: const Size(120, 108),
              shadowColor: const Color(0xFF0070BA).withOpacity(0.618),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.file_upload_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  "Send Money",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // Pass the Send Money or Request Money var
                  builder: (context) => const UtilityPayScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              // primary: Color(0xFF0070BA),
              backgroundColor: const Color(0xff1546A0),
              // fixedSize: Size(90, 100),
              fixedSize: const Size(120, 108),
              shadowColor: const Color(0xFF0070BA).withOpacity(0.618),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.payment,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  "Utility Payment",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )),
      ),
    ];

    List<Widget> homeScreenContents = <Widget>[
      Stack(
        children: dashboardContents,
      ),
      Container(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: transactionButtons,
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 150,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Text(
                      "Over Due Payments",
                      style: TextStyle(fontSize: 21, color: Color(0xff243656)),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 145,
                  child: Builder(builder: _buildOverdueTransactionActivities),
                ),
              )
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 150,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Text(
                      "Activity",
                      style: TextStyle(fontSize: 21, color: Color(0xff243656)),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 145,
                  child: Builder(builder: _buildTransactionActivities),
                ),
              )
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 253, 253, 253),
      backgroundColor: const Color(0xfffcfcfc),
      appBar: AppBar(
        actions: dashboardActions,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: homeScreenContents,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionActivities(BuildContext context) {
    String jsonContent = '''
[
    {
    "id": 1,
    "name": "Salary Deposit",
    "date": "2022-12-12",
    "type": "Credit",
    "amount": "1000"
  },
  {
    "id": 2,
    "name": "Grocery Shopping",
    "date": "2023-01-01",
    "type": "Debit",
    "amount": "100"

  },
  {
    "id": 3,
    "name": "Online Purchase",
    "date": "2023-02-15",
    "type": "Debit",
        "amount": "70"

  },
  {
    "id": 4,
    "name": "Bonus Received",
    "date": "2023-03-05",
    "type": "Credit",
        "amount": "10"

  },
   {
    "id": 6,
    "name": "ATM Withdrawal",
    "date": "2022-12-12",
    "type": "Debit",
        "amount": "500"

  },
  {
    "id": 7,
    "name": "Gas Payment",
    "date": "2023-01-01",
    "type": "Debit",
        "amount": "7000"

  },
  {
    "id": 8,
    "name": "DSTV",
    "date": "2023-02-15",
    "type": "Debit",
        "amount": "900"

  },
  {
    "id": 9,
    "name": "Gift Package",
    "date": "2023-03-05",
    "type": "Credit",
        "amount": "800"

  }
]
''';

    List<Map<String, dynamic>> transactions =
        List<Map<String, dynamic>>.from(json.decode(jsonContent));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.separated(
        padding: const EdgeInsets.all(0),
        separatorBuilder: (_, b) => const Divider(
          height: 14,
          color: Colors.transparent,
        ),
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          var transaction = transactions[index];

          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xff1546a0).withOpacity(0.1),
                  blurRadius: 48,
                  offset: const Offset(2, 8),
                  spreadRadius: -16,
                ),
              ],
              color: Colors.white,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                left: 0,
                top: 0,
                bottom: 0,
                right: 6.18,
              ),
              leading: const CircleAvatar(
                radius: 38,
                backgroundColor: Color.fromARGB(255, 18, 44, 82),
                child: Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              title: Text(
                transaction['name'],
                style:
                    const TextStyle(fontSize: 16.5, color: Color(0xff243656)),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  transaction['date'],
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xff929BAB)),
                ),
              ),
              trailing: Text(
                transaction['type'],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: transaction['type'] == 'Credit'
                      ? const Color(0xff37d39b)
                      : const Color(0xffe84545),
                ),
              ),
              onTap: () => _viewAllActivities(
                transaction['amount'],
                transaction['name'],
                transaction['type'],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverdueTransactionActivities(BuildContext context) {
    List transactions = overduePayments;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.separated(
        padding: const EdgeInsets.all(0),
        separatorBuilder: (_, b) => const Divider(
          height: 14,
          color: Colors.transparent,
        ),
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          var transaction = transactions[index];

          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xff1546a0).withOpacity(0.1),
                  blurRadius: 48,
                  offset: const Offset(2, 8),
                  spreadRadius: -16,
                ),
              ],
              color: Colors.white,
            ),
            child: ListTile(
                contentPadding: const EdgeInsets.only(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  right: 6.18,
                ),
                leading: const CircleAvatar(
                  radius: 38,
                  backgroundColor: Color.fromARGB(255, 18, 44, 82),
                  child: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                title: Text(
                  transaction['name'],
                  style:
                      const TextStyle(fontSize: 16.5, color: Color(0xff243656)),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    transaction['date'],
                    style:
                        const TextStyle(fontSize: 12, color: Color(0xff929BAB)),
                  ),
                ),
                trailing: Text(
                  transaction['overDue'] == true ? 'Not Payed' : 'Payed',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: transaction['overDue'] == true
                        ?  const Color(0xffe84545)
                        : const Color(0xff37d39b),
                  ),
                ),
                onTap: () {
                  transaction['overDue'] == true
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return OverDuePaymentScreen(
                              billName: transaction['name'],
                              amount: transaction['amount'],
                            );
                          },
                        ))
                      : null;
                }),
          );
        },
      ),
    );
  }

  void goToWalletScreen() {
    // widget.setTab(3);
    // Provider.of<TabNavigationProvider>(context, listen: false).updateTabs(0);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  void _viewAllActivities(
    String amount,
    String number,
    String type,
  ) {
    // Provider.of<TabNavigationProvider>(context, listen: false).updateTabs(0);
    // widget.setTab(2);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => TransactionReceiptScreen(
        amount: amount,
        phoneNumber: number,
        type: type,
      ),
    ));
  }
}
