import 'package:bloc/bloc.dart';

part 'passageiros_state.dart';

class PassageirosCubit extends Cubit<PassageirosState> {
  final List<String> _listaPassageiros = [];

  List<String> get listaPassageiros => _listaPassageiros;

  PassageirosCubit() : super(PassageirosInitial());

  Future<void> salvarPassageiro (String passageiro) async {
    //emit(state);
    _listaPassageiros.add(passageiro);
    emit(PassageirosSave(_listaPassageiros));
  }
}
