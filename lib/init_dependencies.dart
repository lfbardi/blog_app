import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/data/datasource/auth_remote_data_source.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseURL,
    anonKey: AppSecrets.supabaseApiKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UserSignUp>(
    () => UserSignUp(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UserSignIn>(
    () => UserSignIn(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      getCurrentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}
