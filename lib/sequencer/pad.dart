import 'package:beatmaker/screens/sample_selection_screen.dart';
import 'package:beatmaker/sequencer/circle_progress_indicator.dart';
import 'package:beatmaker/sequencer/sequencer_service.dart';
import 'package:beatmaker/sequencer/voice.dart';
import 'package:beatmaker/theme/splice/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Pad extends StatefulWidget {
  final int index;
  final Voice voice;
  final double size;

  Pad({
    @required this.index,
    @required this.voice,
    @required this.size,
  });
  PadState createState() => PadState();

  final SequencerService sequencer = SequencerService();
}

class PadState extends State<Pad> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    widget.sequencer.playerStream
        .listen((string) => _handleStreamEvent(string));
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..addListener(() => this.setState(() {}));
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handlePadTap(),
      onLongPress: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SampleSelectionView()),
      ),
      child: Container(
        alignment: Alignment.center,
        width: widget.size,
        height: widget.size,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: _getPadColor(widget.voice, widget.index),
            border: Border.all(color: Colors.black)),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: (widget.voice.activeSampleIndex == widget.index ||
                      widget.voice.scheduledIndex == widget.index)
                  ? CircleProgressIndicator(
                      percentage: _controller.value,
                      inverse: (widget.voice.activeSampleIndex != widget.index)
                          ? true
                          : false,
                    )
                  : Container(),
            ),
            Text(
              (widget.index + 1).toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPadColor(Voice voice, index) {
    Color padColor;
    if (voice.activeSampleIndex == index) {
      padColor = voice.activeColor;
    } else if (voice.scheduledIndex == index) {
      padColor = SDSColors.gray40;
    } else {
      padColor = SDSColors.gray80;
    }
    return padColor;
  }

  _handlePadTap() {
    widget.voice.handleChangeRequest(widget.index);
    //TODO yuckkk
    widget.sequencer.playerStream.add("VOICE_CHANGED");
    if (!widget.sequencer.isPlaying) {
      widget.sequencer.startPlayer();
    }
  }

  _handleStreamEvent(String string) {
    if (string == "TOP_OF_CYCLE") {
      print("Top of cycle recieved!");
      _controller.reset();
      _controller.forward();
    } else if (string == "STOP") {
      _controller.reset();
      _controller.stop();
    }
  }
}
