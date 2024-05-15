import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'passageiros_state.dart';

class PassageirosCubit extends Cubit<PassageirosState> {
  PassageirosCubit() : super(PassageirosInitial());
}
