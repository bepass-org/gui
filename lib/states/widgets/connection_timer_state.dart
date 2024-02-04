import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';


final timer_state_notifier =
StateNotifierProvider<ConnectionTimerState, String>((ref) {
  return ConnectionTimerState("");
});

class ConnectionTimerState extends StateNotifier<String> {
 late Timer _timer;
 Duration _duration = Duration.zero; // Initial duration

 ConnectionTimerState(super.state) {
   StartTimer();
  }

  set value(String value) => state = value;

  String get value => state;

  void ResetTimer(){
    _timer.cancel();
    // clear total duration
    _duration = Duration.zero;
    //update value to the init value
    value = "00 : 00 : 00";
  }

  // start timer
 // repeat every 1 second
 void StartTimer(){

   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
     //update total duration
     _duration += Duration(seconds: 1);
     value = _formatDuration(_duration);

   });
 }
  void setAndPersistValue(String current_time) {
    value = current_time;

  }

  // duration to String form [hour:minute:second]
 String _formatDuration(Duration duration) {
   // Format duration as hours:minutes:seconds
   String twoDigits(int n) => n.toString().padLeft(2, '0');
   final hours = twoDigits(duration.inHours);
   final minutes = twoDigits(duration.inMinutes.remainder(60));
   final seconds = twoDigits(duration.inSeconds.remainder(60));
   return '$hours : $minutes : $seconds';
 }
}
