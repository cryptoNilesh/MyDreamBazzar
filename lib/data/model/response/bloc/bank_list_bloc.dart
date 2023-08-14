import 'package:flutter_sixvalley_ecommerce/data/model/response/base/bank_list_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class BankListBloc {
  final _banklist = PublishSubject<BankListModel>();
  final _repository = Repository();
  Stream<BankListModel> get bankListstream => _banklist.stream;

  Future bankListSink(String userid) async {
    // String token = 'Bearer "${PrefObj.preferences!.get(PrefKeys.TOKEN)}"';
    final BankListModel model = await _repository.onBankList(userid);
    _banklist.sink.add(model);
  }

  void dispose() {
    _banklist.close();
  }
}

final banklistBloc = BankListBloc();
