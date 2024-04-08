// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RecordSpeechToTextController with ChangeNotifier {
  late final RecorderController recorderController;
  final TextEditingController messageTextController =
      TextEditingController(); // Define the controller

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<String?> transcribeAudio(String filePath) async {
    try {
      // String apiUrl = 'https://api.openai.com/v1/audio/transcriptions';
      String apiUrl = 'https://api.openai.com/v1/audio/translations';
      const String apiKey =
          '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';
      var audioFile = File(filePath);
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..files.add(await http.MultipartFile.fromPath('file', audioFile.path))
        ..fields['model'] = 'whisper-1'
        ..headers['Authorization'] = 'Bearer $apiKey';

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);
        return jsonResponse['text'];
      } else {
        var errorResponse = await response.stream.bytesToString();
        print(
            'Failed to transcribe audio. Status code: ${response.statusCode}');
        print('Error response body: $errorResponse');
        return null;
      }
    } catch (e) {
      print('Error transcribing audio: $e');
      return null;
    }
  }

  // getDir() async {
  //   setLoading(true);
  //   appDirectory = await getApplicationDocumentsDirectory();
  //   path = "${appDirectory.path}/recording.m4a";
  //   isLoading = false;
  //   setLoading(false);
  //   notifyListeners();
  // }
  Future<void> getDir() async {
    setLoading(true);
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;
    setLoading(false);
    return Future.value(); // Ensure the method returns a future
  }

  Future<void> initialiseControllers() async {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
    setLoading(false);
    return Future.value(); // Ensure the method returns a future
  }

  void pickFile() async {
    setLoading(true);
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile = result.files.single.path;
      setLoading(false);
      notifyListeners();
    } else {
      debugPrint("File not picked");
    }
  }

  void startOrStopRecording() async {
    try {
      if (isRecording) {
        // Stop recording
        recorderController.reset();
        path = await recorderController.stop(false);
        if (path != null) {
          isRecordingCompleted = true;
          // Transcribe the recorded audio
          String? transcription = await transcribeAudio(path!);
          if (transcription != null) {
            // Handle the transcription here
            print('Transcription: $transcription');
          }
        }
      } else {
        // Start recording
        await recorderController.record(path: path);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isRecording = !isRecording;
      setLoading(false);
      notifyListeners();
    }
  }

  void refreshWave() {
    if (isRecording) recorderController.refresh();
  }
}
