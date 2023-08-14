import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/balance_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/wallet_add_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/bloc/balance_bloc.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/bloc/transaction_history_bloc.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/repo.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/widget/transaction_list_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletScreen extends StatefulWidget {
  final bool isBacButtonExist;
  WalletScreen({this.isBacButtonExist = true});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _repository = Repository();
  TextEditingController amountcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();


    balanceBloc.balancetSink(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    bool darkMode =
        Provider.of<ThemeProvider>(context, listen: false).darkTheme;
    bool isFirstTime = true;
    bool isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (isFirstTime) {
      if (!isGuestMode) {
        Provider.of<ProfileProvider>(context, listen: false)
            .getUserInfo(context);
        // Provider.of<WalletTransactionProvider>(context, listen: false)
        //     .getTransactionList(context, 1);
      }

      isFirstTime = false;
    }

    return Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        body: SafeArea(
          child: RefreshIndicator(
            color: Theme.of(context).cardColor,
            backgroundColor: Theme.of(context).primaryColor,
            onRefresh: () async {
              balanceBloc.balancetSink(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
              // Provider.of<WalletTransactionProvider>(context, listen: false)
              //     .getTransactionList(context, 1, reload: true);
              return false;
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  iconTheme: IconThemeData(
                      color: ColorResources.getTextTitle(context)),
                  backgroundColor: Theme.of(context).cardColor,
                  title: Text(
                    getTranslated('wallet', context),
                    // textAlign: TextAlign.center,
                    style: TextStyle(color: ColorResources.getPrimary(context)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      isGuestMode
                          ? Expanded(child: NotLoggedInWidget())
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Consumer<WalletTransactionProvider>(
                                //     builder: (context, profile, _) {
                                //   return
                                StreamBuilder<BalanceModel>(
                                    stream: balanceBloc.bankListstream,
                                    builder: (context,
                                        AsyncSnapshot<BalanceModel>
                                            balancesnapshot) {
                                      if (!balancesnapshot.hasData) {
                                        return Container();
                                      }
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .PADDING_SIZE_EXTRA_LARGE),
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        decoration: BoxDecoration(
                                          color: ColorResources.getPrimary(
                                              context),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.PADDING_SIZE_SMALL),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors
                                                    .grey[darkMode ? 900 : 200],
                                                spreadRadius: 0.5,
                                                blurRadius: 0.3)
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Container(
                                                //     width: Dimensions.LOGO_HEIGHT,
                                                //     height: Dimensions.LOGO_HEIGHT,
                                                //     child:
                                                //         Image.asset(Images.wallet)),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        getTranslated(
                                                            'wallet_amount',
                                                            context),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE)),
                                                    SizedBox(
                                                      height: Dimensions
                                                          .PADDING_SIZE_SMALL,
                                                    ),
                                                    Text(
                                                        balancesnapshot.data
                                                            .data.wallet_balance,
                                                        // PriceConverter.convertPrice(
                                                        //     context,
                                                        //     (profile.walletBalance !=
                                                        //                 null &&
                                                        //             profile.walletBalance
                                                        //                     .totalWalletBalance !=
                                                        //                 null)
                                                        //         ? profile
                                                        //                 .walletBalance
                                                        //                 .totalWalletBalance ??
                                                        //             0
                                                        //         : 0),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_OVER_LARGE)),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: 60,
                                                    child: VerticalDivider(
                                                        thickness: 2)),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Wallet Repayment",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_LARGE)),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    Text(
                                                        balancesnapshot
                                                            .data
                                                            .data.wallet_repayment,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_OVER_LARGE)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            Text(
                                                // getTranslated(
                                                //     'wallet_amount',
                                                //     context),
                                                "Last recharged : Not Available",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_SMALL)),
                                          ],
                                        ),
                                      );
                                    }),
                                // }),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          insetPadding: EdgeInsets.only(
                                              left: 18, right: 18),
                                          contentPadding: EdgeInsets.only(
                                              left: 8, right: 8),
                                          title: const Text("Amount"),
                                          content: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                controller: amountcontroller,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    filled: true,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Colors.grey[600]),
                                                    hintText: "Enter Amount",
                                                    fillColor: Colors.white70),
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey, //                   <--- border color
                                                      width: 1.0),
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 9),
                                                child: const Text(
                                                  "Close",
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                openCheckout();
                                                // onAddWalletAPI();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorResources.getPrimary(
                                                          context),
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 14,
                                                        vertical: 10),
                                                child: const Text(
                                                  "proceed",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors
                                                .grey, //                   <--- border color
                                            width: 1.0),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.PADDING_SIZE_SMALL),
                                      ),
                                      child: Center(
                                          child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              insetPadding: EdgeInsets.only(
                                                  left: 18, right: 18),
                                              contentPadding: EdgeInsets.only(
                                                  left: 8, right: 8),
                                              title: const Text("Amount"),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: TextField(
                                                    controller:
                                                        amountcontroller,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        filled: true,
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          horizontal: 8,
                                                        ),
                                                        hintStyle: TextStyle(
                                                            color: Colors
                                                                .grey[600]),
                                                        hintText:
                                                            "Enter Amount",
                                                        fillColor:
                                                            Colors.white70),
                                                  ),
                                                ),
                                              ),
                                              actions: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey, //                   <--- border color
                                                          width: 1.0),
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .PADDING_SIZE_SMALL),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 16,
                                                        vertical: 9),
                                                    child: const Text(
                                                      "Close",
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    openCheckout();
                                                    // onAddWalletAPI();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorResources
                                                          .getPrimary(context),
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .PADDING_SIZE_SMALL),
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 14,
                                                        vertical: 10),
                                                    child: const Text(
                                                      "proceed",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.add,
                                            color: Colors.blueGrey),
                                      )),
                                    ),
                                  ),
                                ),
                                TransactionListView(
                                  scrollController: _scrollController,
                                )
                              ],
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void openCheckout() {
    Razorpay _razorpay = Razorpay();



    var options = {
      'key': 'rzp_live_oWY7jSrlVah3ZK',
      'amount': int.parse(amountcontroller.text)*100,
      'name': 'Dream Bazzar',
      'description': 'wallet ammount',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': Provider.of<ProfileProvider>(context, listen: false).userInfoModel.phone, 'email': Provider.of<ProfileProvider>(context, listen: false).userInfoModel.email},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
      _razorpay.on(
          Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
      _razorpay.on(
          Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}",
        () {
      Navigator.pop(context);
    });
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}", () {
      Navigator.pop(context);
      onAddWalletAPI();
    });
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}", () {});
  }

  void showAlertDialog(BuildContext context, String title, String message,
      void Function() onPressed) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: onPressed,
      // onPressed: () {
      //   // Navigator.pop(context);
      //   // Navigator.pop(context);
      // },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dynamic onAddWalletAPI() async {
    // Loader().showLoader(context);
    final WalletAddModel isLogin =
        await _repository.onWalletAdd(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString(), amountcontroller.text);

    if (isLogin.message != null) {
      print('object');
      Navigator.pop(context);

      transactionHistorybloc.transactionHistorySink(Provider.of<ProfileProvider>(context, listen: false).userInfoModel.id.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(isLogin.message),
      ));
      // ShowAlertBox().showAlertDialog(
      //     context, isLogin.message ?? '', 'OK', true, 't_success.json');
      // showSnackBar(context, 'Login Success!!');
      // Future.delayed(const Duration(milliseconds: 100), () {
      //   NavigatorAnimation(context, const Dashboard()).navigateFromRight();
      // });
    } else {
      print('fsdg sdfvgscx');
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(isLogin.errors[0].message),
      ));
      // Loader().hideLoader(context);
      // ShowAlertBox().showAlertDialog(
      //     context, isLogin.message!, 'OK', true, 't_faileds.json', '');
    }
  }
}

class OrderShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          color: Theme.of(context).highlightColor,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: ColorResources.WHITE),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container(height: 45, color: Colors.white)),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(height: 20, color: ColorResources.WHITE),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                  height: 10, width: 70, color: Colors.white),
                              SizedBox(width: 10),
                              Container(
                                  height: 10, width: 20, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
// import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/provider/wallet_transaction_provider.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
// import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
// import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/widget/transaction_list_view.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// class WalletScreen extends StatelessWidget {
//   final bool isBacButtonExist;
//   WalletScreen({this.isBacButtonExist = true});

//   @override
//   Widget build(BuildContext context) {
//     final ScrollController _scrollController = ScrollController();
//     bool darkMode = Provider.of<ThemeProvider>(context, listen: false).darkTheme;
//     bool isFirstTime = true;
//     bool isGuestMode = !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
//     if(isFirstTime) {
//       if(!isGuestMode) {
//         Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
//         Provider.of<WalletTransactionProvider>(context, listen: false).getTransactionList(context,1);
//       }

//       isFirstTime = false;
//     }

//     return Scaffold(
//       backgroundColor: ColorResources.getIconBg(context),
//       body: SafeArea(
//         child: RefreshIndicator(
//           color: Theme.of(context).cardColor,
//           backgroundColor: Theme.of(context).primaryColor,
//           onRefresh: () async {
//             Provider.of<WalletTransactionProvider>(context, listen: false).getTransactionList(context,1,reload: true);
//             return false;
//           },
//           child: CustomScrollView(
//             controller: _scrollController,
//             slivers: [
//               SliverAppBar(floating: true,
//                 pinned: true,
//                 iconTheme:  IconThemeData(color: ColorResources.getTextTitle(context)),
//                 backgroundColor: Theme.of(context).cardColor,
//                 title: Text(getTranslated('wallet', context),style: TextStyle(color: ColorResources.getTextTitle(context)),),),
//               SliverToBoxAdapter(
//                 child: Column(
//                   children: [

//                     isGuestMode ? Expanded(child: NotLoggedInWidget()) :
//                     Column(
//                       children: [
//                         Consumer<WalletTransactionProvider>(
//                             builder: (context, profile,_) {
//                               return Container(
//                                 height: MediaQuery.of(context).size.width/2.5,
//                                 width: MediaQuery.of(context).size.width,
//                                 padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
//                                 margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).primaryColor,
//                                   borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
//                                   boxShadow: [BoxShadow(color: Colors.grey[darkMode ? 900 : 200],
//                                       spreadRadius: 0.5, blurRadius: 0.3)],
//                                 ),
//                                 child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Container (
//                                             width: Dimensions.LOGO_HEIGHT,
//                                             height: Dimensions.LOGO_HEIGHT,
//                                             child: Image.asset(Images.wallet)),
//                                         Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             Text(getTranslated('wallet_amount', context), style: TextStyle(fontWeight: FontWeight.w400,
//                                                 color: Colors.white,fontSize: Dimensions.FONT_SIZE_LARGE)),

//                                             SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
//                                             Text(PriceConverter.convertPrice(context, (profile.walletBalance != null && profile.walletBalance.totalWalletBalance != null) ?
//                                             profile.walletBalance.totalWalletBalance ?? 0 : 0),
//                                                 style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white,
//                                                     fontSize: Dimensions.FONT_SIZE_OVER_LARGE)),
//                                           ],
//                                         ),
//                                         SizedBox(width: Dimensions.LOGO_HEIGHT,),
//                                       ],
//                                     ),

//                                   ],
//                                 ),
//                               );
//                             }
//                         ),

//                         TransactionListView(scrollController: _scrollController,)
//                       ],
//                     ),

//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       )

//     );
//   }
// }

// class OrderShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10,
//       padding: EdgeInsets.all(0),
//       itemBuilder: (context, index) {
//         return Container(
//           margin: EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
//           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//           color: Theme.of(context).highlightColor,
//           child: Shimmer.fromColors(
//             baseColor: Colors.grey[300],
//             highlightColor: Colors.grey[100],
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(height: 10, width: 150, color: ColorResources.WHITE),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Expanded(child: Container(height: 45, color: Colors.white)),
//                     SizedBox(width: 10),
//                     Expanded(
//                       flex: 3,
//                       child: Column(
//                         children: [
//                           Container(height: 20, color: ColorResources.WHITE),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Container(height: 10, width: 70, color: Colors.white),
//                               SizedBox(width: 10),
//                               Container(height: 10, width: 20, color: Colors.white),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class SliverDelegate extends SliverPersistentHeaderDelegate {
//   Widget child;
//   SliverDelegate({@required this.child});

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   double get maxExtent => 70;

//   @override
//   double get minExtent => 70;

//   @override
//   bool shouldRebuild(SliverDelegate oldDelegate) {
//     return oldDelegate.maxExtent != 70 || oldDelegate.minExtent != 70 || child != oldDelegate.child;
//   }
// }
