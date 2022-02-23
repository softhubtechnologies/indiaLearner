import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:get/get.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/AppStrings.dart';
import 'package:india_learner/utils/database.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  String amount, duration, planId;

  PaymentScreen({this.amount, this.duration, this.planId});

  PaymentScreenState createState() => PaymentScreenState(amount: amount, duration: duration, planId: planId);
}

class PaymentScreenState extends State<PaymentScreen> {
  String categoryName, subcategoryName, amount, duration, planId;
  var _razorpay = Razorpay();

  PaymentScreenState({this.amount, this.duration, this.planId});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryName = Database.getSelectedCategory();
    subcategoryName = Database.getSubcategory();
    initPaymentCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black87,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Payment', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text.rich(
              TextSpan(
                  text: 'Your selected category: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '' + categoryName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                  text: 'Selected Subcategory: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '' + subcategoryName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                  text: 'Amount: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '' + amount,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text.rich(
              TextSpan(
                  text: 'Course Duration: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '' + duration,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: SizedBox(
                    height: 40,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      onPressed: () {
                        openCheckout();
                      },
                      color: Colors.cyan,
                      child: Text(
                        'Pay',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  void _restartApp() async {
    FlutterRestart.restartApp();
  }

  void initPaymentCallbacks() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  _handlePaymentSuccess(response) {
    Database.saveSubscribitionPlan(amount, duration);
    Repository.subscribe(planName: duration, plan_id: planId, payment_id: "RZP9075167");

    _restartApp();
  }

  _handlePaymentError() {
    /*_restartApp();
    Database.saveSubscribitionPlan(amount, duration);
    Repository.subscribe(planName: duration);*/
  }

  _handleExternalWallet() {}

  void openCheckout() {
    var options = {
      "key": "rzp_live_kVQQ6TdfGZyXPa",
      "amount": int.parse(amount.replaceAll(new RegExp(r'[^\w\s]+'), '')) * 100,
      "name": "India learner",
      "description": AppSrings.appQuote,
      "prefill": {
        "contact": null,
        "email": "",
      },
      "external": {
        "wallet": ["paytm"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }
}
