import 'dart:async';

import 'package:beatmaker/sequencer/default_voices.dart';
import 'package:beatmaker/sequencer/voice.dart';
import 'package:rxdart/rxdart.dart';

class SequencerService {
  Timer clock;
  final List<Voice> voices = DefaultVoices.voices;
  final BehaviorSubject<String> playerStream = new BehaviorSubject<String>();

  bool isPlaying = false;

  static final SequencerService _singleton = new SequencerService._internal();

  factory SequencerService() {
    return _singleton;
  }

  SequencerService._internal() {
    for (Voice voice in voices) {
      voice.loadSamples();
    }
  }

  stopPlayer() {
    isPlaying = false;
    voices.forEach((voice) => voice.stopSampleCycle());
    clock.cancel();
    playerStream.add("STOP");
  }

  startPlayer() {
    isPlaying = true;
    playScheduledLoops();
    clock = Timer(Duration(milliseconds: 4000), () => startPlayer());
    print("Start loop");
    playerStream.add("PLAY");
    playerStream.add("TOP_OF_CYCLE");
  }

  playScheduledLoops() {
    voices.forEach((Voice voice) => voice.startSampleCycle());
  }
}
