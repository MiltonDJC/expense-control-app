extension StringFormatter on String {
  String get capitalize {
    if (this.isEmpty) return this;
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
