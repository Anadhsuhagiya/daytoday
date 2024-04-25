import 'package:flutter/services.dart';

Future<void> lightImpact() async {
  await SystemChannels.platform.invokeMethod<void>(
    'HapticFeedback.vibrate',
    'HapticFeedbackType.lightImpact',
  );
}

Future<void> heavyImpact() async {
  await SystemChannels.platform.invokeMethod<void>(
    'HapticFeedback.vibrate',
    'HapticFeedbackType.heavyImpact',
  );
}
