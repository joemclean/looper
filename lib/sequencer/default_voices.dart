import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:beatmaker/sequencer/voice.dart';
import 'package:beatmaker/theme/splice/colors.dart';

class DefaultVoices {
  static List<Voice> voices = [drumVoice, bassVoice, synthVoice, fxVoice];

  static List<String> drumOptions = [
    "house_drums_0.wav",
    "house_drums_1.wav",
    "house_drums_2.wav",
    "house_drums_3.wav",
    "house_drums_4.wav",
  ];

  static List<String> bassOptions = [
    "house_bass_0.wav",
    "house_bass_1.wav",
    "house_bass_2.wav",
    "house_bass_3.wav",
    "house_bass_4.wav",
  ];

  static List<String> synthOptions = [
    "house_synth_0.wav",
    "house_synth_1.wav",
    "house_synth_2.wav",
    "house_synth_3.wav",
    "house_synth_4.wav",
  ];

  static List<String> fxOptions = [
    "house_fx_0.wav",
    "house_fx_1.wav",
    "house_fx_2.wav",
    "house_fx_3.wav",
    "house_fx_4.wav",
  ];

  // Initialize audio players for each voice
  static AudioPlayer drumPlayer = AudioPlayer();
  static AudioPlayer bassPlayer = AudioPlayer();
  static AudioPlayer synthPlayer = AudioPlayer();
  static AudioPlayer fxPlayer = AudioPlayer();

  static AudioCache drumPlayerCache = AudioCache(fixedPlayer: drumPlayer);
  static AudioCache bassPlayerCache = AudioCache(fixedPlayer: bassPlayer);
  static AudioCache synthPlayerCache = AudioCache(fixedPlayer: synthPlayer);
  static AudioCache fxPlayerCache = AudioCache(fixedPlayer: fxPlayer);

  // Generate the voices
  static Voice drumVoice = Voice(
    samples: drumOptions,
    name: "Drums",
    directory: "sounds/drums/",
    player: drumPlayer,
    playerCache: drumPlayerCache,
    activeColor: SDSColors.spliceYellow,
  );

  static Voice bassVoice = Voice(
    samples: bassOptions,
    name: "Bass",
    directory: "sounds/bass/",
    player: bassPlayer,
    playerCache: bassPlayerCache,
    activeColor: SDSColors.spliceRed,
  );

  static Voice synthVoice = Voice(
    samples: synthOptions,
    name: "Synth",
    directory: "sounds/synth/",
    player: synthPlayer,
    playerCache: synthPlayerCache,
    activeColor: SDSColors.splicePurple,
  );

  static Voice fxVoice = Voice(
    samples: fxOptions,
    name: "FX",
    directory: "sounds/fx/",
    player: fxPlayer,
    playerCache: fxPlayerCache,
    activeColor: SDSColors.spliceOrange,
  );
}
