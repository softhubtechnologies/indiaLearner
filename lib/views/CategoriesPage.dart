import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/CategoriesModel.dart';
import 'package:india_learner/networking/ApiHandler.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/networking/EndApi.dart';
import 'package:india_learner/utils/AppStrings.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/SubcategoryPage.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPageState createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  List<CategoryList> listcategories = [];
  int indexTemp;
  String catId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Database.initDatabase();
    getJsonData();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: getBottomNav(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Select Category",
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
      body: Container(
        color: Colors.white.withOpacity(0.1),
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 14, right: 14),
          child: Column(
            children: [
              Expanded(
                  child: GridView.count(
//              shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: width / (height / 2.9),
                children: List.generate(listcategories.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        indexTemp = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white, boxShadow: [
                        BoxShadow(color: Colors.black12, offset: Offset(5.0, 0.5), blurRadius: 10.4, spreadRadius: 1.4),
                      ]),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Stack(
                            children: [
                              Container(
                                  decoration: BoxDecoration(color: indexTemp != index ? Colors.white : Colors.cyan, boxShadow: [
                                    BoxShadow(color: Colors.black12, offset: Offset(5.0, 0.5), blurRadius: 10.4, spreadRadius: 1.4),
                                  ]),
                                  height: 190,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          child: Image.network(
                                            listcategories[index].categoryImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                child: Text(
                                              listcategories[index].categoryName,
                                              style: TextStyle(fontSize: 13, color: indexTemp != index ? Colors.black87 : Colors.white, fontWeight: FontWeight.w700),
                                            ))
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 30, bottom: 20),
                                    child: Checkbox(
                                        value: index == indexTemp ? true : false,
                                        onChanged: (value) {
                                          setState(() {
                                            indexTemp = index;
                                          });
                                        }),
                                  )),
                              //  )
                              //  Positioned(top: 2, left: 1, right: 140, child: Checkbox(value: true, onChanged: (value) {}))
                            ],
                          )),
                    ),
                  );
                }),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void getJsonData() async {
    var jsonText = await rootBundle.loadString('assets/jsonassets/catJson');
    setState(() {
      var map = json.decode(jsonText);
      //listcategories = CategoriesModel.fromJson(json.decode(jsonText)).categories;
      print("jsonText ${listcategories.length}");
    });
  }

  void updateCategory({int index}) {
    var obj = {'id': Database.getUserID(), 'category_name': listcategories[indexTemp].categoryName.toString(), 'category_id': listcategories[indexTemp].id};
    print("REQUEST  ${obj.toString()}");
    Database.initDatabase();
    Database.saveSelectedCategory(category: listcategories[index].categoryName, categoryId: listcategories[index].id);
    print("RES ${Database.getSelectedCategoryId()}");

    Get.to(SubcategoryPage(
      categoryId: listcategories[index].id,
      categoryName: listcategories[index].categoryName,
    ));
    /*   ApiHandler.putApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.updateCaegory, map: json.encode(obj)).then((value) {
      print("RES ${value.toString()}");
      if (value['Status_code'] == '200') {
        ToastMessage.showToast(message: 'Category updated successfuly', type: true);
        print("RES ${listcategories[index].id}");

      }
    });
 */
  }

  void getCategories() {
    ApiHandler.getApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.category).then((value) {
      if (value['Status_code'] == '200')
        setState(() {
          listcategories = CategoriesModel.fromJson(value).categoryList.toList();
          print("RES ${value.toString()}");
        });
    });
  }

  getBottomNav() {
    return SizedBox(
      child: RaisedButton(
        color: Colors.cyan,
        onPressed: () {
          if (indexTemp != null) {
            Database.initDatabase();
            Database.saveSelectedCategory(category: listcategories[indexTemp].categoryName, categoryId: listcategories[indexTemp].id);
            updateCategory(index: indexTemp);
            // Get.to(DashBoard());
          } else {
            ToastMessage.showToast(message: AppSrings.selectCategory, type: false);
          }
        },
        child: Text(
          'Submit',
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      height: 60,
      width: Get.size.width,
    );
  }
}
