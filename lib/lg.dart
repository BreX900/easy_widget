import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:intl/intl.dart' show DateFormat;

export 'package:logger/logger.dart';
export 'package:intl/intl.dart' show DateFormat;

class MagicPrinter extends LogPrinter {
  static final levelPrefixes = {
    Level.verbose: '[V]',
    Level.debug: '[D]',
    Level.info: '[I]',
    Level.warning: '[W]',
    Level.error: '[E]',
    Level.wtf: '[WTF]',
  };

  final DateFormat formatter;

  MagicPrinter({this.formatter});

  @override
  void log(LogEvent event) {
    final message = stringifyMessage(event.message);
    final error = event.error != null ? "  ERROR-> ${event.error}" : "";
    println("${levelPrefixes[event.level]} ${formatter.format(DateTime.now())} | $message$error");
  }

  String stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      final encoder = JsonEncodPetaer.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
