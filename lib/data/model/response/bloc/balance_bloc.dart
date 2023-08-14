import 'package:flutter_sixvalley_ecommerce/data/model/response/base/balance_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class BalanceBloc {
  final _balancelist = PublishSubject<BalanceModel>();
  final _repository = Repository();
  Stream<BalanceModel> get bankListstream => _balancelist.stream;

  Future balancetSink(String userid) async {
    final BalanceModel model = await _repository.onBalance(userid);
    _balancelist.sink.add(model);
  }

  void dispose() {
    _balancelist.close();
  }
}

final balanceBloc = BalanceBloc();
