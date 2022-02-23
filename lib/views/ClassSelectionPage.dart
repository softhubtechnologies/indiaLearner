import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/ClassesModel.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';

class ClassSelectionPage extends StatefulWidget {
  String categoryId, categoryName;

  ClassSelectionPage({this.categoryId, this.categoryName});

  ClassSelectionPageState createState() => ClassSelectionPageState(categoryId, categoryName);
}

class ClassSelectionPageState extends State<ClassSelectionPage> {
  List<ClassList> listClasses = [];
  String categoryId, categoryName;

  ClassSelectionPageState(this.categoryId, this.categoryName);
  Future<Map<String, dynamic>> mapClasses;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      mapClasses = Repository.getClasses();
    });
    //getSubcategories();
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
        child: FutureBuilder(
          future: mapClasses,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("LOSDING ${snapshot.connectionState}");
              listClasses = ClassesModel.fromJson(snapshot.data).classList;
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                padding: EdgeInsets.symmetric(horizontal: 16),
                childAspectRatio: 1.8,
                children: List.generate(listClasses.length, (index) {
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
                              listClasses[index].className,
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
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              print("LOSDING ${snapshot.connectionState}");
              return Utils.loader;
            } else {
              print("LOSDING ${snapshot.connectionState}");

              return Utils.noData;
            }
          },
        ),
      )),
    );
  }

  void saveAndNavigate({int index}) async {
    await Database.initDatabase();
    Repository.updateCategory(categoryId: listClasses[index].categoryId, categoryName: categoryName, subCategoryId: listClasses[index].subcategoryId, classId: listClasses[index].courseId);
    Database.saveSubCategory(subcategory: listClasses[index].subcategoryId, subcatId: listClasses[index].subcategoryId);
    Database.saveClass(listClasses[index].className);
    print("VVVVVVVVV ${Database.getSelectedCategoryId()}");
  }
}
