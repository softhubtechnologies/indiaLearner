import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/SubCategoryModel.dart';
import 'package:india_learner/networking/ApiHandler.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/networking/EndApi.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/ClassSelectionPage.dart';
import 'package:india_learner/views/DashBoard.dart';

class SubcategoryPage extends StatefulWidget {
  String categoryId, categoryName;

  SubcategoryPage({this.categoryId, this.categoryName});

  SubcategoryPageState createState() => SubcategoryPageState(categoryId, categoryName);
}

class SubcategoryPageState extends State<SubcategoryPage> {
  List<SubcategoryList> listSubcategory = [];
  String categoryId, categoryName;

  SubcategoryPageState(this.categoryId, this.categoryName);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubcategories();
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
        title: Text("Select Subcategory", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(top: 30),
        child: listSubcategory != null
            ? GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                padding: EdgeInsets.symmetric(horizontal: 16),
                childAspectRatio: 1.8,
                children: List.generate(listSubcategory.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      saveAndNavigate(index: index);
                    },
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: const Offset(
                            5.0,
                            0.5,
                          ),
                          blurRadius: 10.4,
                          spreadRadius: 0.4,
                        )
                      ]),
                      child: Center(
                        child: Row(
                          //mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Icon(
                              Icons.clear_all_sharp,
                              size: 32,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              listSubcategory[index].subcategory,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )
            : Center(
                child: Text("No subcategories available for this category"),
              ),
      )),
    );
  }

  void getSubcategories() {
    var obj = {"category_id": categoryId};
    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.subcategory, map: obj).then((value) {
      print("RESPONSE ${value.toString()}");
      setState(() {
        listSubcategory = SubCategoryModel.fromJson(value).subcategoryList;
      });
    });
  }

  void saveAndNavigate({int index}) async {
    print("IDDDDDDD ${listSubcategory[index].subcategory} ${listSubcategory[index].subcategoryId}");
    Database.saveSubCategory(subcategory: listSubcategory[index].subcategory, subcatId: listSubcategory[index].subcategoryId);
    if (listSubcategory[index].isClass == '0') {
      Repository.updateCategory(categoryId: categoryId, categoryName: categoryName, subCategoryId: listSubcategory[index].subcategoryId);
      Get.offAll(DashBoard());
    } else {
      Get.offAll(ClassSelectionPage(
        categoryName: categoryName,
      ));
    }
    /* await Database.initDatabase();
    Repository.updateCategory(categoryId:categoryId,categoryName:categoryName,subCategoryId:listSubcategory[index].subcstegoryId);
    Database.saveSubCategory(subcategory: listSubcategory[index].subcategory, subcatId: listSubcategory[index].subcstegoryId);
    print("VVVVVVVVV ${Database.getSelectedCategoryId()}");*/
  }
}
