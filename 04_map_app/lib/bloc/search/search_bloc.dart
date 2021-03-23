import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:map_app/models/search_result.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event,) async* {
    if (event is OnActivateManualMarker) {
      yield state.copyWith(manualSelection: true);
    }else if(event is OnDesactivateManualMarker){
      yield state.copyWith(manualSelection: false);
    }else if(event is OnSaveToHistory){
      final exist = state.history.where(
        (element) => element.destinationPosition == event.result.destinationPosition
      ).length;
      if (exist == 0) {        
        final currentHistory = [...state.history, event.result];
        yield state.copyWith(history: currentHistory);
      }
    }
  }
}
