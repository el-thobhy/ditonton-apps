
String getFormattedDurationFromList(List<int> runtimes) =>
    runtimes.map((runtime) => getFormattedDuration(runtime)).join(", ");

String getFormattedDuration(int runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else {
    return '${minutes}m';
  }
}
