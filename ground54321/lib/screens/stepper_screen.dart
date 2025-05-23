import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import '../providers/grounding_provider.dart';
import '../widgets/sense_card.dart';
import '../widgets/progress_indicator.dart';
import 'summary_screen.dart';

/// Screen guiding the user through each grounding step.
class StepperScreen extends ConsumerStatefulWidget {
  const StepperScreen({super.key});

  @override
  ConsumerState<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends ConsumerState<StepperScreen> {
  late stt.SpeechToText _speech;
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _playChime() async {
    await _player.play(AssetSource('sounds/chime.mp3'));
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(groundingProvider);
    final notifier = ref.read(groundingProvider.notifier);
    final step = notifier.stepIndex;
    final total = senses.length;
    final remaining = senseCounts[step] - (step < entries.length ? entries[step].items.length : 0);
    final sense = senses[step];

    return Scaffold(
      appBar: AppBar(title: const Text('Grounding')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            StepProgressIndicator(step: step, total: total),
            const SizedBox(height: 16),
            SenseCard(
              sense: sense,
              remaining: remaining,
              onSubmit: (value) {
                notifier.addItem(value);
                setState(() {});
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () async {
                    final available = await _speech.initialize();
                    if (available) {
                      _speech.listen(onResult: (res) {
                        if (res.finalResult) {
                          notifier.addItem(res.recognizedWords);
                          setState(() {});
                        }
                      });
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: remaining == 0
                      ? () {
                          if (step == total - 1) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const SummaryScreen(),
                              ),
                            );
                          } else {
                            notifier.nextStep();
                            _playChime();
                            setState(() {});
                          }
                        }
                      : null,
                  child: Text(step == total - 1 ? 'Finish' : 'Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
