// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metal_rate_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MetalRateModelAdapter extends TypeAdapter<MetalRateModel> {
  @override
  final int typeId = 0;

  @override
  MetalRateModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetalRateModel(
      timestamp: fields[0] as int,
      metal: fields[1] as String,
      currency: fields[2] as String,
      openTime: fields[3] as int,
      price: fields[4] as double,
      ch: fields[5] as double,
      ask: fields[6] as double,
      bid: fields[7] as double,
      priceGram24K: fields[8] as double,
      priceGram22K: fields[9] as double,
      priceGram21K: fields[10] as double,
      priceGram20K: fields[11] as double,
      priceGram18K: fields[12] as double,
      priceGram16K: fields[13] as double,
      priceGram14K: fields[14] as double,
      priceGram10K: fields[15] as double,
      recordID: fields[16] as int,
      statusMsg: fields[17] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MetalRateModel obj) {
    writer
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.metal)
      ..writeByte(2)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.openTime)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.ch)
      ..writeByte(6)
      ..write(obj.ask)
      ..writeByte(7)
      ..write(obj.bid)
      ..writeByte(8)
      ..write(obj.priceGram24K)
      ..writeByte(9)
      ..write(obj.priceGram22K)
      ..writeByte(10)
      ..write(obj.priceGram21K)
      ..writeByte(11)
      ..write(obj.priceGram20K)
      ..writeByte(12)
      ..write(obj.priceGram18K)
      ..writeByte(13)
      ..write(obj.priceGram16K)
      ..writeByte(14)
      ..write(obj.priceGram14K)
      ..writeByte(15)
      ..write(obj.priceGram10K)
      ..writeByte(16)
      ..write(obj.recordID)
      ..writeByte(17)
      ..write(obj.statusMsg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetalRateModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
