part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseURL,
    anonKey: AppSecrets.supabaseApiKey,
  );

  await _initBlogHive();

  serviceLocator.registerLazySingleton(() => supabase.client);

  _initAuth();
  _initBlog();

  //core
  serviceLocator.registerLazySingleton<AppUserCubit>(() => AppUserCubit());
  serviceLocator.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(InternetConnection()),
  );
}

Future<void> _initBlogHive() async {
  await Hive.initFlutter();
  final blogsBox = await Hive.openBox('blogs');

  serviceLocator.registerLazySingleton<Box<dynamic>>(
    () => blogsBox,
  );
}

void _initAuth() {
  serviceLocator
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    ..registerLazySingleton<UserSignUp>(
      () => UserSignUp(serviceLocator()),
    )
    ..registerLazySingleton<UserSignIn>(
      () => UserSignIn(serviceLocator()),
    )
    ..registerLazySingleton<GetCurrentUser>(
      () => GetCurrentUser(serviceLocator()),
    )
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        getCurrentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    ..registerLazySingleton<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerLazySingleton<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(serviceLocator()),
    )
    ..registerLazySingleton<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerLazySingleton<UploadBlog>(
      () => UploadBlog(serviceLocator()),
    )
    ..registerLazySingleton<GetAllBlogs>(
      () => GetAllBlogs(serviceLocator()),
    )
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
