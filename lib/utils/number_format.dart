String formatNumber(int number) {
  if (number == 0) {
    return '0';
  } else if (number < 1000) {
    return number.toString();
  } else if (number < 1000000) {
    return '${(number / 1000).toStringAsFixed(1)}K';
  } else {
    return '${(number / 1000000).toStringAsFixed(1)}M';
  }
}
