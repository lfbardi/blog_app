import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';

class GetCurrentUser implements UserCase<User, NoParams> {
  final AuthRepository authRepository;

  GetCurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}
