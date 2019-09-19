import 'package:beatmaker/theme/splice/colors.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

class Voice {
  final String name;

  bool isPlaying = false;

  final List<String> samples;
  int activeSampleIndex = 0;

  final String directory;

  AudioPlayer player;
  AudioCache playerCache;

  bool changeScheduled;
  int scheduledIndex = 0;

  bool isMuted = false;

  double volume = 1.0;

  Color activeColor;

  Voice({
    this.activeSampleIndex = 0,
    @required this.samples,
    @required this.name,
    @required this.directory,
    @required this.player,
    @required this.playerCache,
    this.activeColor = SDSColors.spliceYellow,
    this.changeScheduled = false,
  });

  void startSampleCycle() {
    changeSample(scheduledIndex);
    isPlaying = true;
    playerCache.play(directory + samples[activeSampleIndex], volume: volume);
  }

  void stopSampleCycle() {
    player.stop();
    isPlaying = false;
    changeSample(scheduledIndex);
  }

  handleChangeRequest(int index) {
    if (isPlaying) {
      scheduleChange(index);
    } else {
      changeSample(index);
    }
  }

  scheduleChange(index) {
    scheduledIndex = index;
    changeScheduled = true;
  }

  changeSample(index) {
    activeSampleIndex = index;
    scheduledIndex = index;
    changeScheduled = false;
  }

  toggleMute() {
    if (isMuted == false) {
      volume = 0.0;
      player.setVolume(volume);
      isMuted = true;
    } else {
      volume = 1.0;
      player.setVolume(volume);
      isMuted = false;
    }
    print("Muted? " + isMuted.toString());
  }

  loadSamples() {
    for (String sample in samples) {
      playerCache.load(directory + sample);
    }
  }

  unloadSamples() {
    playerCache.clearCache();
  }
}
