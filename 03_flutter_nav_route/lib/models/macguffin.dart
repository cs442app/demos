class MacGuffin {
  String name;
  String? description;

  MacGuffin({required this.name, this.description});

  MacGuffin.from(MacGuffin other)
      : name = other.name,
        description = other.description;

  @override
  bool operator ==(Object other) {
    return other is MacGuffin &&
        other.name == name &&
        other.description == description;
  }
  
  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}
