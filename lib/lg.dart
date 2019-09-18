import 'dart:convert';

import 'package:flutter/foundation.dart';
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

  MagicPrinter({@required this.formatter}) : assert(formatter != null);

  MagicPrinter.mode({bool debugMode: true})
      : assert(debugMode != null),
        this.formatter = debugMode ? DateFormat('mm:ss.SS') : DateFormat('yyyy/MM/dd mm:ss.SS');

  @override
  void log(LogEvent event) {
    final message = stringifyMessage(event.message);
    final error = event.error != null ? "  ERROR-> ${event.error}" : "";
    println("${levelPrefixes[event.level]} ${formatter.format(DateTime.now())} | $message$error");
  }

  String stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      final encoder = JsonEncoder.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
