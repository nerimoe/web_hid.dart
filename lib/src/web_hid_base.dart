part of '../web_hid.dart';

@JS('HID')
class Hid extends Delegate<EventTarget> {
  Hid._(super.delegate);

  Future<List<HidDevice>> requestDevice([RequestOptions? options]) {
    var promise =
        callMethod('requestDevice', [options ?? RequestOptions(filters: [])]);
    return promiseToFuture(promise).then((value) {
      return (value as List).map((e) => HidDevice._(e)).toList();
    });
  }

  Future<List<HidDevice>> getDevices() {
    var promise = callMethod('getDevices');
    return promiseToFuture(promise).then((value) {
      return (value as List).map((e) => HidDevice._(e)).toList();
    });
  }

  void subscribeConnect(EventListener listener) {
    delegate.addEventListener('connect', allowInterop(listener));
  }

  void unsubscribeConnect(EventListener listener) {
    delegate.removeEventListener('connect', allowInterop(listener));
  }

  void subscribeDisconnect(EventListener listener) {
    delegate.addEventListener('disconnect', allowInterop(listener));
  }

  void unsubscribeDisconnect(EventListener listener) {
    delegate.removeEventListener('disconnect', allowInterop(listener));
  }
}

@JS()
@anonymous
class RequestOptions {
  external factory RequestOptions({
    required List<dynamic> filters,
  });
}

@JS()
@anonymous
class RequestOptionsFilter {
  external factory RequestOptionsFilter(
      {int vendorId, int productId, int usagePage, int usage});
}

class HidDevice extends Delegate<EventTarget> {
  HidDevice._(super._delegate);

  Future<void> open() {
    var promise = callMethod('open');
    return promiseToFuture(promise);
  }

  Future<void> close() {
    var promise = callMethod('close');
    return promiseToFuture(promise);
  }

  Future<void> forget() {
    var promise = callMethod('forget');
    return promiseToFuture(promise);
  }

  Future<void> sendReport(int reportId, TypedData data) {
    var promise = callMethod('sendReport', [reportId, data]);
    return promiseToFuture(promise);
  }

  Future<void> sendFeatureReport(int reportId, TypedData data) {
    var promise = callMethod('sendFeatureReport', [reportId, data]);
    return promiseToFuture(promise);
  }

  Future<void> receiveFeatureReport(int reportId) {
    var promise = callMethod('receiveFeatureReport', [reportId]);
    return promiseToFuture(promise);
  }

  dynamic get opened {
    var property = getProperty('opened');
    return property;
  }

  dynamic get vendorId {
    var property = getProperty('vendorId');
    return property;
  }

  dynamic get productId {
    var property = getProperty('productId');
    return property;
  }

  dynamic get productName {
    var property = getProperty('productName');
    return property;
  }

  dynamic get collections {
    var property = getProperty('collections');
    return property;
  }

  void subscribeInputReport(ReportListener listener) {
    delegate.addEventListener('inputreport',
        allowInterop((Event event) => {_onInputReport(event, listener)}));
  }

  void unsubscribeInputReport(ReportListener listener) {
    delegate.removeEventListener('inputreport',
        allowInterop((Event event) => {_onInputReport(event, listener)}));
  }

  void _onInputReport(Event event, ReportListener listener) {
    var dataView = js_util.getProperty(event, "data");
    var reportId = js_util.getProperty(event, "reportId");
    var len = js_util.getProperty(dataView, "byteLength");
    List<int> data = [];
    for (int i = 0; i < len; i++) {
      var byte = js_util.callMethod(dataView, "getUint8", [i]);
      data.add(byte);
    }
    listener(HidReport(reportId, data));
  }
}
