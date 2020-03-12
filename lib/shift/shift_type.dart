class ShiftType {
  int shiftId;
  String name;
  Duration start;
  Duration duration;
  bool active;

  ShiftType({
    this.shiftId,
    this.name,
    this.start,
    this.duration,
    this.active = true,
  });
}
