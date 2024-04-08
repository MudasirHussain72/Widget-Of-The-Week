// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:provider/provider.dart';
import 'package:widget_of_the_week/components/textfield_widget.dart';
import 'package:widget_of_the_week/controllers/record_speech_to_text_controller.dart';

class RecordSpeechToText extends StatefulWidget {
  const RecordSpeechToText({super.key});

  @override
  State<RecordSpeechToText> createState() => _RecordSpeechToTextState();
}

class _RecordSpeechToTextState extends State<RecordSpeechToText> {
  // @override
  // void initState() {
  //   super.initState();
  //   var provider =
  //       Provider.of<RecordSpeechToTextController>(context, listen: false);
  //   provider.getDir();
  //   provider.initialiseControllers();
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     var provider =
  //         Provider.of<RecordSpeechToTextController>(context, listen: false);
  //     provider.getDir().then((_) {
  //       provider.initialiseControllers().then((_) {
  //         provider.setLoading(false);
  //       });
  //     });
  //   });
  // }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var provider =
          Provider.of<RecordSpeechToTextController>(context, listen: false);
      print("Before getDir()");
      provider.getDir().then((_) {
        print("After getDir()");
        provider.initialiseControllers().then((_) {
          print("After initialiseControllers()");
          provider.setLoading(false);
        });
      });
    });
  }

  @override
  void dispose() {
    var provider =
        Provider.of<RecordSpeechToTextController>(context, listen: false);
    provider.recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordSpeechToTextController>(
      builder: (context, provider, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Speech to Text',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  children: [
                    const Expanded(child: Text('')),
                    if (provider.isRecordingCompleted)
                      WaveBubble(
                        path: provider.path,
                        isSender: true,
                        appDirectory: provider.appDirectory,
                      ),
                    SafeArea(
                      child: Row(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: provider.isRecording
                                ? AudioWaveforms(
                                    enableGesture: true,
                                    size: Size(
                                        MediaQuery.of(context).size.width / 2,
                                        50),
                                    recorderController:
                                        provider.recorderController,
                                    waveStyle: const WaveStyle(
                                      waveColor: Colors.white,
                                      extendWaveform: true,
                                      showMiddleLine: false,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: const Color(0xFF1E1B26),
                                    ),
                                    padding: const EdgeInsets.only(left: 18),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                  )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E1B26),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.only(left: 18),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: "Type Something...",
                                        hintStyle: const TextStyle(
                                            color: Colors.white54),
                                        contentPadding:
                                            const EdgeInsets.only(top: 16),
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          onPressed: provider.pickFile,
                                          icon: Icon(Icons.adaptive.share),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          IconButton(
                            onPressed: provider.refreshWave,
                            icon: Icon(
                              provider.isRecording ? Icons.refresh : Icons.send,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: provider.startOrStopRecording,
                            icon: Icon(
                                provider.isRecording ? Icons.stop : Icons.mic),
                            color: Colors.black,
                            iconSize: 28,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool isLast;

  const ChatBubble({
    super.key,
    required this.text,
    this.isSender = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isSender) const Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSender
                        ? const Color(0xFF276bfd)
                        : const Color(0xFF343145)),
                padding: const EdgeInsets.only(
                    bottom: 9, top: 8, left: 14, right: 12),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
