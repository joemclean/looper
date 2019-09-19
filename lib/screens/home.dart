import 'package:beatmaker/sequencer/play_button.dart';
import 'package:beatmaker/sequencer/scene_editor.dart';
import 'package:beatmaker/sequencer/sequencer_service.dart';
import 'package:beatmaker/theme/splice/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SequencerService sequencer = SequencerService();

  @override
  void dispose() {
    super.dispose();
    sequencer.stopPlayer();
  }

  @override
  void initState() {
    super.initState();
    sequencer.playerStream.listen((string) => _handleStreamEvent(string));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: SDSColors.gray90,
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: <Widget>[
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                PlayButton(
                  backgroundColor: SDSColors.gray80,
                  foregroundColor: SDSColors.white,
                  value: 1,
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            SceneEditor(),
          ],
        ),
      ),
    );
  }

  //TODO Yikes
  _handleStreamEvent(String string) {
    setState(() {});
    // if (string == "VOICE_CHANGED") {
    //   setState(() {});
    // }
  }
}
