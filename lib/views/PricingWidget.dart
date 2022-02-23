import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/PlansBloc.dart';
import 'package:india_learner/models/plans_model.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/PaymentScreen.dart';

class PricingWidget extends StatefulWidget {
  PricingWidgetState createState() => PricingWidgetState();
}

class PricingWidgetState extends State<PricingWidget> {
  int indexQue;
  String amount, duration, planId;

  List<String> list = [
    '01 mo',
    '03 mo',
    '06 mo',
    '12 mo',
    '24 mo',
  ];
  List<String> listPrice = [
    '5000',
    '10,000',
    '15,000',
    '20,0000',
    '30,0000',
  ];

  @override
  Widget build(BuildContext context) {
    plansBloc.getPlans();
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
        title: Text('Select plan', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      bottomNavigationBar: Container(
        width: Get.size.width,
        child: SizedBox(
          height: 50,
          child: RaisedButton(
            onPressed: () {
              if (indexQue != null) {
                Get.to(PaymentScreen(
                  amount: amount,
                  duration: duration,
                  planId: planId,
                ));
              } else {
                ToastMessage.showToast(message: "Please select atleast one plan", type: false);
              }
            },
            color: Colors.cyan,
            child: Text(
              'Continue',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: Get.size.height,
          width: Get.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 16,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 200,
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "India learner course subscription",
                    style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: StreamBuilder(
                      stream: plansBloc.streamPlans,
                      builder: (context, AsyncSnapshot<PlansModel> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(top: 46),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        indexQue = index;
                                        amount = snapshot.data.planList[index].price;
                                        duration = snapshot.data.planList[index].planName;
                                        planId = snapshot.data.planList[index].id;
                                      });
                                    },
                                    leading: Container(
                                      height: 120,
                                      width: 100,
                                      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.6), border: Border.all(width: indexQue == index ? 3 : 0, color: indexQue == index ? Colors.cyan : Colors.white), borderRadius: BorderRadius.circular(3)),
                                      child: Center(
                                        child: Text(
                                          snapshot.data.planList[index].planName,
                                          style: TextStyle(fontSize: 16, color: indexQue != index ? Colors.black87.withOpacity(0.6) : Colors.cyan, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "₹ " + snapshot.data.planList[index].price + "/ "
                                      /*"₹ 5,000/ month"*/,
                                      style: TextStyle(fontSize: 20, color: indexQue != index ? Colors.black87.withOpacity(0.6) : Colors.cyan, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              });
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return Utils.loader;
                        } else {
                          return Utils.noData;
                        }
                      },
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
