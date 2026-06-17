
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/features/%20forecast/presentation/forecost_event.dart';

import 'forecost_state.dart';



class ForecostblocBloc extends Bloc<ForecostEvent, ForecostState> {
  ForecostblocBloc() : super(ForecostInitial()) {
    on<ForecostEvent>((event, emit) {

    });
  }
}
