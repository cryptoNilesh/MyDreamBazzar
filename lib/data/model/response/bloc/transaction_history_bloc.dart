import 'package:flutter_sixvalley_ecommerce/data/model/response/transaction_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class TransactionHistoryBloc {
  final _transactionHistory = PublishSubject<TransactionModel>();
  final _repository = Repository();
  Stream<TransactionModel> get transactionHistorystream =>
      _transactionHistory.stream;

  Future transactionHistorySink(String userid) async {
    // String token = 'Bearer "${PrefObj.preferences!.get(PrefKeys.TOKEN)}"';
    final TransactionModel model =
        await _repository.onTransactionHistory(userid);
    _transactionHistory.sink.add(model);
  }

  void dispose() {
    _transactionHistory.close();
  }
}

final transactionHistorybloc = TransactionHistoryBloc();
