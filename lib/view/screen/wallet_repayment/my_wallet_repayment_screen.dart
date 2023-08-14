import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';

class WalletRepaymentScreen extends StatefulWidget {
  const WalletRepaymentScreen({Key key}) : super(key: key);

  @override
  State<WalletRepaymentScreen> createState() => _WalletRepaymentScreenState();
}

class _WalletRepaymentScreenState extends State<WalletRepaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blueGrey,
            )),
        title: Text(
          " My Wallet Repayment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorResources.getPrimary(context),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.width / 2.6,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
          margin:
              EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: ColorResources.getPrimary(context),
            borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors
            //           .grey[darkMode ? 900 : 200],
            //       spreadRadius: 0.5,
            //       blurRadius: 0.3)
            // ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //     width: Dimensions.LOGO_HEIGHT,
                  //     height: Dimensions.LOGO_HEIGHT,
                  //     child:
                  //         Image.asset(Images.wallet)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Wallet Repayment Balance",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                          // getTranslated(
                          //     'wallet_amount',
                          //     context),
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: Dimensions.FONT_SIZE_OVER_LARGE)),
                    ],
                  ),
                  // SizedBox(
                  //   width: Dimensions.LOGO_HEIGHT,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
