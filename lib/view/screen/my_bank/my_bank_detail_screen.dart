import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/bank_list_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/team_count_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/bloc/bank_list_bloc.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/repo.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

class MyBankDetailScreen extends StatefulWidget {
  const MyBankDetailScreen({Key key, this.index, this.edit, this.id}) : super(key: key);
  final int index;
  final Data edit;
  final String id;
  @override
  State<MyBankDetailScreen> createState() => _MyBankDetailScreenState();
}

class _MyBankDetailScreenState extends State<MyBankDetailScreen> {
  final _repository = Repository();
  TextEditingController accountname = TextEditingController();
  FocusNode accountnamenode = FocusNode();
  TextEditingController accountnumber = TextEditingController();
  FocusNode accountnumbernode = FocusNode();
  TextEditingController ifsc = TextEditingController();
  FocusNode ifscnode = FocusNode();
  TextEditingController extra = TextEditingController();
  FocusNode extranode = FocusNode();
  TextEditingController extra2 = TextEditingController();
  FocusNode extra2node = FocusNode();



  @override
  void initState() {
    super.initState();
    if (widget.index == 1) {
      accountname.text = widget.edit.accountName;
      accountnumber.text = widget.edit.accountNumber;
      ifsc.text = widget.edit.ifsc;
      extra.text = widget.edit.extra;
      extra2.text = widget.edit.extra2;
    } else {



      banklistBloc.bankListSink(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
    }
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
              icon: Icon(
                Icons.arrow_back,
                color: Colors.blueGrey,
              )),
          title: Text(
            widget.index == 1 ? "My Bank Edit" : "My Bank",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorResources.getPrimary(context),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.index == 1
                        ? "Update Your Bank Details"
                        : "Enter bank Detail",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.getPrimary(context)),
                  ),
                ),
                SizedBox(height: 15),
                CstmTextField(
                    textInputAction: TextInputAction.next,
                    focusNode: accountnamenode,
                    controller: accountname,
                    text: "Account Name",
                    hinttexT: "Account Name"),
                SizedBox(height: 8),
                CstmTextField(
                    textInputAction: TextInputAction.next,
                    focusNode: accountnumbernode,
                    controller: accountnumber,
                    text: "Account Number",
                    hinttexT: "Account Number"),
                SizedBox(height: 8),
                CstmTextField(
                    textInputAction: TextInputAction.next,
                    focusNode: ifscnode,
                    controller: ifsc,
                    text: "IFSC",
                    hinttexT: "••••••••"),
                SizedBox(height: 8),
                CstmTextField(
                    textInputAction: TextInputAction.next,
                    focusNode: extranode,
                    controller: extra,
                    text: "Extra",
                    hinttexT: "Extra"),
                SizedBox(height: 8),
                CstmTextField(
                    textInputAction: TextInputAction.done,
                    focusNode: extra2node,
                    controller: extra2,
                    text: "Extra2",
                    hinttexT: "Extra2"),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    if (widget.index == 0) {
                      onBankAddAPI();
                    } else {
                      onBankEditAPI();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ColorResources.getPrimary(context),
                      borderRadius:
                          BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                    ),
                    child: Center(
                        child: Text(
                      widget.index == 1 ? "Update" : 'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
                widget.index == 1
                    ? SizedBox()
                    : StreamBuilder<BankListModel>(
                        stream: banklistBloc.bankListstream,
                        builder: (context,
                            AsyncSnapshot<BankListModel> bankListsnapshot) {
                          if (!bankListsnapshot.hasData) {
                            return Container();
                          }
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: bankListsnapshot.data.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(bankListsnapshot
                                    .data.data[index].accountName),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'accountNumber : ${bankListsnapshot.data.data[index].accountNumber}'),
                                    Text(
                                        'ifsc : ${bankListsnapshot.data.data[index].ifsc}'),
                                    Text(
                                        'extra : ${bankListsnapshot.data.data[index].extra}'),
                                  ],
                                ),
                                trailing: GestureDetector(
                                    onTap: () {

                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return MyBankDetailScreen(
                                              index: 1,
                                              id:bankListsnapshot
                                                  .data.data[index].id.toString(),
                                              edit: bankListsnapshot
                                                  .data.data[index]);
                                        },
                                      ));
                                    },
                                    child: Text('Edit')),
                              );
                            },
                          );
                        },
                      )
              ],
            ),
          ),
        ));
  }

  dynamic onBankAddAPI() async {
    // Loader().showLoader(context);
    final TeamCountModel isbankAdd = await _repository.onBankAdd(
        accountname.text,
        accountnumber.text,
        ifsc.text,
        extra.text,
        extra2.text,
        Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString()
    );

    if (isbankAdd.message != null) {
      accountname.clear();
      accountnumber.clear();
      ifsc.clear();
      extra.clear();
      extra2.clear();
      FocusScope.of(context).requestFocus(FocusNode());
      banklistBloc.bankListSink(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(isbankAdd.message),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(isbankAdd.message),
      ));
    }
  }

  dynamic onBankEditAPI() async {
    // Loader().showLoader(context);
    final TeamCountModel isbankEdit = await _repository.onBankEdit(
        accountname.text,
        accountnumber.text,
        ifsc.text,
        extra.text,
        extra2.text,
        Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString(),
        widget.id


    );

    if (isbankEdit.message != null) {
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.pop(context);
      banklistBloc.bankListSink(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(isbankEdit.message),
      ));
    } else {
      print('fsdg sdfvgscx');
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(isbankEdit.message),
      ));
    }
  }
}

class CstmTextField extends StatefulWidget {
  CstmTextField(
      {Key key,
      this.text,
      this.hinttexT,
      this.controller,
      this.focusNode,
      this.textInputAction})
      : super(key: key);
  final String text;
  final String hinttexT;
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  @override
  State<CstmTextField> createState() => _CstmTextFieldState();
}

class _CstmTextFieldState extends State<CstmTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorResources.getPrimary(context),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          controller: widget.controller,
          decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.white),
              hintText: widget.hinttexT,
              fillColor: Colors.blueGrey.shade300),
        ),
      ],
    );
  }
}
