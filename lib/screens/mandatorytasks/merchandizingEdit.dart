import 'dart:io';
// import 'package:compressimage/compressimage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retailer/database/merchar_imageHelper.dart';
import 'package:retailer/models/merchandizing_M.dart';
import 'package:retailer/screens/public/widget.dart';
import '../../style/theme.dart' as Style;
import 'package:retailer/utility/utility.dart';
import 'package:retailer/services/functional_provider.dart';
import 'package:provider/provider.dart';
import 'package:retailer/screens/mandatorytasks/merchandizing.dart';
import 'package:retailer/models/image_sqflite_M.dart';

class MerchandizingEdit extends StatefulWidget {
  final TaskList _taskList;

  MerchandizingEdit(this._taskList);
  @override
  _MerchandizingEditState createState() => _MerchandizingEditState();
}

class _MerchandizingEditState extends State<MerchandizingEdit> {
  ImageDbHelper imageDbHelper = ImageDbHelper();

  List<Photo> photoList;
  List<Map<String, dynamic>> showList = [];
  ViewModelFunction model;
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewModelFunction>(
      context,
      listen: false,
    );
    if (photoList == null) {
      photoList = List<Photo>();
      getPhotoList();
    }
    return WillPopScope(
      onWillPop: () {
        return back();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            widget._taskList.taskCode,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400], width: 1.2),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget._taskList.taskName,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: getRemark(textEditingController),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  children: List.generate(showList.length + 1, (index) {
                    return Container(
                      child: index + 1 > showList.length
                          ? InkWell(
                              onTap: () {
                                _settingModalBottomSheet(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[300],
                                ),
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                        fontSize: 74,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(0.5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey[400])),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Stack(
                                  fit: StackFit.passthrough,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ViewImage(
                                                      showList[index]
                                                          ["compress"],
                                                    )));
                                      },
                                      child: Image.memory(
                                        showList[index]['compress'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        right: 2,
                                        top: 2,
                                        child: InkWell(
                                          onTap: () async {
                                            if (showList[index]["id"] != null) {
                                              await imageDbHelper.deletePhoto(
                                                  showList[index]["id"]);
                                              setState(() {
                                                showList
                                                    .remove(showList[index]);
                                              });
                                            } else {
                                              setState(() {
                                                showList
                                                    .remove(showList[index]);
                                              });
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.close,
                                              size: 18,
                                              color: Style.Colors.mainColor,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Style.Colors.mainColor,
            ),
            height: 45,
            child: FlatButton(
              onPressed: () {
                if (showList.length > 0) {
                  savePhoto();
                } else {
                  getToast(context, "Please Select Image");
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  savePhoto() {
    loading(context);
    showList.forEach((element) async {
      String base64 = Utility.base64String(element["compress"]);

      if (element["id"] == null) {
        await imageDbHelper.insertPhoto(Photo(
            base64,
            model.activeShop.shopsyskey,
            widget._taskList.taskCode,
            textEditingController.text));
      } else {
        await imageDbHelper.updatePhoto(Photo.withId(
            element["id"],
            base64,
            model.activeShop.shopsyskey,
            widget._taskList.taskCode,
            textEditingController.text));
      }
    });
    getToast(context, "Save Successful");
    // back();
    Navigator.pop(context, true);
    back();
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: ImageIcon(AssetImage('assets/icon/attach.png')),
                    title: Text('Gallery '),
                    onTap: () {
                      Navigator.pop(context, true);
                      getMultipleImage();
                    }),
                ListTile(
                  leading: Icon(Icons.camera_alt_outlined),
                  title: Text('Take Photo'),
                  onTap: () {
                    Navigator.pop(context, true);
                    getImage();
                  },
                ),
              ],
            ),
          );
        });
  }

  getPhotoList() async {
    var photoListFuture = imageDbHelper.getPhotoByTaskCode(
        model.activeShop.shopsyskey, widget._taskList.taskCode);
    photoListFuture.then((plist) {
      this.photoList = plist;

      setState(() {
        if (photoList.length > 0) {
          print("It is saved => $photoList");
          textEditingController.text = photoList[0].remark ?? "";
          photoList.forEach((element) {
            showList.add({
              "compress": Utility.dataFromBase64String(element.photo),
              "id": element.id
            });
          });
        }
      });
    });
  }

  Future getMultipleImage() async {
    List<File> files = await FilePicker.getMultiFile(
      type: FileType.image,
    );
    if (files != null) {
      files.forEach((element) async {
        var result = await FlutterImageCompress.compressWithFile(
          element.path,
          quality: 20,
          rotate: 0,
        );
        setState(() {
          setState(() {
            showList.add({"filename": "${element.path}", "compress": result});
          });
        });
      });
    }
  }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      var result = await FlutterImageCompress.compressWithFile(
        pickedFile.path,
        quality: 20,
        rotate: 0,
      );
      setState(() {
        showList.add({
          "filename": "${pickedFile.path}",
          "compress": result,
        });
      });
    }
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  back() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MerchandizingScreen()),
    );
  }
}

class ViewImage extends StatelessWidget {
  final dynamic _image;

  ViewImage(this._image);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.memory(
        _image,
        fit: BoxFit.cover,
      ),
    );
  }
}
