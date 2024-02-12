bool matchUrl(String inputUrl, String expectedUrl) {
  Uri inputUri = Uri.parse(inputUrl);
  Uri expectedUri = Uri.parse(expectedUrl);

  if (inputUri.pathSegments.length != expectedUri.pathSegments.length) {
    return false;
  }

  for (int i = 0; i < inputUri.pathSegments.length; i++) {
    if (inputUri.pathSegments[i] != expectedUri.pathSegments[i]) {
      return false;
    }
  }

  return inputUri.queryParameters.isEmpty;
}
