import 'package:beatmaker/sequencer/pad.dart';
import 'package:beatmaker/sequencer/sequencer_service.dart';
import 'package:beatmaker/sequencer/voice.dart';
import 'package:beatmaker/theme/splice/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SceneEditor extends StatefulWidget {
  final SequencerService sequencer = SequencerService();
  SceneEditorState createState() => SceneEditorState();
}

class SceneEditorState extends State<SceneEditor> {
  Widget build(BuildContext context) {
    double tileSize = MediaQuery.of(context).size.width / 4;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildVoices(tileSize),
    );
  }

  List<Widget> _buildVoices(double tileSize) {
    List<Widget> voiceWidgets = [];
    for (Voice voice in widget.sequencer.voices) {
      voiceWidgets.add(
        Container(
          width: tileSize,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                width: tileSize,
                decoration: BoxDecoration(
                    color: SDSColors.gray80,
                    border: Border.all(color: Colors.black)),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        voice.name,
                        style: TextStyle(
                          color: SDSColors.gray20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //Mute Button
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                          width: tileSize,
                          color: voice.isMuted
                              ? SDSColors.gray80
                              : voice.activeColor,
                          padding: const EdgeInsets.all(10),
                          child: Icon(voice.isMuted
                              ? Icons.volume_mute
                              : Icons.volume_up)),
                      onTap: () => _toggleMute(voice),
                    ),
                  ],
                ),
              ),
              Column(children: _buildSamplePads(voice, tileSize)),
            ],
          ),
        ),
      );
    }
    return voiceWidgets;
  }

  List<Widget> _buildSamplePads(Voice voice, double tileSize) {
    //TODO this tile size thing is ridiculous
    List<Widget> pads = [];
    for (int i = 0; i < voice.samples.length; i++) {
      pads.add(Pad(
        index: i,
        voice: voice,
        size: tileSize,
      ));
    }
    return pads;
  }

  _toggleMute(Voice voice) {
    voice.toggleMute();
    setState(() {});
    print("detected");
  }
}
