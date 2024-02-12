final linkRegex = RegExp(
    r"^(?:(http|https|ftp):\/\/)[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]%@!\$&'\(\)\*\+,;=.]+$");
final shortCodeRegex = RegExp(r"^(?=.*[A-Za-z])[^-_][-\w]{3,25}$");
