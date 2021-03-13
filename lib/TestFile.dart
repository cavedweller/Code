import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tester extends StatefulWidget {
  Tester({Key key}) : super(key: key);

  @override
  _TesterState createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  List dataList = [];
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    double _width = devicesize.width;
    double _height = devicesize.height;
    return SafeArea(
      child: Scaffold(
          body: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("events")
                  .doc('d1YRpO0FWrrm69oHhvLt')
                  .snapshots(),
              //ABOVE CODE GRABS DATA FROM THE FIREBASE DATABASE
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      height: _height * .9,
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  if (snapshot.data.exists) {
                    if (snapshot.hasData) {
                      //I JUST CLEAR THE LIST SO WHEN YOU HOT RELOAD IT DOESNT DOUBLE THE LIST
                      dataList.clear();

                      //THIS JUST GOES TO THE SPECIFIC PATH IN THE DATABASE TO FECTCH THE DATA
                      dataList = snapshot.data.data()['Post'][0]['ArrayList'];
                      //THE LENGTH OF THE LIST SHOULD BE 100
                      print(dataList.length);
                      return Container(
                        height: _height,
                        child: Container(
                          height: _height * .818,
                          color: Color(0xff001d69),
                          child: ListView.builder(
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: _height * 0.11,
                                child: Card(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: _height * 0.11,
                                        width: _width * .2,
                                        child: Image.network(
                                          // 'https://picsum.photos/id/117/1544/1024', // THIS WILL REPEAT THE SAME IMAGE 100 TIMES
                                          dataList[
                                              index], //UNCOMMENT THIS TO DISPLAY THE IMAGES IN THE DATABASE
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes
                                                    : null,
                                              ),
                                              //THE LOADING BUILDER WIL JUST SHOW AN INDICATOR WHEN FETCHING THE IMAGE
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Container(
                                          width: _width * .5,
                                          child: Text(
                                              'Other data will be displayed here at index:' +
                                                  index.toString())),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return Text('No data');
                    }
                  } else {
                    return Container(
                        height: _height * .9,
                        child: (Center(
                          child: Text('error'),
                        )));
                  }
                }
              })),
    );
  }
}
