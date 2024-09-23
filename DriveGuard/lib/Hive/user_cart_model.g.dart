// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCartAdapter extends TypeAdapter<UserCart> {
  @override
  final int typeId = 1;

  @override
  UserCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCart()
      ..user_id = fields[0] as String
      ..cart_items = (fields[1] as List).cast<CartItem>()
      ..total_price_of_cart = fields[2] as double;
  }

  @override
  void write(BinaryWriter writer, UserCart obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.user_id)
      ..writeByte(1)
      ..write(obj.cart_items)
      ..writeByte(2)
      ..write(obj.total_price_of_cart);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
