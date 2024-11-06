class AppException implements Exception{

  final _message;
  final _prifix;
  AppException([this._message,this._prifix]);
  String string(){
    return '$_prifix,$_message';
  }

}
class NoInternetConnectionException extends AppException{
  NoInternetConnectionException([String? message]) :super(message,"No Internet connection");
}
class RequestTimeout extends AppException{
  RequestTimeout([String? message]) :super(message,"Request Time out");
}
class InternetServerException extends AppException{
  InternetServerException([String? message]) :super(message,"InternetServerException");
}
class UnAuthorization extends AppException {
  UnAuthorization([String? message])
      : super(message, "Your username and password incorrect!");
}
