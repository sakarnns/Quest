import 'package:quest_2/models/event_browse.dart';

EventBrowseDatas eventBrowseData = EventBrowseDatas();

class EventBrowseDatas {
  EventBrowseDatas? eventBrowseData;
  EventBrowse? _eventBrowse;

  EventBrowse? get eventBrowse => _eventBrowse;

  set eventBrowse(EventBrowse? eventBrowse) {
    _eventBrowse = eventBrowse;
  }
}
