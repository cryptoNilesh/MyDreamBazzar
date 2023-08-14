import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/profile_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/my_bank/my_bank_detail_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/my_team/my_team_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/my_withdrawal/My_withdrawal_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/order_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/wallet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet_repayment/my_wallet_repayment_screen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

Widget drawerWidget(context) {
  Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
  return Theme(
    data: Theme.of(context).copyWith(
      canvasColor: Colors.white,
    ),
    child: Drawer(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 12),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                    vertical: MediaQuery.of(context).size.height / 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // CircleAvatar(
                    //   backgroundColor: Colors.blue.shade100,
                    // ),
                    // SizedBox(width: Dimensions.MARGIN_SIZE_SMALL),
                    // Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('Ayush Kumar',
                    //           style: TextStyle(
                    //               fontSize: Dimensions.FONT_SIZE_LARGE,
                    //               color: Colors.black87)),
                    //       SizedBox(height: Dimensions.MARGIN_SIZE_EXTRA_SMALL),
                    //       Text("ayushkumar@gmail.com",
                    //           style: TextStyle(color: Colors.black54))
                    //     ]),
                  ],
                )),
            Divider(),
            home(context),

            // Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null?
            // profile(context):SizedBox(),

            Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null?
            wallet(context):SizedBox(),
           //  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null?
           // // walletRepayment(context):SizedBox(),
            Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null?
            refer(context):SizedBox(),
            Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null?
            bank(context):SizedBox(),
            Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null?
            withdrawal(context):SizedBox(),
            Divider(),
            Provider.of<ProfileProvider>(context, listen: false).userInfoModel!=null?
            teamOption(context):SizedBox(),
            Divider(),
          //  logout(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            )
          ],
        ),
      ),
    ),
  );
}

Widget teamOption(context) {
  return ListTile(
    dense: true,
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyTeamScreen(),
          ));
    },
    leading: Icon(Icons.wallet,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Team',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget logout() {
  return ListTile(
    dense: true,
    onTap: () {


    },
    leading: Icon(Icons.logout_rounded,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Logout',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget bank(context) {
  return ListTile(
    dense: true,
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyBankDetailScreen(index: 0),
          ));
    },
    leading: Icon(Icons.wallet,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Bank',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget withdrawal(context) {
  return ListTile(
    dense: true,
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyWithdrawalScreen(),
          ));
    },
    leading: Icon(Icons.wallet,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Withdrawal',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget refer(context) {
  return ListTile(
    dense: true,
    onTap: () {
      print("abc");

      String phone=Provider.of<ProfileProvider>(context, listen: false).userInfoModel.phone;
      String url=" https://play.google.com/store/apps/details?id=com.dream.bazzar ";
      String str=" Your Referal Code is "+phone+" Hello Friend, I am referring you to " +
          "join Dream Bazzar " +
          " Download the Dream Bazzar application by clicking on the link -" +url;

      Share.share(str);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => MyBankDetailScreen(),
      //     ));
    },
    leading: Icon(Icons.wallet,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Refer',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget walletRepayment(context) {
  return ListTile(
    dense: true,
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletRepaymentScreen(),
          ));
    },
    leading: Icon(Icons.wallet,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Wallet RePayment',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget wallet(context) {
  return ListTile(
    dense: true,
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletScreen(),
          ));
    },
    leading: Icon(Icons.wallet,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Wallet',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget chatOnWhatsApp(context) {
  return ListTile(
    dense: true,
    onTap: () {
      //  Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => MyBankDetailScreen(),
      //   ));
    },
    leading: Icon(Icons.chat_bubble_rounded,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Chat on WhatsApp',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget myWishList(context) {
  return ListTile(
    dense: true,
    onTap: () {
      //  Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => MyBankDetailScreen(),
      //   ));
    },
    leading: Icon(Icons.favorite_border_rounded,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('My Wishlist',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget orders(context) {
  return ListTile(
    dense: true,
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderScreen(),
          ));
    },
    leading: Icon(Icons.person,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Orders',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget profile(context) {
  return ListTile(
    dense: true,
    onTap: () {
      //  Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => OrderScreen(),
      //     ));
    },
    leading: Icon(Icons.person,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Profile',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}

Widget home(context) {
  return ListTile(
    dense: true,
    onTap: () {
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashBoardScreen(),
          ));
    },
    leading: Icon(Icons.home_outlined,
        color: Colors.black38, size: Dimensions.ICON_SIZE_DEFAULT),
    title: Text('Home',
        style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w500)),
  );
}
