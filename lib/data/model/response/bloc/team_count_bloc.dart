import 'package:flutter_sixvalley_ecommerce/data/model/response/base/team_count_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class TeamCountBloc {
  final _teamcount = PublishSubject<TeamCountModel>();
  final _repository = Repository();
  Stream<TeamCountModel> get teamCountstream => _teamcount.stream;

  Future teamCountSink(String phonenumber) async {
    // String token = 'Bearer "${PrefObj.preferences!.get(PrefKeys.TOKEN)}"';
    print("Phone");
    print(phonenumber);
    final TeamCountModel model = await _repository.onTeamCount(phonenumber);
    _teamcount.sink.add(model);
  }

  void dispose() {
    _teamcount.close();
  }
}

final teamcountBloc = TeamCountBloc();
