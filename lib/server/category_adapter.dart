import 'package:hive/hive.dart';
import 'package:fivehoursapp/models/expence.dart';

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 2;

  @override
  Category read(BinaryReader reader) {
    // TODO: implement the logic to read Category data from the reader
    return Category.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    // TODO: implement the logic to write Category data to the writer
    writer.writeByte(obj.index);
  }
}
