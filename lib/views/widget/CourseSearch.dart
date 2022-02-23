import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_learner/models/CourseListModel.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/views/CourseVideos.dart';

import '../SubscriptionPage.dart';

class CourseSearch extends SearchDelegate {
  List<CourseList> listCourses;

  CourseSearch({this.listCourses});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          color: Colors.black87,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 5, right: 8, top: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          children: List.generate(listCourses.length, (index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width / 2.6,
                height: 120,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0) /*,
                          boxShadow: [BoxShadow(offset: Offset(1.4, 1.4),
                              color: Colors.grey.shade500, spreadRadius: 0.6, blurRadius: 0.8)]*/
                    ),
                margin: EdgeInsets.only(bottom: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      listCourses[index].file != null && listCourses[index].file != "" ? ApiProvider.baseUrlImage + listCourses[index].file : 'ps500x-3-500-lumens-xga-education-projector-500x500.jpg',
                      fit: BoxFit.contain,
                      scale: 0.4,
                      height: 110,
                      width: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          //width: MediaQuery.of(context).size.width / 8,
                          child: Text(
                            listCourses[index].courseName,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87.withOpacity(0.7), fontWeight: FontWeight.w700) /* TextStyle(fontSize: 12, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w800)*/,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Fees:  ₹ ' + listCourses[index].courseFee,
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87.withOpacity(0.6)) /*TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.7))*/,
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CourseList> suggestionsList = [];

    for (int i = 0; i < listCourses.length; i++) {
      if (listCourses[i].courseName == query || listCourses[i].courseName.startsWith(query) || listCourses[i].courseName.toLowerCase() == query.toLowerCase() || listCourses[i].courseName.startsWith(query.toUpperCase()) || listCourses[i].courseName.toUpperCase() == query.toUpperCase()) {
        suggestionsList.add(listCourses[i]);
      }
    }

    return Container(
        padding: EdgeInsets.only(left: 5, right: 8, top: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          children: List.generate(suggestionsList.length, (index) {
            return GestureDetector(
              onTap: () {
                suggestionsList[index].planName != ""
                    ? Get.to(CourseListWidget(
                        courseId: suggestionsList[index].courseId,
                        type: Constants.paid,
                      ))
                    : Get.to(SubscriptionPage());
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.6,
                height: 120,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.0) /*,
                          boxShadow: [BoxShadow(offset: Offset(1.4, 1.4),
                              color: Colors.grey.shade500, spreadRadius: 0.6, blurRadius: 0.8)]*/
                    ),
                margin: EdgeInsets.only(bottom: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      suggestionsList[index].file != null && suggestionsList[index].file != "" ? ApiProvider.baseUrlImage + suggestionsList[index].file : 'ps500x-3-500-lumens-xga-education-projector-500x500.jpg',
                      fit: BoxFit.contain,
                      scale: 0.4,
                      height: 110,
                      width: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          //width: MediaQuery.of(context).size.width / 8,
                          child: Text(
                            suggestionsList[index].courseName,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87.withOpacity(0.7), fontWeight: FontWeight.w700) /* TextStyle(fontSize: 12, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w800)*/,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Fees:  ₹ ' + suggestionsList[index].courseFee,
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87.withOpacity(0.6)) /*TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black87.withOpacity(0.7))*/,
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }
}
