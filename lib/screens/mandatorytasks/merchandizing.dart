import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/database/merchar_imageHelper.dart';
import 'package:retailer/models/merchandizing_M.dart';
import 'package:retailer/screens/components/checkin-shop.dart';
import 'package:retailer/screens/main/main_Screen_Search.dart';
import 'package:retailer/screens/mandatorytasks/merchandizingEdit.dart';
import 'package:retailer/screens/public/widget.dart';
import 'package:retailer/services/functional_provider.dart';
import '../../style/theme.dart' as Style;
import 'package:sqflite/sqflite.dart';
import '../../custom/custom_expansion_title.dart' as custom;

class MerchandizingScreen extends StatefulWidget {
  @override
  _MerchandizingScreenState createState() => _MerchandizingScreenState();
}

class _MerchandizingScreenState extends State<MerchandizingScreen> {
  ViewModelFunction model;
  bool loading = true;
  List<String> taskList = [];
  ImageDbHelper imageDbHelper = ImageDbHelper();
  @override
  void initState() {
    super.initState();
    getSysKey();
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Merchandizing"),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: MainScreenSearch(
                        "Search...",
                      ));
                })
          ],
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
                  strokeWidth: 2,
                ),
              )
            : Padding(
                padding: EdgeInsets.all(5.0),
                child: model.listModel == null
                    ? Container(
                        child: Center(
                          child: Text(
                            "No Data Found !",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          CheckinShop(),
                          Flexible(child: getExpansionList())
                        ],
                      ),
              ),
      ),
    );
  }

  Widget getExpansionList() {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        color: Colors.transparent,
        elevation: 3,
        child: custom.ExpansionTitle(
          backgroundColor: Style.Colors.dropBackgroundColor,
          initiallyExpanded: false,
          headerBackgroundColor: Style.Colors.mainColor,
          iconColor: Style.Colors.textColor,
          title: Text(
            model.listModel[index].brandOwnerName,
            style: TextStyle(color: Style.Colors.textColor),
          ),
          onExpansionChanged: (open) async {
            if (open) {
              this.taskList.clear();
              await getPhotoList();
            }
          },
          children: [
            getChildrenList(
              model.listModel[index].taskList,
            ),
          ],
        ),
      ),
      itemCount: model.merchandizingM.list.length,
    );
  }

  getSysKey() async {
    getConectivity().then((ConnectivityResult value) async {
      if (value == ConnectivityResult.none) {
        getToast(context, "Check your internet Conection");
        setState(() {
          loading = false;
        });
      } else {
        await model
            .getShopKey(
                model.activeShop.shopsyskey, model.getLoginDetail.userType)
            .timeout(Duration(seconds: 10), onTimeout: () {
          getToast(context, "Internet connection error");
          setState(() {
            loading = false;
          });
        });

        setState(() {
          loading = false;
        });
      }
    });
  }

  getPhotoList() async {
    final Future<Database> db = imageDbHelper.initializedDatabase();
    await db.then((value) {
      var photoListFuture =
          imageDbHelper.getPhotoBySysKey(model.activeShop.shopsyskey);
      photoListFuture.then((plist) {
        setState(() {
          if (plist != null) {
            plist.forEach((element) {
              if (!taskList.contains(element)) {
                this.taskList.add(element.testCode);
              }
            });
          }
        });
      });
    });
    print(taskList);
  }

  Widget getChildrenList(
    List list,
  ) {
    List<TaskList> _taskList = list.map((e) => TaskList.fromJson(e)).toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: _taskList.length,
      itemBuilder: (context, index) => Card(
        color: getColor(_taskList[index].taskCode),
        child: Padding(
          padding: EdgeInsets.only(left: 3),
          child: Container(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MerchandizingEdit(_taskList[index])));
              },
              title: Text(_taskList[index].taskCode),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.list),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(String taskCode) {
    Color color;
    if (taskList.contains(taskCode)) {
      color = Colors.green;
    } else {
      color = Colors.white;
    }
    return color;
  }
}
