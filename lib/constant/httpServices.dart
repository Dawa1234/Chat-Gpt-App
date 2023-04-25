class HttpServicesConfiguration {
  static Map<String, String> headers(String token) {
    return <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}
