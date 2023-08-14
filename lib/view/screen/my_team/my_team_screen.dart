import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/model/response/base/referal_model_treel.dart';
import '../../../utill/app_constants.dart';

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({Key key}) : super(key: key);

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {

  Future<List<Data>> onWithdrawListApi() async {
    final pref=await SharedPreferences.getInstance();
    var token=pref.getString('token');
    final uri = Uri.parse(AppConstants.BASE_URL+'/api/v1/customer/referals');
    final response = await http.post(uri,headers: {
      'content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer $token',
   });
    if(response.statusCode==200)
    {
      List data=json.decode(response.body)['data'];
      return data.map((num) => Data.fromJson(num)).toList();
    }
    else
    {
      throw Exception('Unexpected error occured!');
    }

  }
  bool check=false;
  bool check1=false;
  bool check2=false;
  bool check3=false;
  bool check4=false;
  int number;
  int number1;
  int number2;
  int number3;
  int number4;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: ColorResources.getIconBg(context),
        leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: Icon(Icons.arrow_back, color: Colors.blueGrey)),
        title: InkWell(
          onTap: () async{
            final pref=await SharedPreferences.getInstance();
            var token=pref.getString('token');
            print("HHHHHHHHHHHHHHhh"+token.toLowerCase());
          },
          child: Text(
            " My Team",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorResources.getPrimary(context)),
          ),
        ),
      ),
      body:Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
         /* height: MediaQuery.of(context).size.height / 2.7,*/
          decoration: BoxDecoration(
            color: ColorResources.getPrimary(context),
            borderRadius:
            BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
          ),
          child: Column(
            children: [
              Text(
                "Team Detail",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              ),
              SizedBox(height: 5),

              Expanded(
                child: FutureBuilder(
                    future: onWithdrawListApi(),
                    builder: (context ,snapshot) {
                      if (snapshot.hasData) {
                        List<Data> data = snapshot.data;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return data.length!=0?
                              Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      if(data[index].referCount!=0)
                                        {
                                          setState(() {
                                            number=data[index].referCount;
                                            if(check==false)
                                              {
                                                setState(() {
                                                  check=true;
                                                });
                                              }
                                            else
                                              {
                                                check=false;
                                              }
                                          });
                                        }
                                    },
                                    child: Card(
                                      child: Container(
                                        decoration:BoxDecoration(
                                            color: Colors.green
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(data[index].name.toString()+" Level 1",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                              Text(data[index].referCount.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                   data[index].referCount==number?ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: data[index].referals.length,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context,int index1)
                                            {
                                              return check==true?
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      if(data[index].referals[index1].referCount!=0)
                                                      {
                                                        setState(() {
                                                          number1=data[index].referals[index1].referCount;
                                                          if(check1==false)
                                                          {
                                                            setState(() {
                                                              check1=true;
                                                            });
                                                          }
                                                          else
                                                          {
                                                            check1=false;
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Card(
                                                      child: Container(
                                                        width:MediaQuery.of(context).size.width/1.13,
                                                        decoration:BoxDecoration(
                                                          color: Colors.deepPurple
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(data[index].referals[index1].name.toString()+" Level 2",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.white,
                                                                    fontSize: 16),
                                                              ),
                                                              Text(data[index].referals[index1].referCount.toString(),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Colors.white,
                                                                    fontSize: 16),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  data[index].referals[index1].referCount==number1?
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: number1,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemBuilder: (BuildContext context,int index2)
                                                      {
                                                        return check1==true?
                                                        Column(
                                                          children: [
                                                            InkWell(
                                                              onTap: (){
                                                                if(data[index].referals[index1].referals[index2].referCount!=0)
                                                                {
                                                                  setState(() {
                                                                    number2=data[index].referals[index1].referals[index2].referCount;
                                                                    if(check2==false)
                                                                    {
                                                                      setState(() {
                                                                        check2=true;
                                                                      });
                                                                    }
                                                                    else
                                                                    {
                                                                      check2=false;
                                                                    }
                                                                  });
                                                                }
                                                              },
                                                              child: Card(
                                                                child: Container(
                                                                  width:MediaQuery.of(context).size.width/1.17,
                                                                  decoration:BoxDecoration(
                                                                      color: Colors.pinkAccent
                                                                  ),
                                                                  child: Padding(
                                                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Text(data[index].referals[index1].referals[index2].name.toString()+" Level 3",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white,
                                                                              fontSize: 16),
                                                                        ),
                                                                        Text(data[index].referals[index1].referals[index2].referCount.toString(),
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white,
                                                                              fontSize: 16),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            data[index].referals[index1].referals[index2].referCount==number2?
                                                            ListView.builder(
                                                                shrinkWrap: true,
                                                                itemCount: number2,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                itemBuilder: (BuildContext context,int index3)
                                                                {
                                                                  return check2==true?
                                                                  Column(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: (){
                                                                          if(data[index].referals[index1].referals[index2].referals[index3].referCount!=0)
                                                                          {
                                                                            setState(() {
                                                                              number3=data[index].referals[index1].referals[index2].referals[index3].referCount;
                                                                              if(check3==false)
                                                                              {
                                                                                setState(() {
                                                                                  check3=true;
                                                                                });
                                                                              }
                                                                              else
                                                                              {
                                                                                check3=false;
                                                                              }
                                                                            });
                                                                          }
                                                                        /*  setState(() {
                                                                            number3=data[index].referals[index1].referals[index2].referals[index3].referCount;
                                                                          });*/
                                                                        },
                                                                        child: Card(
                                                                          child: Container(
                                                                            width:MediaQuery.of(context).size.width/1.21,
                                                                            decoration:BoxDecoration(
                                                                                color: Colors.black
                                                                            ),
                                                                            child: Padding(
                                                                              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(data[index].referals[index1].referals[index2].referals[index3].name.toString()+" Level 4",
                                                                                    style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.white,
                                                                                        fontSize: 16),
                                                                                  ),
                                                                                  Text(data[index].referals[index1].referals[index2].referals[index3].referCount.toString(),
                                                                                    style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.white,
                                                                                        fontSize: 16),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      data[index].referals[index1].referals[index2].referals[index3].referCount==number3?
                                                                      ListView.builder(
                                                                          shrinkWrap: true,
                                                                          itemCount: number3,
                                                                          physics: NeverScrollableScrollPhysics(),
                                                                          itemBuilder: (BuildContext context,int index4)
                                                                          {
                                                                            return check3==true?Card(
                                                                              child: Container(
                                                                                width:MediaQuery.of(context).size.width/1.25,
                                                                                decoration:BoxDecoration(
                                                                                    color: Colors.deepOrangeAccent
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(data[index].referals[index1].referals[index2].referals[index3].referals[index4].name.toString()+" Level 5",
                                                                                        style: TextStyle(
                                                                                            fontWeight: FontWeight.bold,
                                                                                            color: Colors.white,
                                                                                            fontSize: 16),
                                                                                      ),
                                                                                      Text(data[index].referals[index1].referals[index2].referals[index3].referals[index4].referCount.toString(),
                                                                                        style: TextStyle(
                                                                                            fontWeight: FontWeight.bold,
                                                                                            color: Colors.white,
                                                                                            fontSize: 16),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ):
                                                                            Container();
                                                                          }
                                                                      ):
                                                                      Container(),
                                                                    ],
                                                                  ):
                                                                  Container();
                                                                }
                                                            ):
                                                            Container(),
                                                          ],
                                                        ):
                                                        Container();
                                                      }
                                                  ):
                                                  Container(),
                                                ],
                                              ):
                                              Container();
                                            }
                                        ):
                                        Container(),
                                ],
                              ):
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("No ARefferals")
                                ],
                              );
                            }

                        );
                      }
                      return Container();
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
