class NetworkResponse {
  final bool isSuccess;
  dynamic responseData;
  String errorMessege;
  int statusCode;
  NetworkResponse(
      {required this.isSuccess,
        this.errorMessege = "Something went wrong!",
        this.responseData,
        required this.statusCode}
      );
}