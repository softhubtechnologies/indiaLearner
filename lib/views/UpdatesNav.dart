import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_learner/blocs/NotificationsListBloc.dart';
import 'package:india_learner/models/NotificationsListModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:provider/provider.dart';

class UpdatesNav extends StatefulWidget {
  UpdatesNavState createState() => UpdatesNavState();
}

class UpdatesNavState extends State<UpdatesNav> {
  String theme;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationsBloc.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;

    return Scaffold(
      //backgroundColor: Colors.grey.shade50,
      body: Container(
        child: StreamBuilder(
          stream: notificationsBloc.notificationsStream,
          builder: (context, AsyncSnapshot<NotificationsListModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.only(top: 12, left: 10, right: 5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: snapshot.data.notificationList != null
                    ? ListView.builder(
                        itemCount: snapshot.data.notificationList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 58,
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: theme == Constants.lightTheme ? Colors.white : color.darkCard),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data.notificationList[index].notification,
                                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 14),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [Text(snapshot.data.notificationList[index].date)],
                                  ),
                                )
                              ],
                            ),
                          );
                        })
                    : Utils.noData,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Utils.loader;
            } else {
              return Utils.noData;
            }
          },
        ),
      ),
    );
  }
}
