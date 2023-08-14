import 'package:flutter_sixvalley_ecommerce/data/model/response/base/withdraw_list_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class WithdrawListBloc {
  final _withdrawList = PublishSubject<WithdrawListModel>();
  final _repository = Repository();
  Stream<WithdrawListModel> get withdrawListstream => _withdrawList.stream;

  Future withdrawListSink(String userid) async {
    final WithdrawListModel model = await _repository.onWithdrawList(userid);
    _withdrawList.sink.add(model);
  }

  void dispose() {
    _withdrawList.close();
  }

}

final withdrawListBloc = WithdrawListBloc();
