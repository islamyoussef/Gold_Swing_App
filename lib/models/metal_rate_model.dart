//import 'dart:convert';
import 'package:hive/hive.dart';

// List<MetalRateModel> welcomeFromJson(String str) => List<MetalRateModel>.from(json.decode(str).map((x) => MetalRateModel.fromJson(x)));
//
// String metalRateModelToJson(List<MetalRateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// This code to make this model a hive Object
/* then write this command in terminal (flutter packages pub run build_runner build) */
part 'metal_rate_model.g.dart';
@HiveType(typeId: 0) // First type in the app
class MetalRateModel {
  @HiveField(0)
  late int timestamp;
  @HiveField(1)
  late String metal;
  @HiveField(2)
  String currency;
  @HiveField(3)
  late int openTime;
  @HiveField(4)
  late double price;
  @HiveField(5)
  late double ch;
  @HiveField(6)
  late double ask;
  @HiveField(7)
  late double bid;
  @HiveField(8)
  late double priceGram24K;
  @HiveField(9)
  late double priceGram22K;
  @HiveField(10)
  late double priceGram21K;
  @HiveField(11)
  late double priceGram20K;
  @HiveField(12)
  late double priceGram18K;
  @HiveField(13)
  late double priceGram16K;
  @HiveField(14)
  late double priceGram14K;
  @HiveField(15)
  late double priceGram10K;
  @HiveField(16)
  int recordID;
  @HiveField(17)
  String statusMsg;

  MetalRateModel({
    this.recordID = 0,
    this.statusMsg = '',
    this.currency = 'EGP',
    required this.timestamp,
    required this.metal,
    required this.openTime,
    required this.price,
    required this.ch,
    required this.ask,
    required this.bid,
    required this.priceGram24K,
    required this.priceGram22K,
    required this.priceGram21K,
    required this.priceGram20K,
    required this.priceGram18K,
    required this.priceGram16K,
    required this.priceGram14K,
    required this.priceGram10K,
  });

  factory MetalRateModel.fromJson(Map<String, dynamic> json) => MetalRateModel(
    recordID: 0,
    statusMsg: '',
    currency: json["currency"],
    timestamp: json["timestamp"],
    metal: json["metal"],
    openTime: json["open_time"],
    price: json["price"]?.toDouble(),
    ch: json["ch"]?.toDouble(),
    ask: json["ask"]?.toDouble(),
    bid: json["bid"]?.toDouble(),
    priceGram24K: json["price_gram_24k"]?.toDouble(),
    priceGram22K: json["price_gram_22k"]?.toDouble(),
    priceGram21K: json["price_gram_21k"]?.toDouble(),
    priceGram20K: json["price_gram_20k"]?.toDouble(),
    priceGram18K: json["price_gram_18k"]?.toDouble(),
    priceGram16K: json["price_gram_16k"]?.toDouble(),
    priceGram14K: json["price_gram_14k"]?.toDouble(),
    priceGram10K: json["price_gram_10k"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "recordID": recordID,
    "statusMsg": statusMsg,
    "currency": currency,
    "timestamp": timestamp,
    "metal": metal,
    "open_time": openTime,
    "price": price,
    "ch": ch,
    "ask": ask,
    "bid": bid,
    "price_gram_24k": priceGram24K,
    "price_gram_22k": priceGram22K,
    "price_gram_21k": priceGram21K,
    "price_gram_20k": priceGram20K,
    "price_gram_18k": priceGram18K,
    "price_gram_16k": priceGram16K,
    "price_gram_14k": priceGram14K,
    "price_gram_10k": priceGram10K,
  };
}