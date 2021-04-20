import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class TalkingDataAppAnalytics {
  static const MethodChannel _channel =
      MethodChannel('TalkingData_AppAnalytics');

  static Future<String?> getDeviceID() => _channel.invokeMethod('getDeviceID');

  static Future<String?> getOAID() async {
    if (Platform.isAndroid) {
      return await _channel.invokeMethod('getOAID');
    }
    return null;
  }

  static Future<void> onPageStart(String pageName) async {
    return await _channel
        .invokeMethod('onPageStart', <String, dynamic>{'pageName': pageName});
  }

  static Future<void> onPageEnd(String pageName) => _channel.invokeMethod(
        'onPageEnd',
        <String, dynamic>{'pageName': pageName},
      );

  static Future<void> onEvent({
    required String eventID,
    String? eventLabel,
    Map<String, dynamic>? params,
  }) async {
    return await _channel.invokeMethod('onEvent', <String, dynamic>{
      'eventID': eventID,
      'eventLabel': eventLabel,
      'params': params
    });
  }

  static Future<void> onEventWithValue({
    required String eventID,
    String? eventLabel,
    Map<String, dynamic>? params,
    double? value,
  }) async {
    return await _channel.invokeMethod('onEventWithValue', <String, dynamic>{
      'eventID': eventID,
      'eventLabel': eventLabel,
      'params': params,
      'value': value
    });
  }

  static Future<void> setGlobalKV(String key, Object value) async {
    return await _channel.invokeMethod(
        'setGlobalKV', <String, dynamic>{'key': key, 'value': value});
  }

  static Future<void> removeGlobalKV(String key) async {
    return await _channel
        .invokeMethod('removeGlobalKV', <String, dynamic>{'key': key});
  }

  static Future<void> onRegister({
    required String profileID,
    required ProfileType profileType,
    required String name,
  }) async {
    return await _channel.invokeMethod('onRegister', <String, dynamic>{
      'profileID': profileID,
      'profileType': profileType.toString().split('.')[1],
      'name': name
    });
  }

  static Future<void> onLogin({
    required String profileID,
    required ProfileType profileType,
    required String name,
  }) async {
    return await _channel.invokeMethod('onLogin', <String, dynamic>{
      'profileID': profileID,
      'profileType': profileType.toString().split('.')[1],
      'name': name
    });
  }

  static Future<void> onPlaceOrder({
    required String profileID,
    required Order order,
  }) async {
    return await _channel.invokeMethod('onPlaceOrder', <String, dynamic>{
      'profileID': profileID,
      'orderID': order.orderID,
      'totalPrice': order.totalPrice,
      'currencyType': order.currencyType,
      'orderDetails': order._orderDetails
    });
  }

  static Future<void> onOrderPaySucc(
      {required String profileID,
      required String payType,
      required Order order}) async {
    return await _channel.invokeMethod('onOrderPaySucc', <String, dynamic>{
      'profileID': profileID,
      'payType': payType,
      'orderID': order.orderID,
      'totalPrice': order.totalPrice,
      'currencyType': order.currencyType,
      'orderDetails': order._orderDetails
    });
  }

  static Future<void> onAddItemToShoppingCart({
    required String itemId,
    required String category,
    required String name,
    required int unitPrice,
    required int amount,
  }) =>
      _channel.invokeMethod('onAddItemToShoppingCart', <String, dynamic>{
        'itemID': itemId,
        'category': category,
        'name': name,
        'unitPrice': unitPrice,
        'amount': amount
      });

  static Future<void> onViewItem({
    required String itemId,
    required String category,
    required String name,
    required int unitPrice,
  }) =>
      _channel.invokeMethod('onViewItem', <String, dynamic>{
        'itemID': itemId,
        'category': category,
        'name': name,
        'unitPrice': unitPrice
      });

  static Future<void> onViewShoppingCart(ShoppingCart shoppingCart) async {
    return await _channel.invokeMethod('onViewShoppingCart', <String, dynamic>{
      'shoppingCartDetails': shoppingCart._shoppingCartDetails
    });
  }
}

enum ProfileType {
  ANONYMOUS, // 匿名
  REGISTERED, // 自有帐户显性注册
  SINA_WEIBO, // 新浪微博
  QQ, // QQ账号
  QQ_WEIBO, // QQ微博账号
  ND91, // 网龙91
  WEIXIN, //微信账号
  TYPE1, //
  TYPE2, //
  TYPE3, //
  TYPE4, //
  TYPE5, //
  TYPE6, //
  TYPE7, //
  TYPE8, //
  TYPE9, //
  TYPE10 //
}

class Order {
  Order({
    required this.orderID,
    required this.totalPrice,
    required this.currencyType,
  });

  final String orderID;
  final int totalPrice;
  final String currencyType;

  List<Map<String, dynamic>> _orderDetails = <Map<String, dynamic>>[];

  addItem(String id, String category, String name, int unitPrice, int amount) {
    _orderDetails.add(<String, dynamic>{
      'id': id,
      'category': category,
      'name': name,
      'unitPrice': unitPrice,
      'amount': amount,
    });
  }
}

class ShoppingCart {
  ShoppingCart();

  List<Map<String, dynamic>> _shoppingCartDetails = <Map<String, dynamic>>[];

  addItem(
    String itemID,
    String category,
    String name,
    int unitPrice,
    int amount,
  ) {
    _shoppingCartDetails.add(<String, dynamic>{
      'itemId': itemID,
      'category': category,
      'name': name,
      'unitPrice': unitPrice,
      'amount': amount,
    });
  }
}
