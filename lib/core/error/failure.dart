import 'package:freezed_annotation/freezed_annotation.dart';
part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.serverError(
      {@Default("Server Error occurred") String message}) = ServerError;
  const factory Failure.unknownError(
      {@Default("Unknown Error occurred") String message}) = UnknownError;
}


