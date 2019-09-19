import 'package:beatmaker/sequencer/circle_progress_indicator.dart';
import 'package:beatmaker/sequencer/sequencer_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Draws a circular animated progress bar.
class PlayButton extends StatefulWidget {
  final Duration animationDuration;
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;

  final SequencerService sequencer = SequencerService();

  PlayButton({
    Key key,
    this.animationDuration,
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.value,
  }) : super(key: key);

  @override
  PlayButtonState createState() {
    return PlayButtonState();
  }
}

class PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _start() {
    widget.sequencer.startPlayer();
  }

  _stop() {
    widget.sequencer.stopPlayer();
  }

  _togglePlayback() {
    if (widget.sequencer.isPlaying) {
      _stop();
    } else {
      _start();
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _togglePlayback(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CircleProgressIndicator(percentage: _controller.value),
            Icon(
              widget.sequencer.isPlaying ? Icons.stop : Icons.play_arrow,
              color: Colors.white,
              size: 30,
            ),
          ],
        ));
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
