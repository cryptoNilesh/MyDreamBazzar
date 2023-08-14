import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/balance_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/team_count_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/withdraw_list_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/bloc/balance_bloc.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/bloc/withdraw_list_bloc.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/repo.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/my_bank/my_bank_detail_screen.dart';
import 'package:provider/provider.dart';

class MyWithdrawalScreen extends StatefulWidget {
  const MyWithdrawalScreen({Key key}) : super(key: key);

  @override
  State<MyWithdrawalScreen> createState() => _MyWithdrawalScreenState();
}

class _MyWithdrawalScreenState extends State<MyWithdrawalScreen> {
  final _repository = Repository();
  TextEditingController amountcontroller = TextEditingController();
  FocusNode amountnode = FocusNode();

  @override
  void initState() {
    super.initState();

    withdrawListBloc.withdrawListSink(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
    balanceBloc.balancetSink(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
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
          " My Withdrawal",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorResources.getPrimary(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),

   child: StreamBuilder<BalanceModel>(
            stream: balanceBloc.bankListstream,
            builder: (context,
            AsyncSnapshot<BalanceModel>
            balancesnapshot) {


              return Column(children: [
                Center(
                  child: Text(
                    "Enter Amount",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorResources.getPrimary(context),
                        fontSize: 18),
                  ),
                ),
                SizedBox(height: 25),
                CstmTextField(
                    focusNode: amountnode,
                    controller: amountcontroller,
                    textInputAction: TextInputAction.done,
                    text: "Enter Amount"),
                SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    if(amountcontroller.text.isEmpty)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Amount is Empty"),
                        ));
                      }
                    else if(int.parse(amountcontroller.text.toString())<500){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("Amount is Above "+amountcontroller.text.toString()),
                      ));
                    }
                    else if(double.parse(balancesnapshot.data.data.wallet_balance)<double.parse(amountcontroller.text))
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Enter Correct Amount"+amountcontroller.text.toString()),
                        ));
                       // showCustomSnackBar("Enter Correct Amount", context);
                      }
                    else{
                      onWithdrawalAddAPI();
                    }


                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      color: ColorResources.getPrimary(context),
                      borderRadius:
                      BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                    ),
                    child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                ),
                StreamBuilder<WithdrawListModel>(
                  stream: withdrawListBloc.withdrawListstream,
                  builder: (context,
                      AsyncSnapshot<WithdrawListModel> withdrawListsnapshot) {
                    if (!withdrawListsnapshot.hasData) {
                      return Container();
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: withdrawListsnapshot.data.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          minLeadingWidth: 0,
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(withdrawListsnapshot.data.data[index].id),
                            ],
                          ),
                          trailing: Text(
                              '₹ ${withdrawListsnapshot.data.data[index]
                                  .amount}'),
                          title: Text(
                              'Date : ${withdrawListsnapshot.data.data[index]
                                  .date}'),
                        );
                      },
                    );
                  },
                )
              ]);
            })),
      ),
    );
  }

  dynamic onWithdrawalAddAPI() async {
    // Loader().showLoader(context);
    final TeamCountModel isWithdrawalAdd = await _repository.onWithdralAdd(amountcontroller.text,Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
    print(isWithdrawalAdd.message.toString()+"hhuuuvnbng");
    if (isWithdrawalAdd.message != null) {
      amountcontroller.clear();
      FocusScope.of(context).requestFocus(FocusNode());
      withdrawListBloc.withdrawListSink(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(isWithdrawalAdd.message),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(isWithdrawalAdd.message),
      ));
    }
  }
}
