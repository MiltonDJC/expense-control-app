extension StringFormatter on String {
  String get capitalize {
    if (this.isEmpty) return this;
    return this
        .split(' ')
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(' ')
        .toString();
  }
}
