import 'dart:convert';

mixin MapSerialization {
  Map<String, dynamic> toMap();
}

mixin JsonSerialization {
  String toJSON();
}

mixin Serialization implements MapSerialization, JsonSerialization {
  @override
  String toJSON() => jsonEncode(toMap());
}
