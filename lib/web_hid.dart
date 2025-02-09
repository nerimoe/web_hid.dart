import 'dart:async';
import 'dart:html' show EventListener, EventTarget, Event;
import 'dart:js_util' show promiseToFuture;
import 'dart:typed_data';

import 'dart:js' show allowInterop;
import 'dart:js_util' as js_util;

import 'package:js/js.dart';

import 'src/js_facade.dart';

part 'src/web_hid_base.dart';

@JS('navigator.hid')
external EventTarget? get _hid;

bool canUseHid() => _hid != null;

Hid? _instance;
Hid get hid {
  if (_hid != null) {
    return _instance ??= Hid._(_hid!);
  }
  throw 'navigator.hid unavailable';
}

class HidReport {
  final int reportId;
  final List<int> data;
  HidReport(this.reportId, this.data);
}

typedef ReportListener = dynamic Function(HidReport report);
