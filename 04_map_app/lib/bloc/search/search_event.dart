part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}
class OnActivateManualMarker extends SearchEvent{}
class OnDesactivateManualMarker extends SearchEvent{}
class OnSaveToHistory extends SearchEvent{
  final SearchResult result;
  OnSaveToHistory(this.result);
}