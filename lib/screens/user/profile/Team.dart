import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retailer/models/shopByListModel.dart';
import 'package:retailer/screens/user/profile/shopDetail.dart';
import 'package:retailer/services/functional_provider.dart';
import 'package:retailer/style/theme.dart' as Style;
import 'package:http/http.dart' as http;

class TeamWidget extends StatefulWidget {
  @override
  _TeamWidgetState createState() => _TeamWidgetState();
}

class _TeamWidgetState extends State<TeamWidget> {
  ViewModelFunction model;


  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(context);
    return model.shopsByTeam.isEmpty ? getnotfound() : getTeamList();
  }

  Widget getnotfound() {
    var height =MediaQuery.of(context).size.height;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: height* .3),
        child: Center(
          child: Column(
            children: [
              ImageIcon(
                AssetImage('assets/icon/team.png'),
                color: Colors.grey,
                size: 65,
              ),
              Container(height: 5),
              Text(
                'Team not found !',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTeamList() {
    List<Widget> getByTeam = [];
    List<ShopByListM> filteredList =
        model.shopsByTeam.fold([], (current, next) {
      ShopByListM isExist = current.firstWhere((element) {
        return element.usercode == next.usercode;
      }, orElse: () => null);

      if (isExist == null) {
        current.add(next);
      }
      return current;
    });

    return ListView.builder(
      itemBuilder: (context, index) => ExpansionTile(
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 44,
            maxHeight: 44,
          ),
          child: Image.asset('assets/notfound.png', fit: BoxFit.cover),
        ),
        title: Text(
          filteredList[index].username,
          style: Style.headingTextStyle,
        ),
        children: [
          new FutureBuilder(
            builder:
                (BuildContext context, AsyncSnapshot<http.Response> response) {
              getByTeam.clear();
              List<ShopByListM> list = model.shopsByTeam
                  .where((p) =>
                      p.usercode.contains(model.shopsByTeam[index].usercode))
                  .toList();
              list.forEach((element) {
                getByTeam.add(
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                    child: Container(
                      child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 44,
                            maxHeight: 44,
                          ),
                          child: Image.asset('assets/notfound.png',
                              fit: BoxFit.cover),
                        ),
                        title: Text(
                          '${element.shopname}',
                        ),
                        subtitle: Text(
                          '${element.phoneno}',
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShopDetailScreen(element)));
                        },
                      ),
                    ),
                  ),
                );
              });
              return Column(
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  new Column(children: getByTeam),
                ],
              );
            },
          ),
        ],
      ),
      itemCount: filteredList.length,
    );
  }
}
