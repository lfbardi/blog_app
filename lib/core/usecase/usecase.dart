import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

abstract interface class UserCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}
