import 'package:flutter_sixvalley_ecommerce/provider/balance_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/bank_add_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/bank_edit_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/bank_list_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/team_count_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/transaction_history_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wallet_add_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/withdraw_add_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/withdraw_list_provider.dart';

class Repository {
  //------------------------transaction History----------------------//

  final TransactionHistoryApi transactionHistory = TransactionHistoryApi();
  Future<dynamic> onTransactionHistory(String userid) =>
      transactionHistory.onTransactionHistoryApi(userid);

//------------------------Team Count----------------------//

  final TeamCountApi teamcount = TeamCountApi();
  Future<dynamic> onTeamCount(String phonenumber) =>
      teamcount.onTeamCountApi(phonenumber);

//------------------------Team Count----------------------//

  final WalletAddApi walletadd = WalletAddApi();
  Future<dynamic> onWalletAdd(String userid, String amount) =>
      walletadd.onWalletAddApi(userid, amount);

//---------------------Bank List-------------------------//

  final BankListApi banklist = BankListApi();
  Future<dynamic> onBankList(String userid) => banklist.onBankListApi(userid);

//---------------------Bank Add-------------------------//

  final BankAddApi bankadd = BankAddApi();
  Future<dynamic> onBankAdd(String accountname, String accountnumber,
          String ifsc, String extra, String extra2,String user_id) =>
      bankadd.onBankAddApi(accountname, accountnumber, ifsc, extra, extra2,user_id);

//---------------------Bank Edit-------------------------//

  final BankEditApi bankedit = BankEditApi();
  Future<dynamic> onBankEdit(String accountname, String accountnumber,
          String ifsc, String extra, String extra2,String user_id,String id) =>
      bankedit.onBankEditApi(accountname, accountnumber, ifsc, extra, extra2,user_id,id);

  //---------------------Withdraw List-------------------------//

  final WithdrawListApi withdrawlist = WithdrawListApi();
  Future<dynamic> onWithdrawList(String userid) =>
      withdrawlist.onWithdrawListApi(userid);

  //------------------------Withdral Add----------------------//

  final WithdralAddApi withdralAdd = WithdralAddApi();
  Future<dynamic> onWithdralAdd(String amount, String user) =>
      withdralAdd.onWithdralAddApi(amount,user);

  //--------------------- Balance -------------------------//

  final BalanceApi balance = BalanceApi();
  Future<dynamic> onBalance(String userid) => balance.onBalanceApi(userid);
}
